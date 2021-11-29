//
//  EditProfileController.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
import SnapKit
import AWSMobileClient
import MCToast

import Amplify
import Kingfisher

class EditProfileController: ViewController {
    var firstnameTextField : UITextField?
    var lastnameTextField : UITextField?
    var idNoTextField : UITextField?
    var mmrField : UITextField?
    var roninField : UITextField?
    var gamesPlayedTextView : UITextView?
    var introduceTextView : UITextView?
    var countryArray = [[ String :  AnyObject ]]()
    var countryIndex = 0
    var stateIndex = 0
    var countryLabel : UILabel?
    var country : String?
    var birthDayLabel : UILabel?
    var birthday : String?
    var availableLabel : UILabel?
    var available : String?
    var playAxieLabel : UILabel?
    var playAxie : String?
    var hasUploadId = false
    var availabelArray = ["1-3","3-5","5-7","7-9","9-11"]
    var playAxieArray = ["< 1","1-3","3-6",">6"]
    var availableIndex = 0
    var playAxieIndex = 0
    var idPhotoCell : IDPhotoCell?
    var idImgView : UIImageView?
    var uploadUrl : String?
    var userInfoModel : UserInfoModel?
    var editProfileSuccessBlock:CommonEmptyBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.noticeLabel!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(45)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview()
        }
        self.noticeLabel?.isHidden = true
        
        //初始化数据
        let  path =  Bundle.main.path(forResource: "countries" , ofType: "json" )
        let url = URL(fileURLWithPath: path!)
            do {
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonArray : [[ String :  AnyObject ]] = jsonData as! [[ String :  AnyObject ]]
                self.countryArray = jsonArray
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
        self.fetchUploadIdPhotoUrl()
        self.requestData()
    }
    
    @objc override func leftBtnClick() {
        GFAlert.showAlert(titleStr: "Notice:", msgStr: "Changes will not be saved", currentVC: self, cancelStr: "Cancel", cancelHandler: { action in
            
        }, otherBtns: ["YES"]) { index in
            DispatchQueue.main.async { [self] in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func requestData() {
        self.mc_loading()
        DataManager.sharedInstance.fetchUserDetailinfo { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    let userInfoModel : UserInfoModel = reponse as! UserInfoModel
                    self.userInfoModel = userInfoModel
                    self.country = userInfoModel.nation
                    self.birthday = userInfoModel.dob
                    self.available = userInfoModel.available_time
                    self.playAxie = userInfoModel.axie_exp
                    self.tableView?.reloadData()
                }
            }
        }
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
    
    func showCountryPickerView() {
        UIApplication.shared.keyWindow?.endEditing(true)
        self.hideBirthdayPickerView()
        self.hideAvailablePickerView()
        self.hidePlayAxiePickerView()
        self.countryPickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        if self.userInfoModel?.nation == nil || self.userInfoModel!.nation!.isBlank {

        }else{
            let array = self.country?.split(separator: ",")
            if ((array?.isEmpty) != nil) && array!.count > 0 {
                if array?.count == 1 {
                    let country : String = String(array![0])
                    var countryIndex : Int?
                    for i in 0 ..< countryArray.count {
                        let dic = countryArray[i]
                        if country == dic["name"] as! String {
                            countryIndex = i
                            break
                        }
                    }
                    if countryIndex != nil {
                        self.countryIndex = countryIndex!
                        self.countryPickerView!.pickerView!.selectRow(countryIndex!, inComponent: 0, animated:  false )
                    }
                    
                }else if array?.count == 2{
                    let country : String = String(array![0])
                    var countryIndex : Int?
                    let state : String = String(array![1])
                    var stateIndex : Int?
                    for i in 0 ..< countryArray.count {
                        let dic = countryArray[i]
                        if country == dic["name"] as! String {
                            countryIndex = i
                            break
                        }
                    }
                    if countryIndex != nil {
                        let dic : [String : AnyObject]  = countryArray[countryIndex!]
                        let states : [[String : AnyObject]] = dic["states"] as! [[String : AnyObject]]
                        for i in 0 ..< states.count {
                            let dic : [String : AnyObject] = states[i]
                            if state == dic["name"] as! String {
                                stateIndex = i
                                break
                            }
                        }
                    }
                    
                    if countryIndex != nil && stateIndex != nil{
                        self.countryIndex = countryIndex!
                        self.stateIndex = stateIndex!
                        self.countryPickerView!.pickerView!.selectRow(countryIndex!, inComponent: 0, animated:  false )
                        self.countryPickerView!.pickerView!.reloadComponent(1)
                        self.countryPickerView!.pickerView!.selectRow(stateIndex!, inComponent: 1, animated:  false )
                    }
                    
                }
                
            }
        }
        
    }
    
    @objc func hideCountryPickerView() {
        self.countryPickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func dateFromString(string:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    func stringFromDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)
    }
    
    func showBirthDayPickerView() {
        UIApplication.shared.keyWindow?.endEditing(true)
        self.hideCountryPickerView()
        self.hideAvailablePickerView()
        self.hidePlayAxiePickerView()
        if self.userInfoModel?.dob == nil || self.userInfoModel!.dob!.isBlank {
            self.birthdayDatePickerView!.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
                make.height.equalTo(400)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
        }else{
            self.birthdayDatePickerView!.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
                make.height.equalTo(400)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            let date = dateFromString(string: (self.userInfoModel?.dob)!)
            if date != nil {
                self.birthdayDatePickerView?.pickerView?.date = date! as Date
            }
        }
        
    }
    
    @objc func hideBirthdayPickerView() {
        self.birthdayDatePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    func showAvailablePickerView() {
        self.hideCountryPickerView()
        self.hideBirthdayPickerView()
        self.hidePlayAxiePickerView()
        UIApplication.shared.keyWindow?.endEditing(true)
        self.availablePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        if self.userInfoModel?.available_time == nil || self.userInfoModel!.available_time!.isBlank {
            
        }else{
            var availableIndex : Int?
            for i in 0 ..< availabelArray.count {
                if self.available == availabelArray[i] {
                    availableIndex = i
                    break
                }
            }
            if availableIndex != nil {
                self.availableIndex = availableIndex!
                self.availablePickerView!.pickerView!.selectRow(availableIndex!, inComponent: 0, animated:  false )
            }
        }
    }
    
    @objc func hideAvailablePickerView() {
        self.availablePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func selectAvailable() {
        self.availableLabel?.text = self.availabelArray[availableIndex]
        self.hideAvailablePickerView()
        self.available = self.availabelArray[availableIndex]
        self.userInfoModel?.available_time = self.available
    }
    @objc func selectPlayAxie() {
        self.playAxieLabel?.text = self.playAxieArray[playAxieIndex]
        self.hidePlayAxiePickerView()
        self.playAxie = self.playAxieArray[playAxieIndex]
        self.userInfoModel?.axie_exp = self.playAxie
    }
    
    
    func showPlayAxiePickerView() {
        self.hideCountryPickerView()
        self.hideAvailablePickerView()
        self.hideBirthdayPickerView()
        UIApplication.shared.keyWindow?.endEditing(true)
        self.playAxiePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        if self.userInfoModel?.axie_exp == nil || self.userInfoModel!.axie_exp!.isBlank {
            
        }else{
            var playAxieIndex : Int?
            for i in 0 ..< playAxieArray.count {
                if self.playAxie == playAxieArray[i] {
                    playAxieIndex = i
                    break
                }
            }
            if playAxieIndex != nil {
                self.playAxieIndex = playAxieIndex!
                self.playAxiePickerView!.pickerView!.selectRow(playAxieIndex!, inComponent: 0, animated:  false )
            }
        }
        
    }
    
    @objc func hidePlayAxiePickerView() {
        self.playAxiePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    @objc func selectBirthDay() {
        let birthDay = self.birthdayDatePickerView?.pickerView?.date
        self.birthDayLabel?.text = self.stringFromDate(date: birthDay! as NSDate)
        self.hideBirthdayPickerView()
        self.birthday = self.birthDayLabel?.text
        self.userInfoModel?.dob = self.birthday
    }
    
    @objc func selectCountry() {
        //获取选中的
        var country = ""
        var state = ""
        let  countryDic : Dictionary =  self.countryArray[countryIndex]
        country = countryDic["name"] as! String
        if countryDic[ "states" ] != nil && (countryDic[ "states" ]?.count)! > 0{
            let statesArray : Array<[ String :  AnyObject ]> = countryDic[ "states" ] as! Array<[ String :  AnyObject ]>
            let  stateDic : [String : AnyObject] = statesArray[stateIndex]
            state = (stateDic[ "name" ] as? String)!
        }
        self.countryLabel?.text = "\(country),\(state)"
        self.hideCountryPickerView()
        self.country = self.countryLabel?.text
        self.userInfoModel?.nation = self.country
    }
    
    func uploadIdPhoto(image:UIImage) {
        self.mc_loading()
        DataManager.sharedInstance.uploadImage(url: self.uploadUrl!, image: image) { result,reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    self.mc_text("uploadsuccess")
                    self.idImgView?.image = image
                    self.idPhotoCell?.contentView.bringSubviewToFront(self.idImgView!)
                    self.idPhotoCell?.reUploadBtn.isHidden = false
                    self.idPhotoCell?.contentView.bringSubviewToFront(self.idPhotoCell!.reUploadBtn)
                    self.idPhotoCell?.reUploadBtn.addTarget(self, action: #selector(showPictureSheet), for: .touchUpInside)
                    self.hasUploadId = true
                }
            }
        }

    }
    
    @objc func showPictureSheet() {
        GFAlert.showAlert(titleStr: nil, msgStr: nil, style: .actionSheet, currentVC: self, cancelStr: "Cancel", cancelHandler: { (cancelAction) in
            
        }, otherBtns: ["Capture","Photo"]) { (idx) in
            DispatchQueue.main.async { [self] in
                if idx == 0{
                    imagePicker.takePhoto(presentFrom: self, completion: { [unowned self] (image, status) in
                        DispatchQueue.main.async { [self] in
                            if status == .success {
                                self.uploadIdPhoto(image: image!)
                            }else{
                                if status == .denied{
                                    HImagePickerUtils.showTips(at: self,type: .takePhoto)
                                }else{
                                    print(status.description())
                                }
                                
                            }
                        }
                    })
                }else if idx == 1{
                    imagePicker.choosePhoto(presentFrom: self, completion: { [unowned self] (image, status) in
                        DispatchQueue.main.async { [self] in
                            if status == .success {
                                self.uploadIdPhoto(image: image!)
                            }else{
                                if status == .denied{
                                    HImagePickerUtils.showTips(at: self,type: .choosePhoto)
                                }else{
                                    print(status.description())
                                }
                                
                            }
                        }
                        
                    })
                }
            }
        }
    }
    
    func fetchUploadIdPhotoUrl() {
        DataManager.sharedInstance.fetchUpdateUrl(resource: "user-id-photo") { result, reponse in
            if result.success!{
                let dic : Dictionary = reponse as! Dictionary<String, AnyObject>
                self.uploadUrl = dic["url"] as? String
            }
        }
    }
    
    @objc func updateUserinfo(){
        if !self.valifyFirstName() {
            return
        }
        if !self.valifyLastName() {
            return
        }
        if !self.valifyCountry() {
            return
        }
        if !self.valifyIdNO() {
            return
        }
        if !self.valifyBirthDay() {
            return
        }
        if !self.valifyRonin() {
            return
        }
        if !self.valifyIdPhoto() {
            return
        }
        if !self.valifyAvailable() {
            return
        }
        if !self.valifyExperience() {
            return
        }
        if !self.valifyMMR() {
            return
        }
        if !self.valifyGamePlayed() {
            return
        }
        if !self.valifyIntroduction() {
            return
        }
        let dealronin = self.roninField!.text!.replacingOccurrences(of: "ronin:", with: "0x")
        let auserinfoModel = UserInfoModel.init()
        auserinfoModel.first_name = self.firstnameTextField?.text
        auserinfoModel.last_name = self.lastnameTextField?.text
        auserinfoModel.nation = self.country
        auserinfoModel.id_num = self.idNoTextField?.text
        auserinfoModel.dob = self.birthday
        auserinfoModel.available_time = self.available
        auserinfoModel.axie_exp = self.playAxie
        auserinfoModel.mmr = self.mmrField?.text
        auserinfoModel.game_history = self.gamesPlayedTextView?.text
        auserinfoModel.self_intro = self.introduceTextView?.text
        auserinfoModel.billing_ronin_address = dealronin
        
        let now = Date()
        let birthday: Date = self.dateFromString(string: (userInfoModel?.dob)!)!
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        auserinfoModel.age = String(age)
        
        self.mc_loading()
        DataManager.sharedInstance.updateUserinfo(userinfoModel: auserinfoModel) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    self.navigationController?.pushViewController(UserInfoStateController.init(), animated: true)
                }
            }
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tempTableView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "3")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "4")
        tempTableView.register(TextViewCell.classForCoder(), forCellReuseIdentifier: textViewCellIdentifier + "0")
        tempTableView.register(TextViewCell.classForCoder(), forCellReuseIdentifier: textViewCellIdentifier + "1")
        tempTableView.register(PickerViewCell.classForCoder(), forCellReuseIdentifier: pickerViewCellIdentifier + "0")
        tempTableView.register(PickerViewCell.classForCoder(), forCellReuseIdentifier: pickerViewCellIdentifier + "1")
        tempTableView.register(PickerViewCell.classForCoder(), forCellReuseIdentifier: pickerViewCellIdentifier + "2")
        tempTableView.register(PickerViewCell.classForCoder(), forCellReuseIdentifier: pickerViewCellIdentifier + "3")
        tempTableView.register(IDPhotoCell.classForCoder(), forCellReuseIdentifier: IDPhotoCellIdentifier)
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        let footView = SubmitView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 40))
        footView.submitBtn.addTarget(self, action: #selector(updateUserinfo), for: .touchUpInside)
        tempTableView.tableFooterView = footView
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
    lazy var countryPickerView: GFPickerView? = {
        let tempPickerView = GFPickerView.init(frame: CGRect.zero)
        tempPickerView.titleLabel?.text = "Country,State"
        tempPickerView.pickerView?.tag = 30001
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hideCountryPickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    
    lazy var birthdayDatePickerView: GFDatePickerView? = {
        let birthdayDatePickerView = GFDatePickerView.init(frame: CGRect.zero)
        birthdayDatePickerView.titleLabel?.text = "Date of birth (yyyy-MM-dd)"
        birthdayDatePickerView.cancelBtn?.addTarget(self, action: #selector(hideBirthdayPickerView), for: .touchUpInside)
        birthdayDatePickerView.okBtn?.addTarget(self, action: #selector(selectBirthDay), for: .touchUpInside)
        birthdayDatePickerView.backgroundColor = UIColor.init(hexString: "0x30354B")
        view.addSubview(birthdayDatePickerView)
        return birthdayDatePickerView
    }()
    
    lazy var availablePickerView: GFPickerView? = {
        let tempPickerView = GFPickerView.init(frame: CGRect.zero)
        tempPickerView.titleLabel?.text = "Available time / day (hours)"
        tempPickerView.pickerView?.tag = 30002
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hideAvailablePickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectAvailable), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
//        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    lazy var playAxiePickerView: GFPickerView? = {
        let tempPickerView = GFPickerView.init(frame: CGRect.zero)
        tempPickerView.titleLabel?.text = "Your experience in Axie Infinity"
        tempPickerView.pickerView?.tag = 30003
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hidePlayAxiePickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectPlayAxie), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
//        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    lazy var imagePicker = HImagePickerUtils()
    
}

extension  EditProfileController :UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 30001 {
            return  2
        }else if pickerView.tag == 30002{
            return  1
        }else if pickerView.tag == 30003{
            return  1
        }
        return  0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var title = ""
        if pickerView.tag == 30001  {
            if  component == 0 {
                let  countryDic =  self.countryArray[row]
                title = (countryDic[ "name" ] as? String)!
            } else  if  component == 1 {
                let  countryDic =  self.countryArray[countryIndex]
                if countryDic[ "states" ] != nil {
                    let statesArray : Array<[ String :  AnyObject ]> = countryDic[ "states" ] as! Array<[ String :  AnyObject ]>
                    let  stateDic : [String : AnyObject] = statesArray[row]
                    title = (stateDic[ "name" ] as? String)!
                }
            }
            
        }else if pickerView.tag == 30002{
            title = availabelArray[row]
        }else if pickerView.tag == 30003{
            title = playAxieArray[row]
        }
        
        
       let showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
       showLabel.textAlignment = .center
       showLabel.adjustsFontSizeToFitWidth = true
       showLabel.textColor = .white
       showLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
       showLabel.text = title
       return showLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 30001 {
            if  component == 0 {
                return  self .countryArray.count
            }  else  if  component == 1 {
                let  countryDic =  self .countryArray[self.countryIndex]
                return countryDic[ "states" ]!.count
            }
        }else if pickerView.tag == 30002{
            return  availabelArray.count
        }else if pickerView.tag == 30003{
            return  playAxieArray.count
        }
        
        return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 30001 {
            switch component {
            case 0:
                countryIndex = row;
                stateIndex = 0;
                pickerView.reloadComponent(1);
                pickerView.selectRow(0, inComponent: 1, animated:  false )
            case 1:
                stateIndex = row
            default :
                break ;
            }
        }else if pickerView.tag == 30002{
            availableIndex = row
        }else if pickerView.tag == 30003{
           playAxieIndex = row
        }
    }
}

