//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit
import MCToast
import SCLAlertView
import AWSMobileClient

class ForgetPwdController: ViewController {
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var codeTextField : UITextField?
    var codeBtn : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forget password"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview()
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
    
    @objc func loginBtnClick(btn:UIButton) {
        let loginVC = LoginController.init()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func stopTimerAndUpdateCodeBtn() {
        self.timer.invalidate()
        self.codeBtn?.isEnabled = true
        self.codeBtn?.setTitle("Send code", for: .normal)
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
    
    func valifyEmail() -> Bool {
        if self.emailTextField!.text == nil || self.emailTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Your email should be filled in")
            self.updateTextField(textField: self.emailTextField!, focus: true)
            return false
        }else{
            if self.emailTextField!.validateEmail(){
                self.hideNoticeLabel()
                self.updateTextField(textField: self.emailTextField!, focus: false)
                return true
            }else {
                self.showNoticeLabel(notice: "Your email format is incorrect")
                self.updateTextField(textField: self.emailTextField!, focus: true)
                return false
            }
        }
    }
    
    
    func valifyPassword() -> Bool {
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
    
    func valifyCode() -> Bool {
        if self.codeTextField!.text == nil || self.codeTextField!.text!.isBlank{
            self.showNoticeLabel(notice: "Your code format is incorrect")
            self.updateTextField(textField: self.codeTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.codeTextField!, focus: false)
            return true
        }
    }
    
    func fireTimerAndShowAlert(title:String) {
        DispatchQueue.main.async {
            self.timer.fire()
            SCLAlertView.init().showInfo("系统提示", subTitle: title)
        }
    }
    
    @objc func codeBtnClick(btn:UIButton) {
        self.emailTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        ///先本地校验
        if !self.valifyEmail() {
            return
        }
        if !self.valifyPassword() {
            return
        }
        //本地验证通过
        //按钮先不可用
        DispatchQueue.main.async {
            btn.isEnabled = false
        }
        mc_loading()
        AWSMobileClient.default().forgotPassword(username: (self.emailTextField?.text)!) { (forgotPasswordResult, error) in
            self.mc_remove()
            if let forgotPasswordResult = forgotPasswordResult {
                switch(forgotPasswordResult.forgotPasswordState) {
                case .confirmationCodeSent:
                    print("Confirmation code sent via \(forgotPasswordResult.codeDeliveryDetails!.deliveryMedium) to: \(forgotPasswordResult.codeDeliveryDetails!.destination!)")
                    self.fireTimerAndShowAlert(title: "A verification code has been sent via \(forgotPasswordResult.codeDeliveryDetails!.deliveryMedium) at \(forgotPasswordResult.codeDeliveryDetails!.destination!)")
                default:
                    print("Error: Invalid case.")
                }
            } else if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
            }
        }
    }
    
   
    
    @objc func resetPwdBtnClick(btn:UIButton){
        self.emailTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        //先本地校验
        if !self.valifyEmail() {
            return
        }
        if !self.valifyPassword() {
            return
        }
        if !self.valifyCode() {
            return
        }
        
        //本地验证通过
        self.mc_loading()
        AWSMobileClient.default().confirmForgotPassword(username: (self.emailTextField?.text)!, newPassword: (self.passwordTextField?.text)!, confirmationCode: (self.codeTextField?.text)!) { (forgotPasswordResult, error) in
            DispatchQueue.main.async {
                if let forgotPasswordResult = forgotPasswordResult {
                    switch(forgotPasswordResult.forgotPasswordState) {
                    case .done:
                        print("Password changed successfully")
                        AWSMobileClient.default().signIn(username: (self.emailTextField?.text)!, password: (self.passwordTextField?.text)!) { (signInResult, error) in
                            DispatchQueue.main.async {
                                self.mc_remove()
                                if let error = error  {
                                    print("\(error.localizedDescription)")
                                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                                } else if let signInResult = signInResult {
                                    switch (signInResult.signInState) {
                                    case .signedIn:
                                        UserManager.sharedInstance.updateToken {
                                            
                                        }
                                        UserManager.sharedInstance.fetchAndUpdateRole()
                                        SCLAlertView.init().showError("系统提示：", subTitle: "修改密码并登录成功")
                                        self.navigationController?.popToRootViewController(animated: true)
                                    case .smsMFA:
                                        print("SMS message sent to \(signInResult.codeDetails!.destination!)")
                                        SCLAlertView.init().showError("系统提示：", subTitle: "\(signInResult.codeDetails!.destination!)")
                                    default:
                                        print("Sign In needs info which is not et supported.")
                                    }
                                }
                            }
                            
                        }
                    default:
                        self.mc_remove()
                        print("Error: Could not change password.")
                    }
                } else if let error = error {
                    self.mc_remove()
                    DispatchQueue.main.async {
                        print("Error occurred: \(error.localizedDescription)")
                        SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                        self.stopTimerAndUpdateCodeBtn()
                    }
                    
                }

            }
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        let headerView = RegisterHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 80))
        headerView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        headerView.welcomeLabel?.text = "Forget password?"
        tempTableView.tableHeaderView = headerView
        let submitView = SubmitView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 80))
        submitView.submitBtn.addTarget(self, action: #selector(resetPwdBtnClick), for: .touchUpInside)
        tempTableView.tableFooterView = submitView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(ConfirmCodeCell.classForCoder(), forCellReuseIdentifier: confirmCodeCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
    lazy var timer : Timer = {
        var countDownNum = 120
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            DispatchQueue.main.async{
                if countDownNum == 0 {
                    // 销毁计时器
                    timer.invalidate()
                    self.codeBtn!.isEnabled = true
                    self.codeBtn!.setTitle("Send code", for: .normal)
                    
                  print(">>> Timer has Stopped!")
                } else {
                    print(">>> Countdown Number: \(countDownNum)")
                    countDownNum -= 1
                    self.codeBtn!.setTitle(String(countDownNum), for: .normal)
                }
            }
            
        }
        // 设置宽容度
        countdownTimer.tolerance = 0.2
        // 添加到当前 RunLoop，mode为默认。
        RunLoop.current.add(countdownTimer, forMode: .default)
        return countdownTimer
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

extension  ForgetPwdController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
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
        if textField == self.passwordTextField{
            self.valifyPassword()
        }else if textField == self.emailTextField{
            self.valifyEmail()
        }else if textField == self.codeTextField{
            self.valifyCode()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 3
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
        tempCell.textFild?.keyboardType = .emailAddress
        self.emailTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter email", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.isSecureTextEntry = true
        tempCell.textFild?.delegate = self
        self.passwordTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    case 2:
        let tempCell : ConfirmCodeCell = tableView.dequeueReusableCell(withIdentifier: confirmCodeCellIdentifier, for: indexPath) as! ConfirmCodeCell
        self.codeTextField = tempCell.textFild
        self.codeBtn = tempCell.codeBtn
        tempCell.textFild?.delegate = self
        tempCell.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter code", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
        
       
}
