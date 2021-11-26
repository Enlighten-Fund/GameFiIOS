//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit
import AWSMobileClient
import MJRefresh

//定义
typealias LoginSuccessBlock = ()->Void
class LoginController: ViewController {
    var usernameTextField : UITextField?
    var passwordTextField : UITextField?
    var footView : LoginFootView?
    var loginSuccessBlock:LoginSuccessBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in"
        self.leftBtn?.isHidden = false
        self.msgBtn?.isHidden = true
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
    
    func valifyAccount() -> Bool {
        if self.usernameTextField!.text == nil || self.usernameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Your email or username should be filled in")
            self.updateTextField(textField: self.usernameTextField!, focus: true)
            return false
        }else{
            var temp = false
            if self.usernameTextField!.validateUsername() {
                temp = true
            }else if self.usernameTextField!.validateEmail(){
                temp = true
            }
            if !temp {
                self.showNoticeLabel(notice: "Your email or username format is incorrect")
                self.updateTextField(textField: self.usernameTextField!, focus: true)
                return false
            }
            
            self.hideNoticeLabel()
            self.updateTextField(textField: self.usernameTextField!, focus: false)
            return true
        }
    }
    
    func valifyPassword() -> Bool {
        if self.passwordTextField!.text == nil || self.passwordTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Your password should be filled in")
            self.updateTextField(textField: self.passwordTextField!, focus: true)
            return false
        }else{
            if self.passwordTextField!.validatePassword() {
                self.hideNoticeLabel()
                self.updateTextField(textField: self.passwordTextField!, focus: false)
                return true
            }else{
                self.showNoticeLabel(notice: "Your password format is incorrect")
                self.updateTextField(textField: self.passwordTextField!, focus: true)
                return false
            }
        }
    }
    
    @objc func forgetPwdBtnClick() {
        self.navigationController?.pushViewController(ForgetPwdController.init(), animated: true)
    }
    
    
    @objc func registerBtnClick() {
        self.navigationController?.pushViewController(RegisterController.init(), animated: true)
    }
    
    //登录
    @objc func loginBtnClick(){
        UIApplication.shared.keyWindow?.endEditing(true)
        if !self.valifyAccount() {
            return
        }
        if !self.valifyPassword() {
            return
        }
        self.mc_loading()
        AWSMobileClient.default().signIn(username: (self.usernameTextField?.text)!, password: (self.passwordTextField?.text)!) { (signInResult, error) in
            DispatchQueue.main.async {
                self.mc_remove()
                if let error = error  {
                    print("\(error)")
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "\(error)", currentVC: self, cancelBtn: "OK", cancelHandler: { action in
                        
                    }, otherBtns: nil) { index in
                        
                    }
//                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                } else if let signInResult = signInResult {
                    switch (signInResult.signInState) {
                    case .signedIn:
                        print("User is signed in.")
                        UserManager.sharedInstance.updateToken {
                            UserManager.sharedInstance.fetchAndUpdateRole {
                                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CHANGEROLE_NOFI), object: String(UserManager.sharedInstance.currentRole()))
                                DispatchQueue.main.async {
                                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "Sign in success", currentVC: self, cancelBtn: "OK", cancelHandler: { alertion in
                                        if self.loginSuccessBlock != nil{
                                            self.loginSuccessBlock!()
                                        }
                                    }, otherBtns: nil) { index in
                                        
                                    }
                                }
                            }
                        }
                        
                    default:
                        print("Sign In needs info which is not et supported.")
                    }
                }
            }
            
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = .lightGray
        let headerView = LoginHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 60))
        tempTableView.tableHeaderView = headerView
        let footView = LoginFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 200))
        self.footView = footView
        footView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        footView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        footView.forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClick), for: .touchUpInside)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
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

extension  LoginController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
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
        if textField == self.usernameTextField{
            self.valifyAccount()
        }else if textField == self.passwordTextField{
            self.valifyPassword()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 2
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
        self.usernameTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter email", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.isSecureTextEntry = true
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.passwordTextField = tempCell.textFild
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}
