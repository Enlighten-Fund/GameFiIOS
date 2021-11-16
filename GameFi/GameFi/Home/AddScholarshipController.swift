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
import SCLAlertView
import MJRefresh
class AddScholarshipController: ViewController {
    var accountNameTextField : UITextField?
    var roninTextField : UITextField?
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var managerPercentTextField : UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Post my scholarship"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
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
            self.noticeLabel?.numberOfLines = 0
            self.noticeLabel?.text = ""
        }
    }
    
    
    @objc func addScholarship(){
        if !self.valifyAccount() {
            return
        }
        if !self.valifyRonin() {
            return
        }
        if !self.valifyEmail() {
            return
        }
        if !self.valifyPassword() {
            return
        }
        if !self.valifyPercentage() {
            return
        }
//        var params = ["account_login" : self.accountNameTextField?.text,
//                      "account_passcode" : self.passwordTextField?.text,
//                      "account_ronin_address":self.roninTextField?.text,
//                      "scholar_percentage":self.managerPercentTextField?.text,
//                      "offer_period":
//                     ]
        
    }
    
    func valifyAccount() -> Bool {
        var temp = false
        if self.accountNameTextField!.validateUsername() {
            temp = true
        }else if self.accountNameTextField!.validateEmail(){
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "Account name should be filled in")
            return false
        }
        self.hideNoticeLabel()
        return true
    }
    
    func valifyRonin() -> Bool {
        var temp = false
//        if self.roninTextField!.validateRonin() {
//            temp = true
//        }
        if !temp {
            self.showNoticeLabel(notice: "The format is ronin:xxxxxxx")
            return false
        }
        self.hideNoticeLabel()
        return true
    }
    
    func valifyEmail() -> Bool {
        var temp = false
        if self.emailTextField!.validateEmail() {
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "The email format is ")
            return false
        }
        self.hideNoticeLabel()
        return true
    }
    
    func valifyPassword() -> Bool {
        var temp = false
        if self.passwordTextField!.validatePassword() {
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "The password format is ")
            return false
        }
        self.hideNoticeLabel()
        return true
    }
    
    func valifyPercentage() -> Bool {
        var temp = false
        if self.managerPercentTextField!.validatePassword() {
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "The percentage format is ")
            return false
        }
        self.hideNoticeLabel()
        return true
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        let footView = PostScholarFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 60))
        footView.cancelBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        footView.postBtn.addTarget(self, action: #selector(addScholarship), for: .touchUpInside)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "3")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "4")
        tempTableView.register(PostScholarshipCell.classForCoder(), forCellReuseIdentifier: postScholarshipCellIdentifier + "5")
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

extension  AddScholarshipController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
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
        return true
    }
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.accountNameTextField{
            self.valifyAccount()
        }else if textField == self.roninTextField{
            self.valifyRonin()
        }else if textField == self.emailTextField{
            self.valifyEmail()
        }else if textField == self.passwordTextField{
            self.valifyPassword()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 6
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 100
        }
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
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Ronin address: 550fc6aee0126b5d31d347…", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.roninTextField = tempCell.textFild
        cell = tempCell
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Email address", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.emailTextField = tempCell.textFild
        cell = tempCell
    case 3:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "3", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Email password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.passwordTextField = tempCell.textFild
        cell = tempCell
    case 4:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "4", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Manager percentage", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.managerPercentTextField = tempCell.textFild
        cell = tempCell
    case 5:
        let tempCell : PostScholarshipCell = tableView.dequeueReusableCell(withIdentifier: postScholarshipCellIdentifier + "5", for: indexPath) as! PostScholarshipCell
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}
