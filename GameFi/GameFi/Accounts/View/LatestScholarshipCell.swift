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
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.creditScoreLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.highmmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.pvpLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.highmmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.returnPerDayLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.pvpLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.countryLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.returnPerDayLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.availabelLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.countryLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.accountAppliedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.availabelLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
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

    func update(scholarshipModel:ScholarshipModel) {
        
    }
    
    lazy var scholarLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditScoreLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var highmmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var pvpLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var returnPerDayLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var countryLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var availabelLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var accountAppliedLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    lazy var refuseBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Refuse", for: .normal)
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
        tempBtn.setTitle("Apply", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
