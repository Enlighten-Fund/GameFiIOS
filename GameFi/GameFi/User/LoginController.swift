//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit

class LoginController: UIViewController {
    var usernameTextField : UITextField?
    var passwordTextField : UITextField?
    var footView : LoginFootView?
    var role : Int = 1 //1代表scholar 2 代表manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = .lightGray
        let headerView = LoginHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 100))
        tempTableView.tableHeaderView = headerView
        let footView = LoginFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 150))
        self.footView = footView
        footView.scholarBtn.addTarget(self, action: #selector(scholarBtnClick), for: .touchUpInside)
        footView.scholarTitleBtn.addTarget(self, action: #selector(scholarBtnClick), for: .touchUpInside)
        footView.managerBtn.addTarget(self, action: #selector(managerBtnClick), for: .touchUpInside)
        footView.managerTitleBtn.addTarget(self, action: #selector(managerBtnClick), for: .touchUpInside)
        footView.registerLabel.yb_addAttributeTapAction(["Sign up"]) { (string, range, int) in
            self.navigationController?.pushViewController(RegisterController.init(), animated: true)
        }
//        footView.privacyBtn.addTarget(self, action: #selector(privacyBtnClick), for: .touchUpInside)
//        footView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
    lazy var usernameModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Username", text: "", tip: "")
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
//            let temp = textField.validateEmail()
//            var emailNotice = ""
//            if !temp {
//               emailNotice = "Please enter a valid email"
//            }
//            self.emailModel.tip = emailNotice
//            self.emailModel.text = textField.text!
//            let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
//            DispatchQueue.main.async {
//                self.tableView!.reloadRows(at: [indexPath], with: .none)
//            }
        }else if textField.tag == 10002{
//            let temp = textField.validateUsername()
//            var usernameNotice = ""
//            if !temp {
//                usernameNotice = "Please enter a valid username"
//            }
//            self.usernameModel.tip = usernameNotice
//            self.usernameModel.text = textField.text!
//            let indexPath: IndexPath = IndexPath.init(row: 1, section: 0)
//            DispatchQueue.main.async {
//                self.tableView!.reloadRows(at: [indexPath], with: .none)
//            }
        }else if textField.tag == 10003{
//            let temp = textField.validatePassword()
//            var passwordNotice = ""
//            if !temp {
//                passwordNotice = "Please enter a valid password"
//            }else{
//                passwordNotice = ""
//            }
//            self.passwordModel.tip = passwordNotice
//            self.passwordModel.text = textField.text!
//            let indexPath: IndexPath = IndexPath.init(row: 2, section: 0)
//            DispatchQueue.main.async {
//                self.tableView!.reloadRows(at: [indexPath], with: .none)
//            }
        }else if textField.tag == 10004{
//            var codeNotice = ""
//            var temp = ""
//            if textField.text == nil {
//                temp = ""
//            }else{
//                temp = textField.text!
//            }
//            
//            if (temp.isBlank) {
//                codeNotice = "Please enter a valid code"
//            }
//            self.codeModel.tip = codeNotice
//            self.codeModel.text = textField.text!
//            let indexPath: IndexPath = IndexPath.init(row: 3, section: 0)
//            DispatchQueue.main.async {
//                self.tableView!.reloadRows(at: [indexPath], with: .none)
//            }
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
        tempCell.update(model: self.usernameModel)
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.setupShowPasswordButton()
        tempCell.textFild?.delegate = self
        tempCell.textFild?.tag = 10002
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
