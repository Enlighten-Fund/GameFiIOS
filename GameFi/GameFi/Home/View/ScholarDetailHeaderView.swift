//
//  ScholarDetailModel.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//



import Foundation
import UIKit
import SnapKit

class ScholarDetailHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        self.managerNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(iconImgView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.nationalityLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.managerNameLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.contractAgeLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.nationalityLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.availableLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.contractAgeLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.highestLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.availableLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.experienceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.highestLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
    }
    
    func update(scholarDetailModel:ScholarDetailModel) {
        
        self.iconImgView.image = UIImage.init(named: "portrait")
        if scholarDetailModel.scholar_portrait != nil {
            self.iconImgView.kf.setImage(with: URL.init(string: scholarDetailModel.scholar_portrait!))
        }
        if scholarDetailModel.username != nil {
            self.managerNameLabelView.update(leftTitle: "Manager name", rithtTitle: scholarDetailModel.username!)
        }
        if scholarDetailModel.nation != nil {
            self.nationalityLabelView.update(leftTitle: "Nationality", rithtTitle: scholarDetailModel.nation!)
        }
        if scholarDetailModel.age != nil {
            self.contractAgeLabelView.update(leftTitle: "Contract age", rithtTitle: scholarDetailModel.age!)
        }
        if scholarDetailModel.available_time != nil {
            self.availableLabelView.update(leftTitle: "Available time", rithtTitle: scholarDetailModel.available_time!)
        }
        if scholarDetailModel.mmr != nil {
            self.highestLabelView.update(leftTitle: "Highest MMR", rithtTitle: scholarDetailModel.mmr!)
        }
        if scholarDetailModel.scholar_since != nil {
            self.experienceLabelView.update(leftTitle: "Experience", rithtTitle: scholarDetailModel.scholar_since!)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 75 / 2.0
        tempImgView.layer.masksToBounds = true
        tempImgView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        tempImgView.layer.shadowRadius = 0.5
        tempImgView.layer.shadowColor = UIColor.white.cgColor
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var managerNameLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var nationalityLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var contractAgeLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var availableLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var highestLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var experienceLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}


