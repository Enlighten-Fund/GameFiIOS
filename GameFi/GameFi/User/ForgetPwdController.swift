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
        self.title = "forget password"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func loginBtnClick(btn:UIButton) {
        let loginVC = LoginController.init()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func stopTimerAndUpdateCodeBtn() {
        self.timer.invalidate()
        self.codeBtn?.isEnabled = true
        self.codeBtn?.setTitle("send", for: .normal)
    }
    
    @objc func codeBtnClick(btn:UIButton) {
        self.emailTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        let textField : UITextField? = self.emailTextField
        let temp = textField!.validateEmail()
        
        
        let temp3 = self.passwordTextField!.validatePassword()
        
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
                    self.timer.fire()
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
        let textField : UITextField? = self.emailTextField
        let temp = textField!.validateEmail()
        

 
        let temp1 = self.passwordTextField!.validatePassword()
        
        
        var temp4 = ""
        if self.codeTextField!.text == nil {
            temp4 = ""
        }else{
            temp4 = codeTextField!.text!
        }
        
        if (temp4.isBlank) {
            DispatchQueue.main.async {SCLAlertView.init().showError("title", subTitle: "code is blank")}
            return
        }
        
        //本地验证通过
        self.mc_loading()
        AWSMobileClient.default().confirmForgotPassword(username: (self.emailTextField?.text)!, newPassword: (self.passwordTextField?.text)!, confirmationCode: (self.codeTextField?.text)!) { (forgotPasswordResult, error) in
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
                                    print("User is signed in.")
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
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        let headerView = RegisterHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 100))
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
                    self.codeBtn!.setTitle("send", for: .normal)
                    
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
        if textField.tag == 10001{
            let temp = textField.validateEmail()
            
        }else if textField.tag == 10002{
            let temp = textField.validatePassword()
            
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
        tempCell.textFild?.tag = 10001
        self.emailTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "Enter email", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.delegate = self
        tempCell.textFild?.tag = 10002
        self.passwordTextField = tempCell.textFild
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "Enter password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    case 2:
        let tempCell : ConfirmCodeCell = tableView.dequeueReusableCell(withIdentifier: confirmCodeCellIdentifier, for: indexPath) as! ConfirmCodeCell
        self.codeTextField = tempCell.textFild
        self.codeTextField?.tag = 10003
        tempCell.textFild?.delegate = self
        tempCell.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "Enter code", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
        
       
}
