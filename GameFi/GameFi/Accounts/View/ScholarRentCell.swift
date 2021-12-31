//
//  ScholarRentCell.swift
//  GameFi
//
//  Created by harden on 2021/11/19.
//

import Foundation
import UIKit
let scholarRentCellIdentifier:String = "ScholarRentCell"
class ScholarRentCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.axieImgView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        self.axieImgView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalTo(self.axieImgView1.snp.left).offset(60)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        self.axieImgView3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.axieImgView1.snp.right).offset(-60)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
      
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView3.snp.bottom).offset(-20)
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
        self.earnTotalLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
//        self.scholarPercentLabelView.snp.makeConstraints { make in
//            make.top.equalTo(self.earnTotalLabelView.snp.bottom)
//            make.right.equalToSuperview().offset(-15)
//            make.height.equalTo(25)
//            make.left.equalToSuperview().offset(15)
//        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.earnTotalLabelView.snp.bottom)
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
        self.emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.endDateLabelView.snp.bottom)
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
    @objc func pwdSecureBtnClick(abtn:UIButton) {
        abtn.isSelected = !abtn.isSelected
        self.pwdTextFild?.isSecureTextEntry = !self.pwdTextFild!.isSecureTextEntry
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
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
        if scholarshipModel.accountAxieArry == nil || scholarshipModel.accountAxieArry!.count < 3{
            
        }else{
            let axiePic1 : String = scholarshipModel.accountAxieArry![0]
            self.axieImgView1.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"))
            let axiePic2 : String = scholarshipModel.accountAxieArry![1]
            self.axieImgView2.kf.setImage(with:  URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic2)/axie/axie-full-transparent.png"))
            let axiePic3 : String = scholarshipModel.accountAxieArry![2]
            self.axieImgView3.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic3)/axie/axie-full-transparent.png"))
        }
        if scholarshipModel.manager_user_name != nil {
            self.accountLabel.text = scholarshipModel.manager_user_name
        }
        if scholarshipModel.manager_credit_score != nil {
            self.creditLabel.text = "Credit score: \(Int(scholarshipModel.manager_credit_score!)!)"
        }else{
            self.creditLabel.text = "Credit score: 0"
        }
        if scholarshipModel.account_lifecycle_slp_latest != nil &&  scholarshipModel.account_lifecycle_slp_start != nil && scholarshipModel.scholar_percentage != nil{
            self.earnTotalLabelView.rightLabel.textColor =  UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            self.earnTotalLabelView.rightLabel.text = "\(lroundf( Float(scholarshipModel.account_lifecycle_slp_latest!)! - Float(scholarshipModel.account_lifecycle_slp_start!)!)) SLP(\(scholarshipModel.scholar_percentage!)%)"
        }

        if scholarshipModel.account_mmr_latest != nil && scholarshipModel.account_mmr_start != nil{
            let mmrlatestStr : NSMutableAttributedString = NSMutableAttributedString.init(string: scholarshipModel.account_mmr_latest!, attributes:[.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1.0)])
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
        if scholarshipModel.account_login != nil {
            self.emailLabel.text = scholarshipModel.account_login
        }
        if scholarshipModel.account_passcode != nil {
            self.pwdTextFild!.text = scholarshipModel.account_passcode
        }
        if scholarshipModel.manager_user_name != nil{
            self.joinDiscordLabel.text = "#\(scholarshipModel.manager_user_name!)-scholarship"
        }
        if scholarshipModel.status != nil {
            if scholarshipModel.status == "PENDING_PAYMENT"{
                self.btn.setTitle("Waiting payment", for: .normal)
                self.btn.isEnabled = true
                self.btn.backgroundColor = .clear
                self.emailLabel.isHidden = false
                self.emailTitleLabel.isHidden = false
                self.pwdTextFild!.isHidden = false
                self.secretTitleLabel.isHidden = false
                self.leftBtn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                    make.height.equalTo(0)
                    make.left.equalToSuperview().offset(15)
                }
                self.rightBtn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                    make.height.equalTo(0)
                    make.right.equalToSuperview().offset(-15)
                }
                
                self.btn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.right.equalToSuperview().offset(-15)
                    make.height.equalTo(40)
                    make.left.equalToSuperview().offset(15)
                }
            }else if scholarshipModel.status == "ACTIVE"{
                self.emailLabel.isHidden = false
                self.emailTitleLabel.isHidden = false
                self.pwdTextFild!.isHidden = false
                self.secretTitleLabel.isHidden = false
                if scholarshipModel.is_evergreen != nil{
                    self.leftBtn.snp.remakeConstraints { make in
                        make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                        make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                        make.height.equalTo(40)
                        make.left.equalToSuperview().offset(15)
                    }
                    self.rightBtn.snp.remakeConstraints { make in
                        make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                        make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                        make.height.equalTo(40)
                        make.right.equalToSuperview().offset(-15)
                    }
                    
                    self.btn.snp.remakeConstraints { make in
                        make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                        make.right.equalToSuperview().offset(-15)
                        make.height.equalTo(0)
                        make.left.equalToSuperview().offset(15)
                    }
                    if scholarshipModel.is_evergreen == 0{//scholar manager都未发起renew
                        self.rightBtn.setTitle("Renew", for: .normal)
                        self.rightBtn.isEnabled = true
                        self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                    }else if scholarshipModel.is_evergreen == 1{//scholar 发起renew
                        self.rightBtn.setTitle("Withdraw Renewal", for: .normal)
                        self.rightBtn.isEnabled = true
                        self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                    }else if scholarshipModel.is_evergreen == 2{//manager 发起renew
                        self.rightBtn.setTitle("Accept Renewal", for: .normal)
                        self.rightBtn.isEnabled = true
                        self.rightBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                    }else if scholarshipModel.is_evergreen == 3{//manager scholar 都同意renew
                        self.rightBtn.setTitle("Renewed", for: .normal)
                        self.rightBtn.isEnabled = false
                        self.rightBtn.backgroundColor = .gray
                    }
                }
            }else if scholarshipModel.status == "MANAGER_PAID"{
                self.btn.setTitle("Waiting payment", for: .normal)
                self.btn.isEnabled = true
                self.btn.backgroundColor = .clear
                self.emailLabel.isHidden = false
                self.emailTitleLabel.isHidden = false
                self.pwdTextFild!.isHidden = false
                self.secretTitleLabel.isHidden = false
                self.leftBtn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                    make.height.equalTo(0)
                    make.left.equalToSuperview().offset(15)
                }
                self.rightBtn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                    make.height.equalTo(0)
                    make.right.equalToSuperview().offset(-15)
                }
                
                self.btn.snp.remakeConstraints { make in
                    make.top.equalTo(self.discordImgView.snp.bottom).offset(10)
                    make.right.equalToSuperview().offset(-15)
                    make.height.equalTo(40)
                    make.left.equalToSuperview().offset(15)
                }
            }
        }
    }
    
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
    
    lazy var earnTotalLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total return"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
//    lazy var scholarPercentLabelView : LabelAndLabelInterView = {
//        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
//        tempLabelView.leftLabel.text = "Scholar percentage"
//        self.contentView.addSubview(tempLabelView)
//        return tempLabelView
//    }()
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
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.borderColor = UIColor.white.cgColor
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Stop renting", for: .normal)
        tempBtn.backgroundColor = .clear
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var leftBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Stop renting", for: .normal)
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
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}
