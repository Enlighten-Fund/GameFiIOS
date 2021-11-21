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
        tempPickerView.cancelBtn?.addTarget(self, action: #selector(hideCountryPickerView), for: .touchUpInside)
        tempPickerView.okBtn?.addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        tempPickerView.pickerView?.dataSource = self
        tempPickerView.pickerView?.delegate = self
        tempPickerView.backgroundColor = .white
        view.addSubview(tempPickerView)
        return tempPickerView
    }()
    
}

extension  EditProfileController :UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  3
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var title = ""
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
        
           let showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 34))
           showLabel.textAlignment = .center
           showLabel.adjustsFontSizeToFitWidth = true
           //重新加载label的文字内容
           showLabel.text = title
           return showLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    }
      
}

extension  EditProfileController : UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard textField.text != nil else {
//                return true
//            }
//            //新输入的
//            if string.count == 0 {
//                return true
//            }
//
//        if string.isBlank {
//            return false
//        }
        return true
    }
 
    func textFieldDidEndEditing(_ textField: UITextField) {
     
        
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
            return 140
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
            tempCell.titleLabel?.text = "Country/State/City"
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
            tempCell.titleLabel?.text = "Date of birth (MM/DD/YYY)"
            cell = tempCell
        case 5:
            let tempCell : IDPhotoCell = tableView.dequeueReusableCell(withIdentifier: IDPhotoCellIdentifier, for: indexPath) as! IDPhotoCell
            cell = tempCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }else if indexPath.section == 1{
        switch indexPath.row {
        case 0:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "2", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = "Available time / day (hours)"
            cell = tempCell
        case 1:
            let tempCell : PickerViewCell = tableView.dequeueReusableCell(withIdentifier: pickerViewCellIdentifier + "3", for: indexPath) as! PickerViewCell
            tempCell.titleLabel?.text = "Your experience in Axie Infinity"
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
            cell = tempCell
        case 4:
            let tempCell : TextViewCell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier + "1", for: indexPath) as! TextViewCell
            tempCell.textView?.delegate = self
            self.introduceTextView = tempCell.textView
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
        }else if indexPath.section == 1 && indexPath.row == 0{
            //available time
        }else if indexPath.section == 1 && indexPath.row == 1{
            //experience
        }
    }
}

