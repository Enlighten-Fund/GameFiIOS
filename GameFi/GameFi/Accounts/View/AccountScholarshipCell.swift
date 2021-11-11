//
//  AccountScholarshipCell.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit
let accountScholarshipsCellIdentifier:String = "AccountScholarshipsCell"
class AccountScholarshipsCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.axieImgView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        self.axieImgView2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalTo(self.axieImgView1.snp.left)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        
        self.axieImgView3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(self.axieImgView1.snp.right)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView3.snp.bottom).offset(10)
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
        self.daysEndLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.returnDaysLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.daysEndLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.returnDaysLabelView.snp.bottom)
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
        self.secretLabel.snp.makeConstraints { make in
            make.top.equalTo(self.secretTitleLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.secretLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
    }

    func update(scholarshipModel:ScholarshipModel) {
        
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
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var returnAmountLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var daysEndLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var returnDaysLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
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
        tempLabel.text = "Account secret"
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var secretLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.textColor = .white
        self.contentView.addSubview(tempLabel)
        return tempLabel
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