extension  EditProfileController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate{
    
    func updateTextField(textField:UITextField,focus:Bool)  {
        if focus {
            textField.layer.borderColor = UIColor.init(hexString: "0xB85050").cgColor
        }else{
            textField.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        }
    }
    
    func updateTextView(textView:UITextView,focus:Bool)  {
        if focus {
            textView.layer.borderColor = UIColor.init(hexString: "0xB85050").cgColor
        }else{
            textView.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        }
    }
    
    func updateLabel(label:UILabel,focus:Bool)  {
        if focus {
            label.layer.borderColor = UIColor.init(hexString: "0xB85050").cgColor
        }else{
            label.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        }
    }
    
    func valifyFirstName() -> Bool{
        if self.firstnameTextField!.text == nil || self.firstnameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "First name should be filled in")
            self.updateTextField(textField: self.firstnameTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.firstnameTextField!, focus: false)
            return true
        }
    }
    
    func valifyLastName() -> Bool{
        if self.lastnameTextField!.text == nil || self.lastnameTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Last name should be filled in")
            self.updateTextField(textField: self.lastnameTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.lastnameTextField!, focus: false)
            return true
        }
    }
    
    func valifyCountry() -> Bool{
        if self.country == nil || self.country.isBlank {
            self.showNoticeLabel(notice: "Country should be selected")
            self.updateLabel(label: self.countryLabel!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateLabel(label: self.countryLabel!, focus: false)
            return true
        }
    }
    
    func valifyIdNO() -> Bool{
        if self.idNoTextField!.text == nil || self.idNoTextField!.text!.isBlank {
            self.showNoticeLabel(notice: "Id Number should be filled in")
            self.updateTextField(textField: self.idNoTextField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.idNoTextField!, focus: false)
            return true
        }
    }
    
    func valifyBirthDay() -> Bool{
        if self.birthday == nil || self.birthday.isBlank {
            self.showNoticeLabel(notice: "Birthday should be selected")
            self.updateLabel(label: self.birthDayLabel!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateLabel(label: self.birthDayLabel!, focus: false)
            return true
        }
    }
    
    func valifyIdPhoto() -> Bool{
        if self.hasUploadId == false {
            self.showNoticeLabel(notice: "Id photo should be upload")
            self.idImgView!.layer.borderColor = UIColor.init(hexString: "0xB85050").cgColor
            return false
        }else{
            self.hideNoticeLabel()
            self.idImgView!.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
            return true
        }
    }
    
    func valifyAvailable() -> Bool{
        if self.available == nil || self.available.isBlank {
            self.showNoticeLabel(notice: "Available time per day should be selected")
            self.updateLabel(label: self.availableLabel!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateLabel(label: self.availableLabel!, focus: false)
            return true
        }
    }
    
    func valifyExperience() -> Bool{
        if self.playAxie == nil || self.playAxie.isBlank {
            self.showNoticeLabel(notice: "Your experience in Axie Infinity should be selected")
            self.updateLabel(label: self.playAxieLabel!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateLabel(label: self.playAxieLabel!, focus: false)
            return true
        }
    }
    
    func valifyMMR() -> Bool{
        if self.mmrField!.text == nil || self.mmrField!.text!.isBlank {
            self.showNoticeLabel(notice: "MMR should be filled in")
            self.updateTextField(textField: self.mmrField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.mmrField!, focus: false)
            return true
        }
    }
    
    func valifyGamePlayed() -> Bool{
        if self.gamesPlayedTextView!.text == "Enter the gmes you played before" {
            self.showNoticeLabel(notice: "The game you played should be filled in")
            self.updateTextView(textView:self.gamesPlayedTextView!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextView(textView:self.gamesPlayedTextView!, focus: false)
            return true
        }
    }
    
    func valifyIntroduction() -> Bool{
        if self.introduceTextView!.text == "Introduce yourself briefly" {
            self.showNoticeLabel(notice: "Introduce yourself briefly should be filled in")
            self.updateTextView(textView:self.introduceTextView!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextView(textView:self.introduceTextView!, focus: false)
            return true
        }
    }
    
    
    func valifyRonin() -> Bool{
        if self.roninField!.text == nil || self.roninField!.text!.isBlank {
            self.showNoticeLabel(notice: "Ronin address should be filled in")
            self.updateTextField(textField: self.roninField!, focus: true)
            return false
        }else if !self.roninField!.text!.starts(with: "0x") && !self.roninField!.text!.starts(with: "ronin:"){
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            self.updateTextField(textField: self.roninField!, focus: true)
            return false
        }else if self.roninField!.text!.count != 42 &&  self.roninField!.text!.count != 46{
            self.showNoticeLabel(notice: "Ronin address format is 0x...... or ronin:......")
            self.updateTextField(textField: self.roninField!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextField(textField: self.roninField!, focus: false)
            return true
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.hideCountryPickerView()
        self.hideBirthdayPickerView()
        self.hideAvailablePickerView()
        self.hidePlayAxiePickerView()
        if textField == self.firstnameTextField {
            self.valifyFirstName()
            self.userInfoModel?.first_name = textField.text
        }else if textField == self.lastnameTextField {
            self.valifyLastName()
            self.userInfoModel?.last_name = textField.text
        }else if textField == self.idNoTextField {
            self.valifyIdNO()
            self.userInfoModel?.id_num = textField.text
        }else if textField == self.mmrField {
            self.valifyMMR()
            self.userInfoModel?.mmr = textField.text
        }else if textField == self.roninField {
            self.valifyRonin()
            self.userInfoModel?.billing_ronin_address = textField.text
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.gamesPlayedTextView {
            self.valifyGamePlayed()
            self.userInfoModel?.game_history = textView.text
            if textView.text.isEmpty {
                textView.text = "Enter the gmes you played before"
                textView.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            }
        }else if textView == self.introduceTextView {
            self.valifyIntroduction()
            self.userInfoModel?.self_intro = textView.text
            if textView.text.isEmpty {
                textView.text = "Introduce yourself briefly"
                textView.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .white
        if textView == self.gamesPlayedTextView {
            if textView.text == "Enter the gmes you played before" {
                textView.text = nil
            }
        }else if textView == self.introduceTextView {
            if textView.text == "Introduce yourself briefly" {
                textView.text = nil
            }
            
        }
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        }else if section == 1{
            return 5
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 3 {
            return 150
        }
        if indexPath.section == 1 && indexPath.row == 4 {
            return 150
        }
        if indexPath.section == 0 && indexPath.row == 6 {
            return IPhone_SCREEN_WIDTH - 60
        }
           return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH - 30, height: 60))
        label.font = UIFont(name: "Avenir Heavy", size: 16)
        label.textColor = .white
        if section == 0 {
            label.text = "Personal info"
        }else{
            label.text = "More info"
        }
        return label
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell!
    if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "0", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  First name", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.firstnameTextField = tempCell.textFild
            self.firstnameTextField?.text = userInfoModel?.first_name
            cell = tempCell
        case 1:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Last name", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.lastnameTextField = tempCell.textFild
            self.lastnameTextField?.text = userInfoModel?.last_name
            cell = tempCell
        case 2:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "0", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = userInfoModel?.nation
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Country,State"
            }
            self.countryLabel = tempCell.titleLabel
            cell = tempCell
        case 3:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  ID number", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.idNoTextField = tempCell.textFild
            self.idNoTextField?.text = userInfoModel?.id_num
            cell = tempCell
        case 4:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "1", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = userInfoModel?.dob
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Date of birth (yyyy-MM-dd)"
            }
            self.birthDayLabel = tempCell.titleLabel
            cell = tempCell
        case 5:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "4", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Ronin address", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.roninField = tempCell.textFild
            self.roninField?.text = userInfoModel?.billing_ronin_address
            cell = tempCell
        case 6:
            let tempCell : IDPhotoCell = tableView.dequeueReusableCell(withIdentifier: IDPhotoCellIdentifier, for: indexPath) as! IDPhotoCell
            self.idPhotoCell = tempCell
            tempCell.btn.addTarget(self, action: #selector(showPictureSheet), for: .touchUpInside)
            self.idImgView = tempCell.bgImgView
            tempCell.contentView.layer.borderWidth = 1
            tempCell.contentView.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
            if userInfoModel?.id_photo != nil {
    //            self.iconImgView.kf.setImage(with:URL.init(string: userInfoModel.avatar!))fef
                tempCell.bgImgView.kf.setImage(with: URL.init(string: userInfoModel!.id_photo!), placeholder:nil, options: nil) {result, error in
                    self.idPhotoCell?.contentView.bringSubviewToFront(self.idImgView!)
                    self.idPhotoCell?.reUploadBtn.isHidden = false
                    self.idPhotoCell?.contentView.bringSubviewToFront(self.idPhotoCell!.reUploadBtn)
                    self.hasUploadId = true
                }
            }
            cell = tempCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }else if indexPath.section == 1{
        switch indexPath.row {
        case 0:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "2", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = self.userInfoModel?.available_time
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Available time / day (hours)"
            }
            self.availableLabel = tempCell.titleLabel
            cell = tempCell
        case 1:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "3", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = self.userInfoModel?.axie_exp
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Your experience in Axie Infinity"
            }
            self.playAxieLabel = tempCell.titleLabel
            cell = tempCell
        case 2:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "3", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Highest MMR", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.mmrField = tempCell.textFild
            self.mmrField?.text = self.userInfoModel?.mmr
            cell = tempCell
        case 3:
            let tempCell : TextViewCell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier + "0", for: indexPath) as! TextViewCell
            tempCell.textView?.delegate = self
            self.gamesPlayedTextView = tempCell.textView
            if userInfoModel?.game_history != nil {
                gamesPlayedTextView!.text = userInfoModel?.game_history
                gamesPlayedTextView!.textColor = .white
            }else{
                gamesPlayedTextView!.text = "Enter the gmes you played before"
                gamesPlayedTextView!.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            }
            
            cell = tempCell
        case 4:
            let tempCell : TextViewCell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier + "1", for: indexPath) as! TextViewCell
            tempCell.textView?.delegate = self
            self.introduceTextView = tempCell.textView
            if userInfoModel?.self_intro != nil {
                introduceTextView!.text = userInfoModel?.self_intro
                introduceTextView!.textColor = .white
            }else{
                introduceTextView!.text = "Introduce yourself briefly"
                introduceTextView!.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            }
            cell = tempCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            //country
            self.showCountryPickerView()
        }else if indexPath.section == 0 && indexPath.row == 4{
            //birthday
            self.showBirthDayPickerView()
        }else if indexPath.section == 1 && indexPath.row == 0{
            //available time
            self.showAvailablePickerView()
        }else if indexPath.section == 1 && indexPath.row == 1{
            //experience
            self.showPlayAxiePickerView()
        }
    }
}

