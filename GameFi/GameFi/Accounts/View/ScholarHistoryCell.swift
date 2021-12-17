//
//  ScholarHistoryCell.swift
//  GameFi
//
//  Created by harden on 2021/12/17.
//

import Foundation
import UIKit
let scholarHistoryCellIdentifier:String = "ScholarHistoryCell"
class ScholarHistoryCell: UICollectionViewCell {
    
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
        self.earnTotalLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
//        self.scholarPercentLabelView.snp.makeConstraints { make in
//            make.top.equalTo(self.earnTotalLabelView.snp.bottom)
//            make.right.equalToSuperview().offset(-15)
//            make.height.equalTo(25)
//            make.left.equalToSuperview().offset(15)
//        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.earnTotalLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.startDateLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        self.endDateLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.startDateLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(15)
        }
        
    }
 
    
    func getLocalDate(from UTCDate: String) -> String {
            
        let dateFormatter = DateFormatter.init()

        // UTC 时间格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = utcTimeZone

        guard let dateFormatted = dateFormatter.date(from: UTCDate) else {
            return ""
        }

        // 输出格式
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: dateFormatted)

        return dateString
    }
    
    func dateFromString(string:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)! as NSDate
    }
    
    func stringFromDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date as Date)
    }
    
    func update(scholarshipModel:ScholarshipModel) {
        if scholarshipModel.accountAxieArry == nil || scholarshipModel.accountAxieArry!.count < 3{
            
        }else{
            let axiePic1 : String = scholarshipModel.accountAxieArry![0]
            self.axieImgView1.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"))
            let axiePic2 : String = scholarshipModel.accountAxieArry![1]
            self.axieImgView2.kf.setImage(with:  URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic2)/axie/axie-full-transparent.png"))
            let axiePic3 : String = scholarshipModel.accountAxieArry![2]
            self.axieImgView3.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic3)/axie/axie-full-transparent.png"))
        }
        if scholarshipModel.manager_user_name != nil {
            self.accountLabel.text = scholarshipModel.manager_user_name
        }
        if scholarshipModel.manager_credit_score != nil {
            self.creditLabel.text = "Credit score: \(Int(scholarshipModel.manager_credit_score!)!)"
        }else{
            self.creditLabel.text = "Credit score: 0"
        }
        if scholarshipModel.account_lifecycle_slp_latest != nil &&  scholarshipModel.account_lifecycle_slp_start != nil && scholarshipModel.scholar_percentage != nil{
            self.earnTotalLabelView.rightLabel.textColor =  UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            self.earnTotalLabelView.rightLabel.text = "\(lroundf( Float(scholarshipModel.account_lifecycle_slp_latest!)! - Float(scholarshipModel.account_lifecycle_slp_start!)!)) SLP(\(scholarshipModel.scholar_percentage!)%)"
        }

        if scholarshipModel.account_mmr_latest != nil && scholarshipModel.account_mmr_start != nil{
            let mmrlatestStr : NSMutableAttributedString = NSMutableAttributedString.init(string: scholarshipModel.account_mmr_latest!, attributes:[.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1.0)])
            var mmrAddStr : NSAttributedString?
            if Float(scholarshipModel.account_mmr_latest!)! > Float(scholarshipModel.account_mmr_start!)! {
                let addFloat = Float(scholarshipModel.account_mmr_latest!)! - Float(scholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (+\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
            }else{
                let addFloat = Float(scholarshipModel.account_mmr_latest!)! - Float(scholarshipModel.account_mmr_start!)!
                mmrAddStr = NSAttributedString.init(string: " (\(lroundf(addFloat)))", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
            }
            mmrlatestStr.append(mmrAddStr!)
            self.mmrLabelView.rightLabel.attributedText = mmrlatestStr
        }
        if scholarshipModel.start_timestamp != nil{
            self.startDateLabelView.rightLabel.text = getLocalDate(from: scholarshipModel.start_timestamp!)
            
        }
        
        if scholarshipModel.end_timestamp != nil{
            let date = dateFromString(string: scholarshipModel.end_timestamp!)
            self.endDateLabelView.rightLabel.text = getLocalDate(from: stringFromDate(date: date))
        }else{
            if scholarshipModel.start_timestamp != nil && scholarshipModel.offer_period != nil{
                let date = dateFromString(string: scholarshipModel.start_timestamp!)
                let new = date.addingTimeInterval(TimeInterval(Int(scholarshipModel.offer_period!)! * 24 * 60 * 60))
                self.endDateLabelView.rightLabel.text = getLocalDate(from: stringFromDate(date: new))
            }
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
    
    lazy var earnTotalLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total return"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
//    lazy var scholarPercentLabelView : LabelAndLabelInterView = {
//        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
//        tempLabelView.leftLabel.text = "Scholar percentage"
//        self.contentView.addSubview(tempLabelView)
//        return tempLabelView
//    }()
    lazy var mmrLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "MMR"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var startDateLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Start date"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var endDateLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "End date"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
}
