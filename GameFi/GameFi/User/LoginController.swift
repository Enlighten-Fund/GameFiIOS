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
import SCLAlertView

class LoginController: UIViewController {
    var usernameTextField : UITextField?
    var passwordTextField : UITextField?
    var footView : LoginFootView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    

    @objc func forgetPwdBtnClick() {
        self.navigationController?.pushViewController(ForgetPasswordController.init(), animated: true)
    }
    
    
    @objc func registerBtnClick() {
        self.navigationController?.pushViewController(RegisterController.init(), animated: true)
    }
    
    //登录
    @objc func loginBtnClick(){
        var temp = false
        if usernameTextField!.validateUsername() {
            temp = true
        }else if usernameTextField!.validateEmail(){
            temp = true
        }
        var usernameNotice = ""
        if !temp {
            usernameNotice = "Please enter a valid username"
            self.usernameModel.tip = usernameNotice
            self.usernameModel.text = self.usernameTextField!.text!
            let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
            return
        }
        self.usernameModel.tip = usernameNotice
        self.usernameModel.text = self.usernameTextField!.text!
        let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
        DispatchQueue.main.async {
            self.tableView!.reloadRows(at: [indexPath], with: .none)
        }
        
        let temp1 = self.passwordTextField!.validatePassword()
        var passwordNotice = ""
        if !temp1 {
            passwordNotice = "Please enter a valid password"
            self.passwordModel.tip = passwordNotice
            self.passwordModel.text = passwordTextField!.text!
            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
            return
        }
        self.passwordModel.tip = passwordNotice
        self.passwordModel.text = passwordTextField!.text!
        let indexPath1: IndexPath = IndexPath.init(row: 1, section: 0)
        DispatchQueue.main.async {
            self.tableView!.reloadRows(at: [indexPath1], with: .none)
        }
        
        self.mc_loading()
        AWSMobileClient.default().signIn(username: (self.usernameTextField?.text)!, password: (self.passwordTextField?.text)!) { (signInResult, error) in
            DispatchQueue.main.async {
                self.mc_remove()
                if let error = error  {
                    print("\(error.localizedDescription)")
                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                } else if let signInResult = signInResult {
                    switch (signInResult.signInState) {
                    case .signedIn:
                        print("User is signed in.")
                        SCLAlertView.init().showError("系统提示：", subTitle: "登录成功")
                        self.navigationController?.popToRootViewController(animated: true)
                        AWSMobileClient.default().getUserAttributes { [self]attributes, error in
                            if(error != nil){
                                print("ERROR: \(error)")
                            }else{
                                if let attributesDict = attributes{
                                    if attributesDict["custom:gfrole"] != nil {
                                        Usermodel.shared.gfrole = attributesDict["custom:gfrole"]!
                                    }
                                }
                            }
                        }
                    case .smsMFA:
                        print("SMS message sent to \(signInResult.codeDetails!.destination!)")
                        SCLAlertView.init().showError("系统提示：", subTitle: "\(signInResult.codeDetails!.destination!)")
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
        let headerView = LoginHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 100))
        tempTableView.tableHeaderView = headerView
        let footView = LoginFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 200))
        footView.scholarBtn.isSelected = true
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
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
    lazy var usernameModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Account", text: "", tip: "")
    }()
    
    lazy var passwordModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Password", text: "", tip: "")
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
        if textField.tag == 10001{
            var temp = false
            if textField.validateUsername() {
                temp = true
            }else if textField.validateEmail(){
                temp = true
            }
            var usernameNotice = ""
            if !temp {
                usernameNotice = "Please enter a valid username"
            }
            self.usernameModel.tip = usernameNotice
            self.usernameModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
        }else if textField.tag == 10002{
            let temp = textField.validatePassword()
            var passwordNotice = ""
            if !temp {
                passwordNotice = "Please enter a valid password"
            }else{
                passwordNotice = ""
            }
            self.passwordModel.tip = passwordNotice
            self.passwordModel.text = textField.text!
            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
            DispatchQueue.main.async {
                self.tableView!.reloadRows(at: [indexPath], with: .none)
            }
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
        tempCell.textFild?.tag = 10001
        self.usernameTextField = tempCell.textFild
        tempCell.textFild?.placeholder = "Please enter 5 to 16 alphanumeric characters or underscores"
        tempCell.update(model: self.usernameModel)
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.delegate = self
        tempCell.textFild?.tag = 10002
        tempCell.textFild?.placeholder = "Please enter a 6-20 digit password with at least two of letters, numbers and symbols"
        self.passwordTextField = tempCell.textFild
        tempCell.update(model: self.passwordModel)
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
        cell.contentView.backgroundColor = .lightGray
       return cell
   }
}
