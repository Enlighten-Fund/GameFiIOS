//
//  NoOfferScholarshipCell.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
let noOfferScholarshipCellIdentifier:String = "NoOfferScholarshipCell"
class NoOfferScholarshipCell: UICollectionViewCell {
    
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
      
        self.scholarshipNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView3.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.returnPerDayLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarshipNameLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.managerPercentLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.returnPerDayLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        
        self.OfferContractLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.managerPercentLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.OfferContractLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.roninAddressLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roninAddressLabelView.snp.bottom)
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
        
        self.leftBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pwdTextFild!.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        self.rightBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pwdTextFild!.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.pwdTextFild!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
    }
    @objc func pwdSecureBtnClick(abtn:UIButton) {
        abtn.isSelected = !abtn.isSelected
        self.pwdTextFild?.isSecureTextEntry = !self.pwdTextFild!.isSecureTextEntry
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
        if scholarshipModel.scholarship_name != nil {
            self.scholarshipNameLabelView.rightLabel.text = scholarshipModel.scholarship_name
        }
        if scholarshipModel.estimate_daily_slp != nil {
            self.returnPerDayLabelView.rightLabel.text = "\(lroundf(Float(scholarshipModel.estimate_daily_slp!)!)) SLP/day"
        }
        if scholarshipModel.manager_percentage != nil {
            self.managerPercentLabelView.rightLabel.text = "\(scholarshipModel.manager_percentage!)%"
        }
        if scholarshipModel.account_mmr != nil {
            self.mmrLabelView.rightLabel.text = scholarshipModel.account_mmr
        }
        if scholarshipModel.offer_period != nil {
            self.OfferContractLabelView.rightLabel.text = scholarshipModel.offer_period
        }
        if scholarshipModel.account_ronin_address != nil {
            self.roninAddressLabelView.rightLabel.text = scholarshipModel.account_ronin_address
        }
        if scholarshipModel.account_ronin_address != nil {
            self.roninAddressLabelView.rightLabel.text = scholarshipModel.account_ronin_address
        }
        if scholarshipModel.account_login != nil {
            self.emailLabel.text = scholarshipModel.account_login
        }
        if scholarshipModel.account_passcode != nil {
            self.pwdTextFild!.text = scholarshipModel.account_passcode
        }
        self.flagImgView.image = UIImage.init(named: "")
//        self.flagImgView.image = UIImage.init(named: "verfive")
        if scholarshipModel.status != nil {
            if scholarshipModel.status == "DRAFT" {
                self.btn.isHidden = true
                self.leftBtn.isHidden = false
                self.rightBtn.isHidden = false
            } else if scholarshipModel.status == "LISTING" {
                self.btn.isHidden = false
                self.btn.setTitle("Recall", for: .normal)
                self.btn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                self.btn.isEnabled = true
                
                self.leftBtn.isHidden = true
                self.rightBtn.isHidden = true
            }else if scholarshipModel.status == "END"{
                self.leftBtn.isHidden = true
                self.rightBtn.isHidden = true
                self.btn.isHidden = false
                self.btn.setTitle("Already ended", for: .normal)
                self.btn.backgroundColor = .gray
                self.btn.isEnabled = false
            }else if scholarshipModel.status == "AUDIT"{
                self.leftBtn.isHidden = true
                self.rightBtn.isHidden = true
                self.btn.isHidden = false
                self.btn.setTitle("Recall", for: .normal)
                self.btn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
                self.btn.isEnabled = true
                self.flagImgView.image = UIImage.init(named: "verfive")
            }
        }
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
    
    lazy var scholarshipNameLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholarship name"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var returnPerDayLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Estimate SLP"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var managerPercentLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Manager percentage"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var OfferContractLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Offer period"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var roninAddressLabelView : LabelAndLabelInterView = {
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
    
    lazy var leftBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Edit", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.borderColor = UIColor.white.cgColor
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var rightBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Post", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Recall", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
