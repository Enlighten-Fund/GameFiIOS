//
//  LatestScholarshipCell.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
let latestScholarshipCellIdentifier:String = "LatestScholarshipCell"
class LatestScholarshipCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
      
        self.scholarLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.creditScoreLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.highmmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.mmrIncreaseLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.highmmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.experienceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrIncreaseLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
    
        self.accountAppliedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.experienceLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.refuseBtn.snp.makeConstraints { make in
            make.top.equalTo(self.accountAppliedLabelView.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        self.applyBtn.snp.makeConstraints { make in
            make.top.equalTo(self.accountAppliedLabelView.snp.bottom).offset(10)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
    }

    func update(applicationModel:ApplicationModel) {
        if applicationModel.scholar_user_name != nil {
            self.scholarLabelView.rightLabel.text = applicationModel.scholar_user_name
        }
        if applicationModel.scholar_credit_score != nil {
            self.creditScoreLabelView.rightLabel.text = applicationModel.scholar_credit_score
        }
        if applicationModel.scholar_rent_days != nil {
            if applicationModel.scholar_rent_days! >= 5 && applicationModel.scholar_total_mmr_day != nil && applicationModel.scholar_rent_days != nil{
                let averageMMR = applicationModel.scholar_total_mmr_day! / applicationModel.scholar_rent_days!
                self.highmmrLabelView.rightLabel.text = String(averageMMR)
                self.highmmrLabelView.rightLabel.textColor = .green
            }else{
                if applicationModel.scholar_mmr != nil{
                    self.highmmrLabelView.rightLabel.text = applicationModel.scholar_mmr
                    self.highmmrLabelView.rightLabel.textColor = .white
                }
            }
        }
        if applicationModel.scholar_total_mmr_change != nil {
            self.mmrIncreaseLabelView.rightLabel.text =  String(applicationModel.scholar_total_mmr_change!)
        }
        if applicationModel.scholar_axie_exp != nil {
            self.experienceLabelView.rightLabel.text = "\(applicationModel.scholar_axie_exp!) months"
        }
        if applicationModel.scholarship_name != nil {
            self.accountAppliedLabelView.rightLabel.text = applicationModel.scholarship_name
        }
        
    }
    
    lazy var scholarLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Username"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditScoreLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Credit score"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var highmmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrIncreaseLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR increase"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()

    lazy var experienceLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Experience in NinjaDAOs"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
   
    lazy var accountAppliedLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholarship applied"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    lazy var refuseBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Reject", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.borderColor = UIColor.white.cgColor
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var applyBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Offer", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
