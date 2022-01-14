//
//  EditScholarshipController.swift
//  GameFi
//
//  Created by harden on 2021/11/19.
//

import Foundation
import UIKit
import SnapKit
import AWSMobileClient

import MJRefresh
class EditScholarshipController: ViewController {
    var accountNameTextField : UITextField?
    var roninTextField : UITextField?
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var managerPercentTextField : UITextField?
    var offerDaysTextField : UITextField?
    var scholarpercentageLabel : UILabel?
    var scholarshipModel : ScholarshipModel?
    var editScholarBlock:CommonEmptyBlock?
    var depositView : DepositView?
    var isDeposit : Bool?
    init(scholarshipModel:ScholarshipModel) {
        super.init(nibName: nil, bundle: nil)
        self.scholarshipModel = scholarshipModel
        if self.scholarshipModel?.staking == nil || self.scholarshipModel?.staking == false{
            self.isDeposit = false
        }else{
            self.isDeposit = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit my scholarship"
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
    
    override func leftBtnClick() {
        GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you leave now, the changes won't be saved.", currentVC: self, cancelStr: "Leave", cancelHandler: { action in
            DispatchQueue.main.async {
                super.leftBtnClick()
            }
        }, otherBtns: ["Cancel"]) { index in
            
        }
    }
    
