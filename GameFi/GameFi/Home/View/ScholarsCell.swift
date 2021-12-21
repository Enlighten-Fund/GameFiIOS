//
//  HomeCollectionCell.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
import Kingfisher

let scholarsCelldentifier:String = "ScholarsCell"

class ScholarsCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.accountImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accountImgView.snp.bottom)
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
        
        self.avgMmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.avgPerformaceLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgMmrLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.totalPlayTimeLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.avgPerformaceLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.availableLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.totalPlayTimeLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
    }

    func update(scholarModel:ScholarModel) {
        if scholarModel.avatar != nil {
            self.accountImgView.kf.setImage(with: URL.init(string: scholarModel.avatar!), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
                
            }
        }
        if scholarModel.username != nil {
            self.accountLabel.text = scholarModel.username
        }
        if scholarModel.credit_score != nil {
            self.creditLabel.text = "Credit: \(scholarModel.credit_score!)"
        }
        if scholarModel.rent_days != nil {
            self.avgMmrLabelView.rightLabel.textColor = UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
            if scholarModel.rent_days! >= 3 && scholarModel.total_mmr_day != nil && scholarModel.rent_days != nil{
                let averageMMR = scholarModel.total_mmr_day! / scholarModel.rent_days!
                self.avgMmrLabelView.rightLabel.text = String(averageMMR)
                if scholarModel.total_mmr_change != nil && scholarModel.rent_times != nil{
                    let a = scholarModel.total_mmr_change! / scholarModel.rent_times!
                    if a > 0{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "+\(a)", attributes: [.font: UIFont(name: "PingFang SC Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.23, green: 0.9, blue: 0.37,alpha:1.0)])
                    }else{
                        self.avgPerformaceLabelView.rightLabel.attributedText = NSAttributedString.init(string: "\(a)", attributes: [.font: UIFont(name: "Avenir Next Medium", size: 15) as Any,.foregroundColor: UIColor(red: 0.97, green: 0.24, blue: 0.24,alpha:1.0)])
                    }
                }
            }else{
                if scholarModel.mmr != nil{
                    self.avgMmrLabelView.rightLabel.text = scholarModel.mmr
                    self.avgMmrLabelView.rightLabel.textColor = .white
                }
                self.avgPerformaceLabelView.rightLabel.text = "-"
            }
        }
        if scholarModel.rent_days != nil {
            self.totalPlayTimeLabelView.rightLabel.text =  "\(scholarModel.rent_days!) days"
        }
        
        if scholarModel.available_time != nil {
            self.availableLabelView.update(leftTitle: "Available time", rithtTitle: "\(scholarModel.available_time!) hrs/day")
        }
    }
    
    lazy var accountImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        tempImgView.layer.masksToBounds = true
        tempImgView.layer.cornerRadius = 25
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var accountLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var creditLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var avgMmrLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg MMR"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var avgPerformaceLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Avg Performace"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var totalPlayTimeLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total Play Time"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()

    lazy var availableLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Availability"
        self.addSubview(tempLabelView)
        return tempLabelView
    }()
}
