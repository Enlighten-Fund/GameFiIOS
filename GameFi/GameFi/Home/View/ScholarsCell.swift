//
//  HomeCollectionCell.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
let scholarsCelldentifier:String = "ScholarsCell"

class ScholarsCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.axieImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-18)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView.snp.bottom)
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
        
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.winRateLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.expLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.winRateLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.availabelLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.expLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
    }

    func update(scholarModel:ScholarModel) {
        self.axieImgView.image = UIImage.init(named: "explore_select")
        self.accountLabel.text = scholarModel.username
        self.creditLabel.text = "Credit: \(scholarModel.credit_score!)"
//        self.mmrLabelView.update(leftTitle: "MMR(avg)", rithtTitle: scholarModel.m)
        self.mmrLabelView.rightLabel.textColor = UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
//        self.winRateLabelView.update(leftTitle: "Win rate", rithtTitle: "60%")
//        self.expLabelView.update(leftTitle: "Exp.", rithtTitle: ">6 months")
//        self.availabelLabelView.update(leftTitle: "Available", rithtTitle: "6 hrs/day")
    }
    
    lazy var axieImgView : UIImageView = {
        let tempImgView = UIImageView.init()
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
    
    lazy var mmrLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var winRateLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var expLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var availabelLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
}
