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
        self.scholarNameLabelView.snp.makeConstraints { make in
            make.top.equalTo(iconImgView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.creditScoreLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarNameLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.locationLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.ageLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.locationLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.experienceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.ageLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.availableLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.experienceLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.availableLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
    }
    
    func dateFromString(string:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)
    }
    
    func update(scholarDetailModel:ScholarDetailModel) {
        if scholarDetailModel.avatar != nil {
            self.iconImgView.kf.setImage(with: URL.init(string: scholarDetailModel.avatar!), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
                
            }
        }
        if scholarDetailModel.username != nil {
            self.scholarNameLabelView.update(leftTitle: "Scholar name", rithtTitle: scholarDetailModel.username!)
        }
        if scholarDetailModel.credit_score != nil {
            self.creditScoreLabelView.update(leftTitle: "Credit score", rithtTitle: scholarDetailModel.credit_score!)
        }
        if scholarDetailModel.nation != nil {
            let nation : String = scholarDetailModel.nation!
            let country : [String] = nation.components(separatedBy: ",")
            if country.count > 0 {
                self.locationLabelView.update(leftTitle: "Location", rithtTitle: country[0])
            }
        }
        if scholarDetailModel.dob != nil && self.dateFromString(string: scholarDetailModel.dob!) != nil{
            let now = Date()
            let birthday: Date = self.dateFromString(string: scholarDetailModel.dob!)!
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            let age = ageComponents.year!
            self.ageLabelView.update(leftTitle: "Age", rithtTitle: String(age))
        }
        if scholarDetailModel.axie_exp != nil {
            self.experienceLabelView.update(leftTitle: "Experience in Axie", rithtTitle:"\(scholarDetailModel.axie_exp!) months")
        }
        if scholarDetailModel.available_time != nil {
            self.availableLabelView.update(leftTitle: "Available time", rithtTitle: "\(scholarDetailModel.available_time!) hrs/day")
        }
        if scholarDetailModel.mmr != nil {
            self.mmrLabelView.update(leftTitle: "Highest MMR", rithtTitle: scholarDetailModel.mmr!)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 75 / 2.0
        tempImgView.layer.masksToBounds = true
//        tempImgView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        tempImgView.layer.shadowRadius = 0.5
        tempImgView.layer.shadowColor = UIColor.white.cgColor
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var scholarNameLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholar name"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var creditScoreLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Credit score"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var locationLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Location"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var ageLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Age"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var experienceLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Experience in Axie"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var availableLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Available time"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Highest MMR"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}


