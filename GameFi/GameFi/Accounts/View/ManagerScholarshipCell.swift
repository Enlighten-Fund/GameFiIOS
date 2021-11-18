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
      
        self.scholarshipNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
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
        self.roninLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.endDateLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roninLabelView.snp.bottom)
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
        
        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.pwdTextFild!.snp.bottom).offset(10)
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
    
    func update(managerScholarshipModel:ManagerScholarshipModel) {
        self.accountImgView.image = UIImage.init(named: "portrait")
        if managerScholarshipModel.scholar_portrait != nil {
            self.accountImgView.kf.setImage(with: URL.init(string: managerScholarshipModel.scholar_portrait!))
        }
        if managerScholarshipModel.scholar_user_name != nil {
            self.accountLabel.text = managerScholarshipModel.scholar_user_name
        }
        if managerScholarshipModel.scholar_credit_score != nil {
            self.creditLabel.text = "Credit: \(managerScholarshipModel.scholar_credit_score!)"
        }
        if managerScholarshipModel.scholarship_name != nil {
            self.scholarshipNameLabelView.rightLabel.text = managerScholarshipModel.scholarship_name
        }
        if managerScholarshipModel.account_lifecycle_slp_latest != nil &&  managerScholarshipModel.account_lifecycle_slp_start != nil{
            self.returnAmountLabelView.rightLabel.textColor =  UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            self.returnAmountLabelView.rightLabel.text = "\(lroundf( Float(managerScholarshipModel.account_lifecycle_slp_latest!)! - Float(managerScholarshipModel.account_lifecycle_slp_start!)!)) SLP"
        }
        if managerScholarshipModel.account_mmr_latest != nil && managerScholarshipModel.account_mmr_start != nil{
            let mmrlatestStr : NSMutableAttributedString = NSMutableAttributedString.init(string: managerScholarshipModel.account_mmr_start!, attributes:[.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1.0)])
            var mmrAddStr : NSAttributedString?
            if Float(managerScholarshipModel.account_mmr_latest!)! > Float(managerScholarshipModel.account_mmr_start!)! {
                let addFloat = Float(managerScholarshipModel.account_mmr_latest!)! - Float(managerScholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (+\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
            }else{
                let addFloat = Float(managerScholarshipModel.account_mmr_latest!)! - Float(managerScholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
            }
            mmrlatestStr.append(mmrAddStr!)
            self.mmrLabelView.rightLabel.attributedText = mmrlatestStr
        }
        
        if managerScholarshipModel.start_timestamp != nil{
            self.startDateLabelView.rightLabel.text = getLocalDate(from: managerScholarshipModel.start_timestamp!)        }
        
        if managerScholarshipModel.start_timestamp != nil && managerScholarshipModel.offer_period != nil{
            let date = dateFromString(string: managerScholarshipModel.start_timestamp!)
            let new = date.addingTimeInterval(TimeInterval(Int(managerScholarshipModel.offer_period!)! * 24 * 60 * 60))
            self.endDateLabelView.rightLabel.text = getLocalDate(from: stringFromDate(date: new))
        }
        
        if managerScholarshipModel.account_ronin_address != nil{
            self.roninLabelView.rightLabel.text = managerScholarshipModel.account_ronin_address
        }
        
        if managerScholarshipModel.account_login != nil {
            self.emailLabel.text = managerScholarshipModel.account_login
        }
        if managerScholarshipModel.account_passcode != nil {
            self.pwdTextFild!.text = managerScholarshipModel.account_passcode
        }
        
        if managerScholarshipModel.status != nil {
            if managerScholarshipModel.status == "ACTIVE" {
                self.btn.setTitle("Stop offering", for: .normal)
                self.btn.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
                self.btn.layer.borderWidth = 0.5
                self.btn.backgroundColor = .clear
            } else if managerScholarshipModel.status == "PENDING_PAYMENT" {
                self.btn.setTitle("Pay now (24 hours left)", for: .normal)
                self.btn.layer.borderColor = UIColor.clear.cgColor
                self.btn.layer.borderWidth = 0
                self.btn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
            }
        }
    }
    
    @objc func pwdSecureBtnClick(abtn:UIButton) {
        abtn.isSelected = !abtn.isSelected
        self.pwdTextFild?.isSecureTextEntry = !self.pwdTextFild!.isSecureTextEntry
    }
    
    lazy var accountImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var accountLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var creditLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var scholarshipNameLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Account name"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var returnAmountLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Return amount"
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
    lazy var roninLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Ronin address"
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
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Pay now", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
