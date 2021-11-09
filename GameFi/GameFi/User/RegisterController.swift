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
import MCToast
import SCLAlertView

class RegisterController: ViewController {
    var emailTextField : UITextField?
    var usernameTextField : UITextField?
    var passwordTextField : UITextField?
    var codeTextField : UITextField?
    var codeBtn : UIButton?
    var footView : RegisterFootView?
    var role : Int = 1 //1代表scholar 2 代表manager
    var privacySelect = false
    var privacyBtn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign up"
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    @objc func loginBtnClick(btn:UIButton) {
        let loginVC = LoginController.init()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func scholarBtnClick() {
        self.footView?.scholarTitleBtn.isSelected = true
        self.footView?.managerTitleBtn.isSelected = false
        self.role = 1
        self.footView?.scholarTitleBtn.layer.borderColor = UIColor.init(hexString: "#5D8FFF").cgColor
        self.footView?.managerTitleBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func managerBtnClick() {
        self.footView?.scholarTitleBtn.isSelected = false
        self.footView?.managerTitleBtn.isSelected = true
        self.role = 2
        self.footView?.managerTitleBtn.layer.borderColor = UIColor.init(hexString: "#5D8FFF").cgColor
        self.footView?.scholarTitleBtn.layer.borderColor = UIColor.white.cgColor
    }
    @objc func privacyBtnClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
        self.privacySelect = !self.privacySelect
    }
    
    func fireTimerAndShowAlert(title:String) {
        DispatchQueue.main.async {
            self.timer.fire()
            SCLAlertView.init().showInfo("系统提示", subTitle: title)
        }
    }
    
    func stopTimerAndUpdateCodeBtn() {
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.codeBtn?.isEnabled = true
            self.codeBtn?.setTitle("Send code", for: .normal)
        }
    }
    
    func valifyEmail() -> Bool {
        if self.emailTextField!.validateEmail(){
            self.hideNoticeLabel()
            return true
        }else {
            self.showNoticeLabel(notice: "Your email format is incorrect")
            return false
        }
    }
    
    func valifyUsername() -> Bool {
        if self.usernameTextField!.validateUsername(){
            self.hideNoticeLabel()
            return true
        }else {
            self.showNoticeLabel(notice: "Your username format is incorrect")
            return false
        }
    }
    
    func valifyPassword() -> Bool {
        if self.passwordTextField!.validatePassword() {
            self.hideNoticeLabel()
            return true
        }else{
            self.showNoticeLabel(notice: "Your password format is incorrect")
            return false
        }
    }
    
    func valifyCode() -> Bool {
        if self.codeTextField!.text == nil || ((self.codeTextField?.text?.isBlank) != nil){
            self.showNoticeLabel(notice: "Your code format is incorrect")
            return false
        }else{
            self.hideNoticeLabel()
            return true
        }
    }
    
