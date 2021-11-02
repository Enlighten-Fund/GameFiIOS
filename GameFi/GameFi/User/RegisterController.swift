//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import AmplifyPlugins
import AWSPluginsCore
import Amplify
import MCToast
import SCLAlertView

class RegisterController: UIViewController {
    var emailTextField : UITextField?
    var usernameTextField : UITextField?
    var passwordTextField : UITextField?
    var codeTextField : UITextField?
    var footView : RegisterFootView?
    var codeLabel : UILabel?
    var role : Int = 1 //1代表scholar 2 代表manager
    var privacySelect = false
    var privacyLabel : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func loginBtnClick(btn:UIButton) {
        let loginVC = LoginController.init()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func codeBtnClick(btn:UIButton) {
        self.emailTextField?.resignFirstResponder()
        self.usernameTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        let textField : UITextField? = self.emailTextField
        let temp = textField!.validateEmail()
        var emailNotice = ""
        if !temp {
            emailNotice = "Please enter a valid email"
             self.emailModel.tip = emailNotice
             self.emailModel.text = textField!.text!
             let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
             DispatchQueue.main.async {
                 self.tableView!.reloadRows(at: [indexPath], with: .none)
             }
             return
         }
        let temp2 = self.usernameTextField!.validateUsername()
        var usernameNotice = ""
        if !temp2 {
            usernameNotice = "Please enter a valid username"
            self.usernameModel.tip = usernameNotice
            self.usernameModel.text = self.usernameTextField!.text!
            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
            return
        }
        let temp3 = self.passwordTextField!.validatePassword()
        var passwordNotice = ""
        if !temp3 {
            passwordNotice = "Please enter a valid password"
            self.passwordModel.tip = passwordNotice
            self.passwordModel.text = self.passwordTextField!.text!
            let indexPath2: IndexPath = IndexPath.init(row: 2, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath2], with: .none)
            }
            return
        }
        //本地验证通过
        //按钮先不可用
        DispatchQueue.main.async {
            btn.isEnabled = false
        }
        let userAttributes = [AuthUserAttribute(.email, value: (self.emailTextField?.text)!)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        mc_loading()
        Amplify.Auth.signUp(username: (self.usernameTextField?.text)!, password: self.passwordTextField!.text, options: options) {  result in
            self.mc_remove()
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    DispatchQueue.main.async {
                        self.codeModel.tip = "Enter the confirmation code we sent to " + (self.emailTextField?.text)!
                        self.codeModel.text = self.codeTextField!.text!
                        self.codeLabel?.text = self.codeModel.tip
                        self.codeLabel?.isHidden = false
                        
                        var countDownNum = 120
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            if countDownNum == 0 {
                                  // 销毁计时器
                                timer.invalidate()
                                btn.isEnabled = true
                                btn.setTitle("send", for: .normal)
                                print(">>> Timer has Stopped!")
                            } else {
                                print(">>> Countdown Number: \(countDownNum)")
                                countDownNum -= 1
                                btn.setTitle(String(countDownNum), for: .normal)
                               
                        }
                        }
                    }

                    
                } else {
                    print("SignUp Complete")
                    DispatchQueue.main.async {
                        SCLAlertView.init().showError("系统提示：", subTitle: "SignUp Complete")
                        btn.isEnabled = true
                    }
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                DispatchQueue.main.async {
                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                    btn.isEnabled = true
                }
            }
        }
    }
    
    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
    
    func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    @objc func scholarBtnClick() {
        self.footView?.scholarBtn.isSelected = true
        self.footView?.managerBtn.isSelected = false
        self.role = 1
    }
    
    @objc func managerBtnClick() {
        self.footView?.scholarBtn.isSelected = false
        self.footView?.managerBtn.isSelected = true
        self.role = 2
    }
    @objc func privacyBtnClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
        self.privacySelect = !self.privacySelect
    }
    
    @objc func registerBtnClick(){
        self.emailTextField?.resignFirstResponder()
        self.usernameTextField?.resignFirstResponder()
        self.passwordTextField?.resignFirstResponder()
        self.codeTextField?.resignFirstResponder()
        //先本地校验
        let textField : UITextField? = self.emailTextField
        let temp = textField!.validateEmail()
        var emailNotice = ""
        if !temp {
            emailNotice = "Please enter a valid email"
             self.emailModel.tip = emailNotice
             self.emailModel.text = textField!.text!
             let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
             DispatchQueue.main.async {
                 self.tableView!.reloadRows(at: [indexPath], with: .none)
             }
             return
         }
        let temp2 = self.usernameTextField!.validateUsername()
        var usernameNotice = ""
        if !temp2 {
            usernameNotice = "Please enter a valid username"
            self.usernameModel.tip = usernameNotice
            self.usernameModel.text = self.usernameTextField!.text!
            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
            return
        }
        let temp3 = self.passwordTextField!.validatePassword()
        var passwordNotice = ""
        if !temp3 {
            passwordNotice = "Please enter a valid password"
            self.passwordModel.tip = passwordNotice
            self.passwordModel.text = self.passwordTextField!.text!
            let indexPath2: IndexPath = IndexPath.init(row: 2, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath2], with: .none)
            }
            return
        }
        
        var codeNotice = ""
        var temp4 = ""
        if self.codeTextField!.text == nil {
            temp4 = ""
        }else{
            temp4 = codeTextField!.text!
        }
        
        if (temp4.isBlank) {
            codeNotice = "Please enter a valid code"
            self.codeModel.tip = codeNotice
            self.codeModel.text = codeTextField!.text!
            let indexPath: IndexPath = IndexPath.init(row: 3, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
            return
        }
        
        if !self.privacySelect {
            self.privacyLabel?.shake(direction: .horizontal, times: 2, interval: 0.1, offset: 5, completion: {
                
            })
            return
        }
        
        //本地验证通过
        self.mc_loading()
        Amplify.Auth.confirmSignUp(for: (self.usernameTextField?.text)!, confirmationCode: (self.codeTextField?.text)!) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                Amplify.Auth.signIn(username: self.usernameTextField?.text, password: self.passwordTextField?.text) { result in
                    switch result {
                    case .success:
                        print("Sign in succeeded")
                        Amplify.Auth.fetchAuthSession { result in
                            self.mc_remove()
                            do {
                                let session = try result.get()

                                // Get user sub or identity id
                                if let identityProvider = session as? AuthCognitoIdentityProvider {
                                    let usersub = try identityProvider.getUserSub().get()
                                    let identityId = try identityProvider.getIdentityId().get()
                                    print("User sub - \(usersub) and identity id \(identityId)")
                                }

                                // Get aws credentials
                                if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider {
                                    let credentials = try awsCredentialsProvider.getAWSCredentials().get()
                                    print("Access key - \(credentials.accessKey) ")
                                }

                                // Get cognito user pool token
                                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                                    print("Id token - \(tokens.idToken) ")
                                }

                            } catch {
                                self.mc_remove()
                                print("Fetch auth session failed with error - \(error)")
                                self.mc_text("\(error)")
                            }
                        }
                    case .failure(let error):
                        self.mc_remove()
                        print("Sign in failed \(error)")
                        self.mc_text("\(error)")
                    }
                }
            case .failure(let error):
                self.mc_remove()
                self.mc_text("\(error)")
                print("An error occurred while confirming sign up \(error)")
            }
        }
        
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = .lightGray
        let headerView = RegisterHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 100))
        headerView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        tempTableView.tableHeaderView = headerView
        let footView = RegisterFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 150))
        self.footView = footView
        footView.scholarBtn.addTarget(self, action: #selector(scholarBtnClick), for: .touchUpInside)
        footView.scholarTitleBtn.addTarget(self, action: #selector(scholarBtnClick), for: .touchUpInside)
        footView.managerBtn.addTarget(self, action: #selector(managerBtnClick), for: .touchUpInside)
        footView.managerTitleBtn.addTarget(self, action: #selector(managerBtnClick), for: .touchUpInside)
        footView.privacyBtn.addTarget(self, action: #selector(privacyBtnClick), for: .touchUpInside)
        footView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        self.privacyLabel = footView.privacyLabel
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
    
    lazy var emailModel : LabelTFTipModel = {
        
        return LabelTFTipModel.init(title: "Email", text: "", tip: "")
    }()
    
    lazy var usernameModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Username", text: "", tip: "")
    }()
    
    lazy var passwordModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Password", text: "", tip: "")
    }()
    
    lazy var codeModel : LabelTFTipModel = {
        LabelTFTipModel.init(title: "code", text: "", tip: "")
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
        if textField.tag == 10001{
            let temp = textField.validateEmail()
            var emailNotice = ""
            if !temp {
               emailNotice = "Please enter a valid email"
            }
            self.emailModel.tip = emailNotice
            self.emailModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
        }else if textField.tag == 10002{
            let temp = textField.validateUsername()
            var usernameNotice = ""
            if !temp {
                usernameNotice = "Please enter a valid username"
            }
            self.usernameModel.tip = usernameNotice
            self.usernameModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
        }else if textField.tag == 10003{
            let temp = textField.validatePassword()
            var passwordNotice = ""
            if !temp {
                passwordNotice = "Please enter a valid password"
            }else{
                passwordNotice = ""
            }
            self.passwordModel.tip = passwordNotice
            self.passwordModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 2, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
        }else if textField.tag == 10004{
            var codeNotice = ""
            var temp = ""
            if textField.text == nil {
                temp = ""
            }else{
                temp = textField.text!
            }
            
            if (temp.isBlank) {
                codeNotice = "Please enter a valid code"
            }
            self.codeModel.tip = codeNotice
            self.codeModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 3, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
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
        tempCell.textFild?.keyboardType = .emailAddress
        tempCell.textFild?.tag = 10001
        self.emailTextField = tempCell.textFild
        tempCell.update(model: self.emailModel)
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.tag = 10002
        self.usernameTextField = tempCell.textFild
        tempCell.update(model: self.usernameModel)
        cell = tempCell
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.delegate = self
        tempCell.textFild?.tag = 10003
        self.passwordTextField = tempCell.textFild
        tempCell.update(model: self.passwordModel)
        cell = tempCell
    case 3:
        let tempCell : ConfirmCodeCell = tableView.dequeueReusableCell(withIdentifier: confirmCodeCellIdentifier, for: indexPath) as! ConfirmCodeCell
        self.codeTextField = tempCell.textFild
        self.codeTextField?.tag = 10004
        self.codeLabel = tempCell.tipLabel
        tempCell.textFild?.delegate = self
        tempCell.titleLabel?.numberOfLines = 2
        tempCell.codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        tempCell.update(model: self.codeModel)
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
        cell.contentView.backgroundColor = .lightGray
       return cell
   }
        
       
}
