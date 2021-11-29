//
//  AddTrackController.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
import SnapKit
import AWSMobileClient

import MJRefresh
class AddTrackController: ViewController {
    var accountNameTextField : UITextField?
    var roninTextField : UITextField?
    var managerPercentTextField : UITextField?
    var scholarpercentageLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Track account"
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
    
    func updateTextField(textField:UITextField,focus:Bool)  {
        if focus {
            textField.layer.borderColor = UIColor.init(hexString: "0xB85050").cgColor
        }else{
            textField.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        }
    }
    
    
    func valifyAccount() -> Bool{
        if self.accountNameTextField!.text == nil || self.accountNameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Account name should be filled in")
            self.updateTextField(textField: self.accountNameTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.accountNameTextField!, focus: false)
            return true
        }
    }
    
    func valifyRonin() -> Bool{
        if self.roninTextField!.text == nil || self.roninTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Ronin address should be filled in")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else if !self.roninTextField!.text!.starts(with: "0x") && !self.roninTextField!.text!.starts(with: "ronin:"){
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else if self.roninTextField!.text!.count != 42 &&  self.roninTextField!.text!.count != 46{
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.roninTextField!, focus: false)
            return true
        }
    }
    
    func valifyPercent() -> Bool{
        if self.managerPercentTextField!.text == nil || self.managerPercentTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Manager percentage should be filled in")
            self.updateTextField(textField: self.managerPercentTextField!, focus: true)
            return false
        }else{
            let percent : Float = Float(self.managerPercentTextField!.text!)!
            if percent < 0.00 || percent > 100.00 {
                self.showNoticeLabel(notice: "Manager Percentage must be a number from 0 to 100")
                self.updateTextField(textField: self.managerPercentTextField!, focus: false)
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
        DataManager.sharedInstance.createTracker(accountName: accountNameTextField!.text!, ronin_address: roninTextField!.text!, manager_percentage: Float(managerPercentTextField!.text!)!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    if !result.msg!.isBlank {
                        GFAlert.showAlert(titleStr: "Notice:", msgStr: result.msg!, currentVC: self, cancelStr: "OK", cancelHandler: { action in
                            
                        }, otherBtns: nil) { index in
                            
                        }
                    }
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

extension  AddTrackController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
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
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  ronin:5550fc7bbe0126d5d31d347ae584fdd8906af29f", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.roninTextField = tempCell.textFild
        cell = tempCell
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Manager percentage", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.managerPercentTextField = tempCell.textFild
        tempCell.textFild?.keyboardType = .numberPad
        cell = tempCell
    case 3:
        let tempCell : LabelAndLabelCell = tableView.dequeueReusableCell(withIdentifier: labelAndLabelCellIdentifier + "3", for: indexPath) as! LabelAndLabelCell
        tempCell.leftLabel.text = "  Scholar percentage"
        tempCell.rightLabel.text = "0%    "
        self.scholarpercentageLabel = tempCell.rightLabel
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}
