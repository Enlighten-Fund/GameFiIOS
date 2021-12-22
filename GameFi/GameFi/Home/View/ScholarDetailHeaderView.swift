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
        self.avgMmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditScoreLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        
        self.tipLabel.snp.makeConstraints { make in
            make.top.equalTo(self.avgMmrLabelView.snp.bottom).offset(-10)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(15)
        }
        self.avgPerformaceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgMmrLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        
        self.avgReturnLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgPerformaceLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        
        self.totalPlayTimeLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgReturnLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.availableLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.totalPlayTimeLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.ageLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.availableLabelView.snp.bottom).offset(0)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(35)
        }
        self.locationLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.ageLabelView.snp.bottom).offset(0)
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
        if scholarDetailModel.rent_days != nil {
            if scholarDetailModel.rent_days! >= 3 && scholarDetailModel.total_mmr_day != nil && scholarDetailModel.rent_days != nil{
                self.tipLabel.isHidden = true
                self.avgMmrLabelView.rightLabel.text = "\(lroundf(scholarDetailModel.total_mmr_day! / scholarDetailModel.rent_days!))"
            }else{
                if scholarDetailModel.mmr != nil{
                    self.avgMmrLabelView.rightLabel.text = scholarDetailModel.mmr
                    self.tipLabel.isHidden = false
                }
            }
        }
        if scholarDetailModel.rent_days != nil {
            if scholarDetailModel.rent_days! >= 3{
                if scholarDetailModel.total_mmr_change != nil && scholarDetailModel.rent_times != nil && scholarDetailModel.rent_times != 0{
                    let a = lroundf(scholarDetailModel.total_mmr_change! / Float(scholarDetailModel.rent_times!))
                    if a > 0{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "+\(a)", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
                    }else{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "\(a)", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
                    }
                }
            }else{
                self.avgPerformaceLabelView.rightLabel.text = "-"
            }
        }
        
        if scholarDetailModel.rent_days != nil {
            if scholarDetailModel.rent_days! >= 3 && scholarDetailModel.total_slp != nil{
                self.avgReturnLabelView.rightLabel.text =  "\(lroundf(scholarDetailModel.total_slp! / scholarDetailModel.rent_days!)) SLP/day"
            }else{
                self.avgReturnLabelView.rightLabel.text =  "-"
            }
            
        }
        
        if scholarDetailModel.rent_days != nil {
            self.totalPlayTimeLabelView.rightLabel.text =  "\(Int(scholarDetailModel.rent_days!)) days"
        }
        
        if scholarDetailModel.available_time != nil {
            self.availableLabelView.update(leftTitle: "Available time", rithtTitle: "\(scholarDetailModel.available_time!) hrs/day")
        }
        if scholarDetailModel.dob != nil && self.dateFromString(string: scholarDetailModel.dob!) != nil{
            let now = Date()
            let birthday: Date = self.dateFromString(string: scholarDetailModel.dob!)!
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            let age = ageComponents.year!
            self.ageLabelView.update(leftTitle: "Age", rithtTitle: String(age))
        }
        if scholarDetailModel.nation != nil {
            let nation : String = scholarDetailModel.nation!
            let country : [String] = nation.components(separatedBy: ",")
            if country.count > 0 {
                self.locationLabelView.update(leftTitle: "Location", rithtTitle: country[0])
            }
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
    
    lazy var avgMmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg MMR"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    lazy var tipLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor =  UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 13)
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textAlignment = .right
        tempLabel.text = "The score is not tracked by NinjaDAOs."
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var avgPerformaceLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg Performace"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    
    lazy var avgReturnLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg Return"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    
    lazy var totalPlayTimeLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total Play Time"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    

    lazy var availableLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Availability"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var ageLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Age"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var locationLabelView : LabelAndLabelView = {
        let tempLabelView = LabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Location"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}


