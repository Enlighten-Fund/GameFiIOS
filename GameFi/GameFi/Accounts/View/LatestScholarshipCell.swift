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
        self.avgMmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.avgPerformaceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgMmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.totalPlayTimeLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgPerformaceLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.availableLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.totalPlayTimeLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
    
        self.accountAppliedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.availableLabelView.snp.bottom)
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
            if applicationModel.scholar_rent_days! >= 3 && applicationModel.scholar_total_mmr_day != nil && applicationModel.scholar_rent_days != nil{
                let averageMMR = applicationModel.scholar_total_mmr_day! / applicationModel.scholar_rent_days!
                self.avgMmrLabelView.rightLabel.text = String(averageMMR)
                self.avgMmrLabelView.rightLabel.textColor = .green
                if applicationModel.scholar_total_mmr_change != nil && applicationModel.scholar_rent_times != nil{
                    let a = applicationModel.scholar_total_mmr_change! / applicationModel.scholar_rent_times!
                    if a > 0{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "+\(a)", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
                    }else{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "\(a)", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
                    }
                }
            }else{
                if applicationModel.scholar_mmr != nil{
                    self.avgMmrLabelView.rightLabel.text = applicationModel.scholar_mmr
                    self.avgMmrLabelView.rightLabel.textColor = .white
                }
                self.avgPerformaceLabelView.rightLabel.text = "-"
            }
        }
        
        
        if applicationModel.scholar_rent_days != nil {
            self.totalPlayTimeLabelView.rightLabel.text =  "\(scholarDetailModel.rent_days!) days"
        }
        if applicationModel.scholar_available_time != nil {
            self.availableLabelView.rightLabel.text = "\(applicationModel.scholar_available_time!) hrs/day"
        }
        if applicationModel.scholarship_name != nil {
            self.accountAppliedLabelView.rightLabel.text = applicationModel.scholarship_name
        }
        
    }
    
    lazy var scholarLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholar name"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditScoreLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Credit score"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var avgMmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var avgPerformaceLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg Performace"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var totalPlayTimeLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total Play Time"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()

    lazy var availableLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Availability"
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