    //发送验证码
    @objc func codeBtnClick(btn:UIButton) {
        self.emailTextField?.resignFirstResponder()
        self.usernameTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        if !self.valifyEmail() {
            return
        }
        if !self.valifyUsername() {
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
        AWSMobileClient.default().signUp(username: (self.usernameTextField?.text)!, password: self.passwordTextField!.text!,userAttributes: ["email":self.emailTextField!.text!]) { signUpResult, error in
            self.mc_remove()
            if let signUpResult = signUpResult {
                   switch(signUpResult.signUpConfirmationState) {
                   case .confirmed:
                       print("User is signed up and confirmed.")
                   case .unconfirmed:
                       print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                    self.fireTimerAndShowAlert(title: "A verification code has been sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) at \(signUpResult.codeDeliveryDetails!.destination!)")
                    
                   case .unknown:
                       print("Unexpected case")
                   }
               } else if let error = error {
                   if let error = error as? AWSMobileClientError {
                       switch(error) {
                       case .usernameExists(let message):
                           print(message)
                        DispatchQueue.main.async {
                            AWSMobileClient.default().resendSignUpCode(username: self.usernameTextField!.text!, completionHandler: { (result, error) in
                                if let signUpResult = result {
                                    print("A verification code has been sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) at \(signUpResult.codeDeliveryDetails!.destination!)")
                                    self.fireTimerAndShowAlert(title: "A verification code has been sent via \(signUpResult.codeDeliveryDetails!.deliveryMedium) at \(signUpResult.codeDeliveryDetails!.destination!)")
                                    
                                } else if let error = error {
                                    print("\(error.localizedDescription)")
                                }
                            })
                            
                        }
                       default:
                           break
                       }
                   }
               }
            
        }
    }
    
    
    
    @objc func registerBtnClick(){
        self.emailTextField?.resignFirstResponder()
        self.usernameTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        if !self.valifyEmail() {
            return
        }
        if !self.valifyUsername() {
            return
        }
        if !self.valifyPassword() {
            return
        }
        if !self.valifyCode() {
            return
        }
        
        if !self.privacySelect {
            self.privacyBtn?.shake(direction: .horizontal, times: 2, interval: 0.1, offset: 5, completion: {
                
            })
            return
        }
        
        //本地验证通过
        self.mc_loading()
        AWSMobileClient.default().confirmSignUp(username: (self.usernameTextField?.text)!, confirmationCode: (self.codeTextField?.text)!) { signUpResult, error in
            DispatchQueue.main.async {
                if let signUpResult = signUpResult {
                        switch(signUpResult.signUpConfirmationState) {
                        case .confirmed:
                            print("User is signed up and confirmed.")
                            AWSMobileClient.default().signIn(username: (self.usernameTextField?.text)!, password: (self.passwordTextField?.text)!) { (signInResult, error) in
                                self.mc_remove()
                                if let error = error  {
                                    print("\(error.localizedDescription)")
                                    DispatchQueue.main.async {SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")}
                                    
                                } else if let signInResult = signInResult {
                                    switch (signInResult.signInState) {
                                    case .signedIn:
                                        print("User is signed in.")
                                        self.mc_success("注册成功", duration: 0.2) {
                                            self.dismiss(animated: true) {
                                                
                                            }
                                        }
                                        
                                        Usermodel.shared.gfrole = String(self.role)
                                        AWSMobileClient.default().updateUserAttributes(attributeMap: ["custom:gfrole":String(self.role)]) { result, error in
                                            if let error = error  {
                                                print("\(error.localizedDescription)")
                                                DispatchQueue.main.async {SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")}
                                            }
                                        }
                                    default:
                                        print("Sign In needs info which is not et supported.")
                                    }
                                }
                            }
                        case .unconfirmed:
                            self.mc_remove()
                            print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                        case .unknown:
                            print("Unexpected case")
                            self.mc_remove()
                        }
                    } else if let error = error {
                        self.mc_remove()
                        if let error = error as? AWSMobileClientError {
                            switch(error) {
                            case .aliasExists(let message):
                                DispatchQueue.main.async {SCLAlertView.init().showError("系统提示：", subTitle: "\(message),please change another email")}
                            default:
                                DispatchQueue.main.async {SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")}
                                break
                            }
                        }
                        
                        DispatchQueue.main.async { [self] in
                            stopTimerAndUpdateCodeBtn()
                        }
                        print("\(error.localizedDescription)")
                        
                    }

            }
        }
        
    }
    
    @objc func privacy() {
        
    }
    
    @objc func service() {
        
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
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        let headerView = RegisterHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 90))
        headerView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        tempTableView.tableHeaderView = headerView
        let footView = RegisterFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 150))
        self.footView = footView
        footView.scholarTitleBtn.isSelected = true
        footView.scholarTitleBtn.addTarget(self, action: #selector(scholarBtnClick), for: .touchUpInside)
        footView.managerTitleBtn.addTarget(self, action: #selector(managerBtnClick), for: .touchUpInside)
        footView.privacyBtn.addTarget(self, action: #selector(privacyBtnClick), for: .touchUpInside)
        footView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        footView.privacyLabel2.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer.init(target: self, action:  #selector(privacy))
        footView.privacyLabel2.addGestureRecognizer(tap1)
        footView.privacyLabel4.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(service))
        footView.privacyLabel4.addGestureRecognizer(tap2)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
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
                    countDownNum -= 1
                    self.codeBtn!.setTitle(String(countDownNum), for: .normal)
                }
            }
            
        }
        self.timer = countdownTimer
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

extension  RegisterController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
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
            self.valifyUsername()
        }else if textField == self.passwordTextField{
            self.valifyPassword()
        }else if textField == self.emailTextField{
            self.valifyEmail()
        }else if textField == self.codeTextField{
            self.valifyCode()
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
        tempCell.textFild?.keyboardType = .emailAddress
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter email", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.emailTextField = tempCell.textFild

        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter username", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.usernameTextField = tempCell.textFild

        cell = tempCell
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.passwordTextField = tempCell.textFild
    
        cell = tempCell
    case 3:
        let tempCell : ConfirmCodeCell = tableView.dequeueReusableCell(withIdentifier: confirmCodeCellIdentifier, for: indexPath) as! ConfirmCodeCell
        self.codeTextField = tempCell.textFild
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Enter code", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.codeBtn = tempCell.codeBtn
        tempCell.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
        
       
}
