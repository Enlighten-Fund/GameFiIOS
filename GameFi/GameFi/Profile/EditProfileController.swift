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
import SCLAlertView
import Amplify

class EditProfileController: ViewController {
    var firstnameTextField : UITextField?
    var lastnameTextField : UITextField?
    var idNoTextField : UITextField?
    var mmrField : UITextField?
    var gamesPlayedTextView : UITextView?
    var introduceTextView : UITextView?
    var countryArray = [[ String :  AnyObject ]]()
    var countryIndex = 0
    var stateIndex = 0
    var cityIndex = 0
    var countryLabel : UILabel?
    var birthDayLabel : UILabel?
    var availableLabel : UILabel?
    var playAxieLabel : UILabel?
    var availabelArray = ["1-3","3-5","5-7","7-9","9-11"]
    var playAxieArray = ["< 1","1-3","3-6",">6"]
    var availableIndex = 0
    var playAxieIndex = 0
    var idPhotoCell : IDPhotoCell?
    var idImgView : UIImageView?
    var uploadUrl : String?
    
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
        let  path =  Bundle.main.path(forResource: "countries-heirarchy" , ofType: "json" )
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        self.countryPickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
    
    func showBirthDayPickerView() {
        self.birthdayDatePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
        self.availablePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
    }
    @objc func selectPlayAxie() {
        self.playAxieLabel?.text = self.playAxieArray[playAxieIndex]
        self.hidePlayAxiePickerView()
    }
    
    
    func showPlayAxiePickerView() {
        self.playAxiePickerView!.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(IPhone_TabbarSafeBottomMargin)
            make.height.equalTo(400)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
    
    
    func stringFromDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)
    }
    
    @objc func selectBirthDay() {
        let birthDay = self.birthdayDatePickerView?.pickerView?.date
        self.birthDayLabel?.text = self.stringFromDate(date: birthDay! as NSDate)
        self.hideBirthdayPickerView()
    }
    
    @objc func selectCountry() {
        //获取选中的
        var country = ""
        var state = ""
        var city = ""
        let  countryDic : Dictionary =  self.countryArray[countryIndex]
        country = countryDic["countryName"] as! String
        if countryDic[ "states" ] != nil {
            let statesArray : Array<[ String :  AnyObject ]> = countryDic[ "states" ] as! Array<[ String :  AnyObject ]>
            let  stateDic : [String : AnyObject] = statesArray[stateIndex]
            state = (stateDic[ "stateName" ] as? String)!
            let cityArry : Array<[ String :  AnyObject ]>  = stateDic["cities"] as! Array<[String : AnyObject]>
            let  cityDic : [String : AnyObject] = cityArry[cityIndex]
            city = (cityDic[ "cityName" ] as? String)!
        }else{
            if countryDic[ "cities" ] != nil {
                let citiesArray : Array<[ String :  AnyObject ]> = countryDic[ "cities" ] as! Array<[ String :  AnyObject ]>
                let  cityDic : [String : AnyObject] = citiesArray[stateIndex]
                city = (cityDic[ "cityName" ] as? String)!
            }
            
        }
        self.countryLabel?.text = "\(country)-\(state)-\(city)"
        self.hideCountryPickerView()
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
                }
            }
        }

    }
    
    @objc func showPictureSheet() {
        GFAlert.showAlert(titleStr: nil, msgStr: nil, style: .actionSheet, currentVC: self, cancelBtn: "Cancel", cancelHandler: { (cancelAction) in
            
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
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tempTableView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        tempTableView.separatorStyle = .none
        tempTableView.keyboardDismissMode = .onDrag
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "0")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "1")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "2")
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier + "3")
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
        tempPickerView.pickerView?.tag = 30001
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hideCountryPickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    
    lazy var birthdayDatePickerView: GFDatePickerView? = {
        let birthdayDatePickerView = GFDatePickerView.init(frame: CGRect.zero)
        birthdayDatePickerView.cancelBtn?.addTarget(self, action: #selector(hideBirthdayPickerView), for: .touchUpInside)
        birthdayDatePickerView.okBtn?.addTarget(self, action: #selector(selectBirthDay), for: .touchUpInside)
        birthdayDatePickerView.backgroundColor = UIColor.init(hexString: "0x30354B")
        view.addSubview(birthdayDatePickerView)
        return birthdayDatePickerView
    }()
    
    lazy var availablePickerView: GFPickerView? = {
        let tempPickerView = GFPickerView.init(frame: CGRect.zero)
        tempPickerView.pickerView?.tag = 30002
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hideAvailablePickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectAvailable), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    lazy var playAxiePickerView: GFPickerView? = {
        let tempPickerView = GFPickerView.init(frame: CGRect.zero)
        tempPickerView.pickerView?.tag = 30003
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hidePlayAxiePickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectPlayAxie), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    lazy var imagePicker = HImagePickerUtils()
    
}

extension  EditProfileController :UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 30001 {
            return  3
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
                title = (countryDic[ "countryName" ] as? String)!
            } else  if  component == 1 {
                let  countryDic =  self.countryArray[countryIndex]
                if countryDic[ "states" ] != nil {
                    let statesArray : Array<[ String :  AnyObject ]> = countryDic[ "states" ] as! Array<[ String :  AnyObject ]>
                    let  stateDic : [String : AnyObject] = statesArray[row]
                    title = (stateDic[ "stateName" ] as? String)!
                }else{
                    let citiesArray : Array<[ String :  AnyObject ]> = countryDic[ "cities" ] as! Array<[ String :  AnyObject ]>
                    let  cityDic : [String : AnyObject] = citiesArray[row]
                    title = (cityDic[ "cityName" ] as? String)!
                }
                
            } else  {
                let  country =  self.countryArray[countryIndex]
                let statesArray : Array<[ String :  AnyObject ]> = country[ "states" ] as! Array<[ String :  AnyObject ]>
                let  stateDic : [String : AnyObject] = statesArray[self.stateIndex]
                let cityArry : Array<[ String :  AnyObject ]>  = stateDic["cities"] as! Array<[String : AnyObject]>
                let  cityDic : [String : AnyObject] = cityArry[row]
                title =  (cityDic[ "cityName" ] as? String)!
            }
            
        }else if pickerView.tag == 30002{
            title = availabelArray[row]
        }else if pickerView.tag == 30003{
            title = playAxieArray[row]
        }
        
        
           let showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 34))
           showLabel.textAlignment = .center
           showLabel.adjustsFontSizeToFitWidth = true
           showLabel.textColor = .black
           showLabel.text = title
           return showLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 30001 {
            if  component == 0 {
                return  self .countryArray.count
            }  else  if  component == 1 {
                let  countryDic =  self .countryArray[self.countryIndex]
                if countryDic["states"]?.count == nil ||  countryDic["states"]?.count == 0{
                    if  countryDic[ "cities" ] != nil && countryDic[ "cities" ]!.count > 0{
                        return  countryDic[ "cities" ]!.count
                    }
                    return 0
                   
                }else{
                    return countryDic[ "states" ]!.count
                }
                
            }  else  {
                let  countryDic =  self.countryArray[countryIndex]
                if countryDic[ "states" ] == nil {
                    return 0
                }else{
                    let statesArray : Array<[ String :  AnyObject ]> = countryDic[ "states" ] as! Array<[ String :  AnyObject ]>
                    let  stateDic : [String : AnyObject] = statesArray[self.stateIndex]
                    return  stateDic[ "cities" ]!.count
                }
                
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
                cityIndex = 0;
                pickerView.reloadComponent(1);
                pickerView.reloadComponent(2);
                pickerView.selectRow(0, inComponent: 1, animated:  false )
                pickerView.selectRow(0, inComponent: 2, animated:  false )
            case 1:
                stateIndex = row
                cityIndex = 0
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated:  false )
            case  2:
                cityIndex = row
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
        if self.gamesPlayedTextView!.text == nil || self.gamesPlayedTextView!.text!.isBlank {
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
        if self.introduceTextView!.text == nil || self.introduceTextView!.text!.isBlank {
            self.showNoticeLabel(notice: "Introduce yourself briefly should be filled in")
            self.updateTextView(textView:self.introduceTextView!, focus: true)
            return false
        }else{
            self.hideNoticeLabel()
            self.updateTextView(textView:self.introduceTextView!, focus: false)
            return true
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.firstnameTextField {
            self.valifyFirstName()
        }else if textField == self.lastnameTextField {
            self.valifyLastName()
        }else if textField == self.idNoTextField {
            self.valifyIdNO()
        }else if textField == self.mmrField {
            self.valifyMMR()
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.gamesPlayedTextView {
            self.valifyGamePlayed()
            if textView.text.isEmpty {
                textView.text = "Enter the gmes you played before"
                textView.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            }
        }else if textView == self.introduceTextView {
            self.valifyIntroduction()
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
            return 6
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
        if indexPath.section == 0 && indexPath.row == 5 {
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
            cell = tempCell
        case 1:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  Last name", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.lastnameTextField = tempCell.textFild

            cell = tempCell
        case 2:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "0", for: indexPath) as! PickerViewCell
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Country/State/City"
            }
            self.countryLabel = tempCell.titleLabel
            cell = tempCell
        case 3:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "2", for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.delegate = self
            tempCell.textFild?.attributedPlaceholder = NSAttributedString.init(string: "  ID number", attributes: [.font: UIFont(name: "Avenir Next Regular", size: 15) as Any,.foregroundColor: UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)])
            self.idNoTextField = tempCell.textFild
            cell = tempCell
        case 4:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "1", for: indexPath) as! PickerViewCell
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Date of birth (MM/DD/YYYY)"
            }
            self.birthDayLabel = tempCell.titleLabel
            cell = tempCell
        case 5:
            let tempCell : IDPhotoCell = tableView.dequeueReusableCell(withIdentifier: IDPhotoCellIdentifier, for: indexPath) as! IDPhotoCell
            self.idPhotoCell = tempCell
            tempCell.btn.addTarget(self, action: #selector(showPictureSheet), for: .touchUpInside)
            self.idImgView = tempCell.bgImgView
            tempCell.contentView.layer.borderWidth = 1
            tempCell.contentView.layer.borderColor = UIColor.white.cgColor
            cell = tempCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }else if indexPath.section == 1{
        switch indexPath.row {
        case 0:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "2", for: indexPath) as! PickerViewCell
            if tempCell.titleLabel!.text == nil || tempCell.titleLabel!.text!.isEmpty {
                tempCell.titleLabel?.text = "Available time / day (hours)"
            }
            self.availableLabel = tempCell.titleLabel
            cell = tempCell
        case 1:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "3", for: indexPath) as! PickerViewCell
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
        
            cell = tempCell
        case 3:
            let tempCell : TextViewCell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier + "0", for: indexPath) as! TextViewCell
            tempCell.textView?.delegate = self
            self.gamesPlayedTextView = tempCell.textView
            gamesPlayedTextView!.text = "Enter the gmes you played before"
            gamesPlayedTextView!.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
            cell = tempCell
        case 4:
            let tempCell : TextViewCell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier + "1", for: indexPath) as! TextViewCell
            tempCell.textView?.delegate = self
            self.introduceTextView = tempCell.textView
            introduceTextView!.text = "Introduce yourself briefly"
            introduceTextView!.textColor = UIColor(red: 0.29, green: 0.31, blue: 0.41, alpha: 1)
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

