//
//  AccountScholarshipCell.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit
let managerScholarshipCellIdentifier:String = "ManagerScholarshipCell"
class ManagerScholarshipCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.flagImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(78)
        }
        
        self.axieImgView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        self.axieImgView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalTo(self.axieImgView1.snp.left).offset(30)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        self.axieImgView3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.axieImgView1.snp.right).offset(-30)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        self.accountImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accountImgView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview()
        }
        self.creditLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accountLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview()
        }
        self.editBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.scholarshipNameLabelView.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        self.scholarshipNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom).offset(10)
            make.right.equalTo(self.editBtn.snp.left)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.returnAmountLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarshipNameLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.returnAmountLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.startDateLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.endDateLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.startDateLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.roninCopyView.snp.makeConstraints { make in
            make.top.equalTo(self.endDateLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roninCopyView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.emailTitleLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.secretTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.emailLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.pwdTextFild!.snp.makeConstraints { make in
            make.top.equalTo(self.secretTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(25)
            make.right.equalTo(self.pwdSecureBtn.snp.left).offset(-10)
        }
        
        self.pwdSecureBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.pwdTextFild!.snp.centerY)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        
        self.discordImgView.snp.makeConstraints { make in
            make.top.equalTo(self.pwdTextFild!.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        
        self.joinDiscordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discordImgView.snp.centerY).offset(0)
            make.left.equalTo(self.discordImgView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(25)
        }
        
        self.leftBtn.snp.makeConstraints { make in
            make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        self.rightBtn.snp.makeConstraints { make in
            make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        
       
    }

    func getLocalDate(from UTCDate: String) -> String {
            
        let dateFormatter = DateFormatter.init()

        // UTC 时间格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = utcTimeZone

        guard let dateFormatted = dateFormatter.date(from: UTCDate) else {
            return ""
        }

        // 输出格式
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: dateFormatted)

        return dateString
    }
    
    func dateFromString(string:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)! as NSDate
    }
    
    func stringFromDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date as Date)
    }
    
    func update(scholarshipModel:ScholarshipModel) {
        if scholarshipModel.staking == true{
            self.accountImgView.isHidden = true
            self.accountLabel.isHidden = true
            self.creditLabel.isHidden = true
            self.axieImgView1.isHidden = false
            self.axieImgView2.isHidden = false
            self.axieImgView3.isHidden = false
            if scholarshipModel.accountAxieArry == nil || scholarshipModel.accountAxieArry!.count < 3{
                
            }else{
                let axiePic1 : String = scholarshipModel.accountAxieArry![0]
                self.axieImgView1.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"))
                let axiePic2 : String = scholarshipModel.accountAxieArry![1]
                self.axieImgView2.kf.setImage(with:  URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic2)/axie/axie-full-transparent.png"))
                let axiePic3 : String = scholarshipModel.accountAxieArry![2]
                self.axieImgView3.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic3)/axie/axie-full-transparent.png"))
            }
            self.scholarshipNameLabelView.snp.remakeConstraints { make in
                make.top.equalTo(self.axieImgView3.snp.bottom).offset(10)
                make.right.equalTo(self.editBtn.snp.left)
                make.height.equalTo(25)
                make.left.equalToSuperview().offset(15)
            }
        }else{
            self.accountImgView.isHidden = false
            self.accountLabel.isHidden = false
            self.creditLabel.isHidden = false
            self.axieImgView1.isHidden = true
            self.axieImgView2.isHidden = true
            self.axieImgView3.isHidden = true
            self.accountImgView.image = UIImage.init(named: "portrait")
            if scholarshipModel.scholar_portrait != nil {
                self.accountImgView.kf.setImage(with: URL.init(string: scholarshipModel.scholar_portrait!))
            }
            if scholarshipModel.scholar_user_name != nil {
                self.accountLabel.text = scholarshipModel.scholar_user_name
            }
            if scholarshipModel.scholar_credit_score != nil {
                self.creditLabel.text = "Credit: \(scholarshipModel.scholar_credit_score!)"
            }
            self.scholarshipNameLabelView.snp.remakeConstraints { make in
                make.top.equalTo(self.creditLabel.snp.bottom).offset(10)
                make.right.equalTo(self.editBtn.snp.left)
                make.height.equalTo(25)
                make.left.equalToSuperview().offset(15)
            }
        }
        
        if scholarshipModel.scholarship_name != nil {
            self.scholarshipNameLabelView.rightLabel.text = scholarshipModel.scholarship_name
        }
        if scholarshipModel.account_lifecycle_slp_latest != nil &&  scholarshipModel.account_lifecycle_slp_start != nil{
            self.returnAmountLabelView.rightLabel.textColor =  UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            self.returnAmountLabelView.rightLabel.text = "\(lroundf( Float(scholarshipModel.account_lifecycle_slp_latest!)! - Float(scholarshipModel.account_lifecycle_slp_start!)!)) SLP(\(scholarshipModel.scholar_percentage!)%)"
        }
        if scholarshipModel.account_mmr_latest != nil && scholarshipModel.account_mmr_start != nil{
            let mmrlatestStr : NSMutableAttributedString = NSMutableAttributedString.init(string: scholarshipModel.account_mmr_start!, attributes:[.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1.0)])
            var mmrAddStr : NSAttributedString?
            if Float(scholarshipModel.account_mmr_latest!)! > Float(scholarshipModel.account_mmr_start!)! {
                let addFloat = Float(scholarshipModel.account_mmr_latest!)! - Float(scholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (+\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
            }else{
                let addFloat = Float(scholarshipModel.account_mmr_latest!)! - Float(scholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
            }
            mmrlatestStr.append(mmrAddStr!)
            self.mmrLabelView.rightLabel.attributedText = mmrlatestStr
        }
        
        if scholarshipModel.start_timestamp != nil{
            self.startDateLabelView.rightLabel.text = getLocalDate(from: scholarshipModel.start_timestamp!)
        }
        if scholarshipModel.end_timestamp != nil{
            let date = dateFromString(string: scholarshipModel.end_timestamp!)
            self.endDateLabelView.rightLabel.text = getLocalDate(from: stringFromDate(date: date))
        }else{
            if scholarshipModel.start_timestamp != nil && scholarshipModel.offer_period != nil{
                let date = dateFromString(string: scholarshipModel.start_timestamp!)
                let new = date.addingTimeInterval(TimeInterval(Int(scholarshipModel.offer_period!)! * 24 * 60 * 60))
                self.endDateLabelView.rightLabel.text = getLocalDate(from: stringFromDate(date: new))
            }
        }
        
        if scholarshipModel.account_ronin_address != nil{
            self.roninCopyView.update(roninTitle: "Ronin address", ronin: scholarshipModel.myaccount_ronin_address)
        }
        
        if scholarshipModel.account_login != nil {
            self.emailLabel.text = scholarshipModel.account_login
        }
        if scholarshipModel.account_passcode != nil {
            self.pwdTextFild!.text = scholarshipModel.account_passcode
        }
        self.endDateLabelView.rightLabel.textColor = .white
        self.flagImgView.image = UIImage.init(named: "")
        if scholarshipModel.manager_user_name != nil{
            let attr: NSMutableAttributedString = NSMutableAttributedString(string: "#\(scholarshipModel.manager_user_name!)-scholarship", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(hexString: "0x3F6DD5"), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.underlineStyle : NSNumber(value: 1)])
            self.joinDiscordLabel.attributedText = attr
            self.joinDiscordLabel.clipsToBounds = true
        }
        if scholarshipModel.status != nil {
                if scholarshipModel.status == "ACTIVE" {
                    self.editBtn.snp.remakeConstraints { make in
                        make.centerY.equalTo(self.scholarshipNameLabelView.snp.centerY)
                        make.right.equalToSuperview().offset(-15)
                        make.height.equalTo(30)
                        make.width.equalTo(30)
                    }
                    if scholarshipModel.staking == true{
                        self.flagImgView.image = UIImage.init(named: "auto")
                        self.endDateLabelView.rightLabel.text = "Ongoing"
                        self.endDateLabelView.rightLabel.textColor = .green
                        self.btn.isHidden = true
                        self.leftBtn.isHidden = false
                        self.rightBtn.isHidden = false
                        self.leftBtn.setTitle("Stop Staking", for: .normal)
                        self.leftBtn.isEnabled = true
                        self.leftBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                        self.rightBtn.setTitle("Pay", for: .normal)
                        self.rightBtn.isEnabled = true
                        self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                    }else{
                        if scholarshipModel.is_evergreen != nil{
                            self.btn.isHidden = true
                            self.leftBtn.isHidden = false
                            self.rightBtn.isHidden = false
                            self.leftBtn.setTitle("Stop offering", for: .normal)
                            self.leftBtn.isEnabled = true
                            self.leftBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                            if scholarshipModel.is_evergreen == 0{//scholar manager都未发起renew
                                self.rightBtn.setTitle("Renew", for: .normal)
                                self.rightBtn.isEnabled = true
                                self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                            }else if scholarshipModel.is_evergreen == 1{//scholar 发起renew
                                self.rightBtn.setTitle("Accept Renewal", for: .normal)
                                self.rightBtn.isEnabled = true
                                self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                            }else if scholarshipModel.is_evergreen == 2{//manager 发起renew
                                self.rightBtn.setTitle("Withdraw Renewal", for: .normal)
                                self.rightBtn.isEnabled = true
                                self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                            }else if scholarshipModel.is_evergreen == 3{//manager scholar 都同意renew
                                self.rightBtn.setTitle("Renewed", for: .normal)
                                self.rightBtn.isEnabled = false
                                self.rightBtn.backgroundColor = .gray
                            }
                        }
                    }
                } else if scholarshipModel.status == "PENDING_PAYMENT" {
                    self.editBtn.snp.remakeConstraints { make in
                        make.centerY.equalTo(self.scholarshipNameLabelView.snp.centerY)
                        make.right.equalToSuperview().offset(-15)
                        make.height.equalTo(30)
                        make.width.equalTo(30)
                    }
                    self.btn.setTitle("Pay now (24 hours left)", for: .normal)
                    self.btn.layer.borderColor = UIColor.clear.cgColor
                    self.btn.layer.borderWidth = 0
                    self.btn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                    self.btn.isEnabled = true
                    self.btn.isHidden = false
                    self.leftBtn.isHidden = true
                    self.rightBtn.isHidden = true
                } else if scholarshipModel.status == "MANAGER_PAID" {
                    self.editBtn.snp.remakeConstraints { make in
                        make.centerY.equalTo(self.scholarshipNameLabelView.snp.centerY)
                        make.right.equalToSuperview().offset(-15)
                        make.height.equalTo(30)
                        make.width.equalTo(0)
                    }
                    self.btn.setTitle("Already ended", for: .normal)
                    self.btn.layer.borderColor = UIColor.clear.cgColor
                    self.btn.layer.borderWidth = 0
                    self.btn.backgroundColor = .gray
                    self.btn.isEnabled = false
                    self.btn.isHidden = false
                    self.leftBtn.isHidden = true
                    self.rightBtn.isHidden = true
                }
            }
    }
    
    @objc func pwdSecureBtnClick(abtn:UIButton) {
        abtn.isSelected = !abtn.isSelected
        self.pwdTextFild?.isSecureTextEntry = !self.pwdTextFild!.isSecureTextEntry
    }
    lazy var flagImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var axieImgView1 : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var axieImgView2 : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var axieImgView3 : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var accountImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var accountLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 16)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var creditLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var scholarshipNameLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholarship name"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var editBtn : UIButton = {
        let editBtn = UIButton.init(frame: CGRect.zero)
        editBtn.setTitle("edit", for: .normal)
        self.contentView.addSubview(editBtn)
        return editBtn
    }()
    lazy var returnAmountLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total return"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var startDateLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Start date"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var endDateLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "End date"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var roninCopyView : RoninCopyView = {
        let roninCopyView = RoninCopyView.init(frame: CGRect.zero)
        self.contentView.addSubview(roninCopyView)
        return roninCopyView
    }()
    lazy var emailTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Account email"
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var emailLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.textColor = .white
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var secretTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Password"
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var pwdTextFild : UITextField? = {
        let tempTextField = UITextField.init(frame: CGRect.zero)
        tempTextField.textColor = .white
        tempTextField.font = UIFont(name: "PingFang SC Medium", size: 15)
        tempTextField.backgroundColor = .clear
        tempTextField.isSecureTextEntry = true
        self.contentView.addSubview(tempTextField)
        return tempTextField
    }()
    
    lazy var pwdSecureBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "eye"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "eye_look"), for: .selected)
        tempBtn.addTarget(self, action: #selector(pwdSecureBtnClick), for: .touchUpInside)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Pay now", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var leftBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Stop offering", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
//        tempBtn.layer.borderWidth = 0.5
//        tempBtn.layer.borderColor = UIColor.white.cgColor
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var rightBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Submit", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    lazy var discordImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        tempImgView.image = UIImage.init(named: "profile_discord")
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var joinDiscordLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempLabel.textAlignment = .left
        tempLabel.textColor = .white
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}
