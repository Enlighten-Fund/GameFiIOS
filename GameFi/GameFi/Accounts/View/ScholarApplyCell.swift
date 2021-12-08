//
//  ScholarAppling.swift
//  GameFi
//
//  Created by harden on 2021/11/19.
//

import Foundation
import UIKit
let scholarApplyCellIdentifier:String = "ScholarApplyCell"
class ScholarApplyCell: UICollectionViewCell {
    
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
        self.returnPerDayLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.scholarPercentLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.returnPerDayLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.offerdaysLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarPercentLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.offerdaysLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.axieCountLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }

        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.axieCountLabelView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
    }
    
    func update(applicationModel:ApplicationModel) {
        if applicationModel.accountAxieArry == nil || applicationModel.accountAxieArry!.count < 3{
            
        }else{
            let axiePic1 : String = applicationModel.accountAxieArry![0]
            self.axieImgView1.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"))
            let axiePic2 : String = applicationModel.accountAxieArry![1]
            self.axieImgView2.kf.setImage(with:  URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic2)/axie/axie-full-transparent.png"))
            let axiePic3 : String = applicationModel.accountAxieArry![2]
            self.axieImgView3.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic3)/axie/axie-full-transparent.png"))
        }
        if applicationModel.manager_user_name != nil {
            self.accountLabel.text = applicationModel.manager_user_name
        }
        if applicationModel.manager_credit_score != nil {
            self.creditLabel.text = "Credit score: \(Int(applicationModel.manager_credit_score!)!)"
        }else{
            self.creditLabel.text = "Credit score: 0"
        }
        if applicationModel.scholarship_estimate_daily_slp != nil{
            self.returnPerDayLabelView.rightLabel.textColor =  UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            self.returnPerDayLabelView.rightLabel.text = "\(lroundf(Float(applicationModel.scholarship_estimate_daily_slp!)!)) SLP/day"
        }
        if applicationModel.scholarship_scholar_percentage != nil {
            self.scholarPercentLabelView.rightLabel.text = String (format: "%.2f%",Float(applicationModel.scholarship_scholar_percentage!)!)
        }
        if applicationModel.scholarship_offer_period != nil {
            self.offerdaysLabelView.rightLabel.text = "\(applicationModel.scholarship_offer_period!) days"
        }
        if applicationModel.account_mmr != nil {
            self.mmrLabelView.rightLabel.text = applicationModel.account_mmr!
        }
        if applicationModel.account_axie_count != nil{
            self.axieCountLabelView.rightLabel.text = "\(applicationModel.account_axie_count!)"
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
    
    lazy var returnPerDayLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Estimate SLP"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var scholarPercentLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholar percentage"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var offerdaysLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Offer period"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var axieCountLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Axie counts"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
//        tempBtn.layer.borderWidth = 0.5
//        tempBtn.layer.borderColor = UIColor.white.cgColor
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Delete", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
