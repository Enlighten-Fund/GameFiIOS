//
//  ScholarshipDetailHeaderView.swift
//  GameFi
//
//  Created by harden on 2021/11/5.
//


import Foundation
import UIKit
import SnapKit

class ScholarshipDetailHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.managerNameLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.creditScoreLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.managerNameLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.accountNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.expectedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.accountNameLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.scholarPerLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.expectedLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.offerContractLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarPerLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.axieCountLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.offerContractLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
//        self.rentLabelView.snp.makeConstraints { make in
//            make.top.equalTo(self.axieCountLabelView.snp.bottom).offset(0)
//            make.left.equalToSuperview()
//            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
//            make.height.equalTo(35)
//        }
        self.securityLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.axieCountLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
    }
    
    func update(scholarshipDetailModel:ScholarshipModel) {
        if scholarshipDetailModel.manager_user_name != nil {
            self.managerNameLabelView.update(leftTitle: "Manager name", rithtTitle: scholarshipDetailModel.manager_user_name!)
        }
        if scholarshipDetailModel.credit_score != nil {
            self.creditScoreLabelView.update(leftTitle: "Credit score", rithtTitle: scholarshipDetailModel.credit_score!)
        }
       
        if scholarshipDetailModel.scholarship_name != nil {
            self.accountNameLabelView.update(leftTitle: "Scholarship name", rithtTitle: scholarshipDetailModel.scholarship_name!)
        }
        
        if scholarshipDetailModel.estimate_daily_slp != nil {
            self.expectedLabelView.update(leftTitle: "Expected SLP per day", rithtTitle: scholarshipDetailModel.estimate_daily_slp!)
        }
        
        if scholarshipDetailModel.scholar_percentage != nil {
            self.scholarPerLabelView.update(leftTitle: "Scholar's percentage", rithtTitle: scholarshipDetailModel.scholar_percentage!)
        }
        
        if scholarshipDetailModel.offer_period != nil  {
            self.offerContractLabelView.update(leftTitle: "Offer contract days", rithtTitle: scholarshipDetailModel.offer_period!)
        }
        if scholarshipDetailModel.axie_count != nil  {
            self.axieCountLabelView.update(leftTitle: "Axie counts", rithtTitle: "\(scholarshipDetailModel.axie_count!)")
        }
//        if scholarshipDetailModel.rentedtimes != nil  {
//            self.rentLabelView.update(leftTitle: "Rented times", rithtTitle: scholarshipDetailModel.rentedtimes!)
//        }
        if scholarshipDetailModel.security_deposit != nil  {
            self.securityLabelView.update(leftTitle: "Security deposit", rithtTitle: scholarshipDetailModel.security_deposit!)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var managerNameLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Manager name"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditScoreLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Credit score"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var accountNameLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Account name"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var expectedLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Expected SLP per day"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var scholarPerLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholar's percentage"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var offerContractLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Offer contract days"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var axieCountLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Axie counts"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
//    lazy var rentLabelView : LabelAndLabelView = {
//        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
//        self.addSubview(tempLabelView)
//        return tempLabelView
//    }()
    lazy var securityLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Security deposit"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}

