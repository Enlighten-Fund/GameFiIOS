//
//  EditTrackController.swift
//  GameFi
//
//  Created by harden on 2021/11/16.
//

import Foundation
import UIKit
import SnapKit
import AWSMobileClient
import SCLAlertView
import MJRefresh

class EditTrackController: ViewController {
    var accountNameTextField : UITextField?
    var roninTextField : UITextField?
    var managerPercentTextField : UITextField?
    var scholarpercentageLabel : UILabel?
    var trackModel : TrackModel?
    
    init(trackModel:TrackModel) {
        super.init(nibName: nil, bundle: nil)
        self.trackModel = trackModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit track account"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview()
        }
        self.noticeLabel!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(45)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview()
        }
        self.noticeLabel?.isHidden = true
    }
    
    
    func showNoticeLabel(notice:String){
        DispatchQueue.main.async {
            self.noticeLabel?.text = notice
            self.noticeLabel?.isHidden = false
        }
    }
    
    func hideNoticeLabel(){
        DispatchQueue.main.async {
            self.noticeLabel?.isHidden = true
            self.noticeLabel?.text = ""
        }
    }
    
    
    func valifyAccount() -> Bool{
        if self.accountNameTextField!.text == nil || self.accountNameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Account name should be filled in")
            return false
        }else{
            self.hideNoticeLabel()
            return true
        }
    }
    
    func valifyRonin() -> Bool{
        if self.roninTextField!.text == nil || self.roninTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Ronin address should be filled in")
            return false
        }else if !self.roninTextField!.text!.starts(with: "0x") && !self.roninTextField!.text!.starts(with: "ronin:"){
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            return false
        }else if self.roninTextField!.text!.count != 42 &&  self.roninTextField!.text!.count != 46{
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            return false
        }else{
            self.hideNoticeLabel()
            return true
        }
    }
    
    func valifyPercent() -> Bool{
        if self.managerPercentTextField!.text == nil || self.managerPercentTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Manager percentage should be filled in")
            return false
        }else{
            let percent : Float = Float(self.managerPercentTextField!.text!)!
            if percent < 0.00 || percent > 100.00 {
                self.showNoticeLabel(notice: "Manager percentage format is 0.00-100.00,Two significant decimals are supported")
                return false
            }else{
                return true
            }
        }
    }
    
    @objc func addTrack(){
        if !self.valifyAccount() {
            return
        }
        if !self.valifyRonin() {
            return
        }
        if !self.valifyPercent() {
            return
        }
        self.mc_loading()
        DataManager.sharedInstance.editTracker(accountName: accountNameTextField!.text!, ronin_address: roninTextField!.text!, manager_percentage: Float(managerPercentTextField!.text!)!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        let footView = SubmitView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 40))
        footView.submitBtn.addTarget(self, action: #selector(addTrack), for: .touchUpInside)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
        tempTableView.register(LabelAndLabelCell.classForCoder(), forCellReuseIdentifier: labelAndLabelCellIdentifier + "3")
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.backgroundColor = self.view.backgroundColor
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
    lazy var noticeLabel: UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.backgroundColor = UIColor(red: 0.96, green: 0.3, blue: 0.3, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 0
        view.addSubview(tempLabel)
        return tempLabel
    }()
}

extension  EditTrackController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    func isValid(checkStr:String, regex:String) ->Bool{

          let predicte = NSPredicate(format:"SELF MATCHES %@", regex)

          return predicte.evaluate(with: checkStr)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.text != nil else {
                return true
            }
            //新输入的
            if string.count == 0 {
                return true
            }
            
        if string.isBlank {
            return false
        }
        
        if self.managerPercentTextField == textField {
            //第一个参数，被替换字符串的range

            //第二个参数，即将键入或者粘贴的string

            //返回的是改变过后的新str，即textfield的新的文本内容

            let checkStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

            //正则表达式（只支持两位小数）

            let regex = "^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$"

             //判断新的文本内容是否符合要求

           return self.isValid(checkStr: checkStr!, regex: regex)
        }
        

        return true
    }
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.accountNameTextField{
            self.valifyAccount()
        }else if textField == self.roninTextField{
            self.valifyRonin()
        }else if textField == self.managerPercentTextField{
            if self.valifyPercent(){
                let str = String(format: "%.2f", 100 - Float(textField.text!)!)
                self.scholarpercentageLabel!.text = "\(str)%    "
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 4
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    switch indexPath.row {
    case 0:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "0", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        self.accountNameTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Account name", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
        accountNameTextField?.text = trackModel?.name
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Ronin address", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.roninTextField = tempCell.textFild
        cell = tempCell
        roninTextField?.text = trackModel?.ronin_address
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Manager percentage", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.managerPercentTextField = tempCell.textFild
        tempCell.textFild?.keyboardType = .numberPad
        cell = tempCell
        let str = String(format: "%.2f", 100 - Float(trackModel!.scholar_percentage!)!)
        managerPercentTextField!.text = str
    case 3:
        let tempCell : LabelAndLabelCell = tableView.dequeueReusableCell(withIdentifier: labelAndLabelCellIdentifier + "3", for: indexPath) as! LabelAndLabelCell
        tempCell.leftLabel.text = "  Scholar percentage"
        self.scholarpercentageLabel = tempCell.rightLabel
        cell = tempCell
        scholarpercentageLabel!.text = "\(trackModel!.scholar_percentage!)%    "
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}