    @objc func depositSwitchClick(aswitch:UISwitch) {
        self.isDeposit = aswitch.isOn
        self.tableView?.reloadRows(at: [IndexPath.init(row: 4, section: 0),IndexPath.init(row: 5, section: 0),IndexPath.init(row: 6, section: 0)], with: .none)
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
    
    @objc func cancelBtnClick() {
        if self.isDeposit == true{
            self.editStakingScholarship(toStatus: "DRAFT")
        }else{
            self.editScholarship(toStatus: "DRAFT")
        }
    }
    
    @objc func postBtnClick() {
        if self.isDeposit == true{
            self.editStakingScholarship(toStatus: "LISTING")
        }else{
            self.editScholarship(toStatus: "LISTING")
        }
       
    }
    
    
    @objc func editStakingScholarship(toStatus:String){
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
        let params = ["scholarship_name" : self.accountNameTextField?.text as Any,
                      "account_login" : self.emailTextField?.text as Any,
                      "account_passcode" : self.passwordTextField?.text as Any,
                      "account_ronin_address":self.roninTextField?.text as Any,
                      "manager_percentage":50,
                      "offer_period": -1,
                      "scholar_percentage":100 - (UserManager.sharedInstance.userinfoModel?.platform_fee)! - 50,
                      "id":Int(self.scholarshipModel!.scholarship_id!) as Any,
                      "status": toStatus
        ] as [String : Any]
        self.mc_loading(text: "Loading")
        DataManager.sharedInstance.editStakingScholarShip(dic: params) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    var msg = ""
                    if toStatus == "DRAFT" {
                        msg = "Saved successfully."
                    }else{
                        msg = "We will verify your account and notify you with the minimum SLP return by email within 24 hours. "
                    }
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: msg, currentVC: self,  cancelStr: "OK", cancelHandler: { action in
                        DispatchQueue.main.async { [self] in
                            self.navigationController?.popViewController(animated: true)
                            if editScholarBlock != nil {
                                editScholarBlock!()
                            }
                        }
                    }, otherBtns: nil) { index in
                       
                    }
                }else{
                    if  result.msg != nil && !result.msg!.isBlank {
                        self.mc_text(result.msg!)
                    }
                }
            }
        }
    }
    
    @objc func editScholarship(toStatus:String){
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
        if !self.valifyOfferDays() {
            return
        }
        if !self.valifyPercentage() {
            return
        }
        let params = ["scholarship_name" : self.accountNameTextField?.text as Any,
                      "account_login" : self.emailTextField?.text as Any,
                      "account_passcode" : self.passwordTextField?.text as Any,
                      "account_ronin_address":self.roninTextField?.text as Any,
                      "manager_percentage":Float(self.managerPercentTextField!.text!)!,
                      "offer_period": Int(self.offerDaysTextField!.text!) as Any,
                      "scholar_percentage":95 - Float(self.managerPercentTextField!.text!)!,
                      "id":Int(self.scholarshipModel!.scholarship_id!) as Any
        ] as [String : Any]
        self.mc_loading(text: "Loading")
        DataManager.sharedInstance.editScholarShip(dic: params) { result, reponse in
            DispatchQueue.main.async { [self] in
                if result.success!{
                    if toStatus == "DRAFT" {
                        self.mc_remove()
                        self.mc_success("Saved successfully")
                        self.navigationController?.popViewController(animated: true)
                        if editScholarBlock != nil {
                            editScholarBlock!()
                        }
                    }else{
                        DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: self.scholarshipModel!.scholarship_id!, status: toStatus) { result, reponse in
                            self.mc_remove()
                            if result.success!{
                                self.mc_success("Finished! Under review.")
                                self.navigationController?.popViewController(animated: true)
                                if editScholarBlock != nil {
                                    editScholarBlock!()
                                }
                            }else{
                                if  result.msg != nil && !result.msg!.isBlank {
                                    self.mc_text(result.msg!)
                                }
                            }
                        }
                    }
                }else{
                    self.mc_remove()
                    if  result.msg != nil && !result.msg!.isBlank {
                        self.mc_text(result.msg!)
                    }
                }
            }
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
        if self.accountNameTextField!.text == nil || self.accountNameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Scholarship name should be filled in")
            self.updateTextField(textField: self.accountNameTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.accountNameTextField!, focus: false)
            return true
        }
    }
    
    func valifyRonin() -> Bool {
        if self.roninTextField!.text == nil || self.roninTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Ronin address should be filled in")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else if !self.roninTextField!.text!.starts(with: "0x") && !self.roninTextField!.text!.starts(with: "ronin:"){
            self.showNoticeLabel(notice: "The ronin address should start with ronin: or 0x.")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else if self.roninTextField!.text!.count != 42 &&  self.roninTextField!.text!.count != 46{
            self.showNoticeLabel(notice: "The ronin address should start with ronin: or 0x.")
            self.updateTextField(textField: self.roninTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.roninTextField!, focus: false)
            return true
        }
    }
    
    func valifyEmail() -> Bool {
        if self.emailTextField!.text == nil || self.emailTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Email should be filled in ")
            self.updateTextField(textField: self.emailTextField!, focus: true)
            return false
        }
        var temp = false
        if self.emailTextField!.validateEmail() {
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "Please enter a valid email")
            self.updateTextField(textField: self.emailTextField!, focus: true)
            return false
        }
        self.hideNoticeLabel()
        self.updateTextField(textField: self.emailTextField!, focus: false)
        return true
    }
    
    func valifyPassword() -> Bool {
        if self.passwordTextField!.text == nil || self.passwordTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Password should be filled in ")
            self.updateTextField(textField: self.passwordTextField!, focus: true)
            return false
        }
        self.hideNoticeLabel()
        self.updateTextField(textField: self.passwordTextField!, focus: false)
        return true
    }
    
    func valifyOfferDays() -> Bool {
        if self.offerDaysTextField!.text == nil || self.offerDaysTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Period days should be filled in ")
            self.updateTextField(textField: self.offerDaysTextField!, focus: true)
            return false
        }
        var temp = false
        if self.offerDaysTextField!.validateNumber() {
            temp = true
        }
        if !temp {
            self.showNoticeLabel(notice: "Period days must be an integer")
            self.updateTextField(textField: self.offerDaysTextField!, focus: true)
            return false
        }
        if Int(self.offerDaysTextField!.text!)! <= 2 {
            self.showNoticeLabel(notice: "Period days must be more than 2")
            self.updateTextField(textField: self.offerDaysTextField!, focus: true)
            return false
        }
        self.hideNoticeLabel()
        self.updateTextField(textField: self.offerDaysTextField!, focus: false)
        return true
    }
    
    func valifyPercentage() -> Bool {
        if self.managerPercentTextField!.text == nil || self.managerPercentTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Manager percentage should be filled in")
            self.updateTextField(textField: self.managerPercentTextField!, focus: true)
            return false
        }else{
            let percent : Float = Float(self.managerPercentTextField!.text!)!
            if percent < 0.00 || percent > 100 - (UserManager.sharedInstance.userinfoModel?.platform_fee)! {
                self.showNoticeLabel(notice: "Manager Percentage must be a number from 0 to \((UserManager.sharedInstance.userinfoModel?.platform_fee)!)")
                self.updateTextField(textField: self.managerPercentTextField!, focus: true)
                return false
            }else{
                self.hideNoticeLabel()
                self.updateTextField(textField: self.managerPercentTextField!, focus: false)
                return true
            }
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        let footView = PostScholarFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 60))
        footView.cancelBtn.setTitle("Save", for: .normal)
        footView.postBtn.setTitle("Post", for: .normal)
        footView.cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        footView.postBtn.addTarget(self, action: #selector(postBtnClick), for: .touchUpInside)
        tempTableView.tableFooterView = footView
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "3")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "4")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "5")
        tempTableView.register(PostScholarshipCell.classForCoder(), forCellReuseIdentifier: postScholarshipCellIdentifier + "6")
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.backgroundColor = self.view.backgroundColor
        let tdepostiView = DepositView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 40))
        self.depositView = tdepostiView
        tdepostiView.depositSwitch.addTarget(self, action: #selector(depositSwitchClick), for: .touchUpInside)
        tdepostiView.depositSwitch.isEnabled = false
        tempTableView.tableHeaderView = tdepostiView
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

extension  EditScholarshipController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
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
        }else if textField == self.managerPercentTextField{
            if self.valifyPercentage(){
                let str = String(format: "%.2f", 100 - (UserManager.sharedInstance.userinfoModel?.platform_fee)! - Float(textField.text!)!)
                self.scholarpercentageLabel!.text = "\(str)%    "
            }
        }else if textField == self.passwordTextField{
            self.valifyPassword()
        }else if textField == self.offerDaysTextField{
            self.valifyOfferDays()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 7
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6 {
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
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Scholarship name", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.accountNameTextField?.text = self.scholarshipModel?.scholarship_name
        cell = tempCell
    case 1:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  ronin:5550fc7bbe0126d5d31d347ae584fdd8906af29f", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.roninTextField = tempCell.textFild
        self.roninTextField?.text = self.scholarshipModel?.account_ronin_address
        cell = tempCell
    case 2:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Axie account email", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.emailTextField = tempCell.textFild
        self.emailTextField?.text = self.scholarshipModel?.account_login
        cell = tempCell
    case 3:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "3", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Axie account password", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.passwordTextField = tempCell.textFild
        self.passwordTextField?.text = self.scholarshipModel?.account_passcode
        self.passwordTextField!.setupShowPasswordButton()
        self.passwordTextField!.isSecureTextEntry = true
        cell = tempCell
    case 4:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "4", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Offer period", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.offerDaysTextField = tempCell.textFild
        self.offerDaysTextField?.keyboardType = .numberPad
        self.offerDaysTextField?.text = self.scholarshipModel?.offer_period
        if self.isDeposit == true {
            self.offerDaysTextField!.isEnabled = false
            self.offerDaysTextField?.backgroundColor = .gray
            self.offerDaysTextField?.text = "Offer period:Ongoing"
        }else{
            self.offerDaysTextField!.isEnabled = true
            self.offerDaysTextField?.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        }
        cell = tempCell
    case 5:
        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "5", for: indexPath) as! LabelTextFildCell
        tempCell.textFild?.delegate = self
        tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Manager percentage", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
        self.managerPercentTextField = tempCell.textFild
        self.managerPercentTextField?.text = self.scholarshipModel?.manager_percentage
        if self.isDeposit == true {
            self.managerPercentTextField!.isEnabled = false
            self.managerPercentTextField?.backgroundColor = .gray
            self.managerPercentTextField?.text = "Manager percentage:50%"
        }else{
            self.managerPercentTextField!.isEnabled = true
            self.managerPercentTextField?.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        }
        cell = tempCell
    case 6:
        let tempCell : PostScholarshipCell = tableView.dequeueReusableCell(withIdentifier: postScholarshipCellIdentifier + "6", for: indexPath) as! PostScholarshipCell
        self.scholarpercentageLabel = tempCell.rightLabel
        self.scholarpercentageLabel?.text = scholarshipModel?.scholar_percentage
        tempCell.update(isDeposit: self.isDeposit!)
        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}

