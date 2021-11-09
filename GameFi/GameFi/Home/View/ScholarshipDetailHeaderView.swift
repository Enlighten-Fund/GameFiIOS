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
        self.expectedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.managerNameLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.contractLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.expectedLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.creditLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.contractLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.axieCountLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.rentedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.axieCountLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.scholarLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.rentedLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.securityLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
    }
    
    func update(scholarshipDetailModel:ScholarshipDetailModel) {
        self.managerNameLabelView.update(leftTitle: "Manager name", rithtTitle: scholarshipDetailModel.manager_user_name!)
        self.expectedLabelView.update(leftTitle: "Expected SLP per day", rithtTitle: scholarshipDetailModel.myestimate_daily_slp!)
        self.contractLabelView.update(leftTitle: "Contract period", rithtTitle: scholarshipDetailModel.manager_user_name!)
        self.creditLabelView.update(leftTitle: "Credit score", rithtTitle: scholarshipDetailModel.credit_score!)
        self.axieCountLabelView.update(leftTitle: "Axie counts", rithtTitle: scholarshipDetailModel.axie_count!)
        self.rentedLabelView.update(leftTitle: "Rented times", rithtTitle: "")
        self.scholarLabelView.update(leftTitle: "Scholar’s percentage", rithtTitle: "\(scholarshipDetailModel.scholar_percentage!)%")
        self.securityLabelView.update(leftTitle: "Security deposit", rithtTitle: "\(scholarshipDetailModel.myestimate_daily_slp!)SLP")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var managerNameLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var expectedLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var contractLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var axieCountLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var rentedLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var scholarLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var securityLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}

