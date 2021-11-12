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
        self.accountImgView.image = UIImage.init(named: "portrait")
        if scholarModel.scholar_portrait != nil {
            self.accountImgView.kf.setImage(with: URL.init(string: scholarModel.scholar_portrait!))
        }
        if scholarModel.username != nil {
            self.accountLabel.text = scholarModel.username
        }
        if scholarModel.credit_score != nil {
            self.creditLabel.text = "Credit: \(scholarModel.credit_score!)"
        }
        if scholarModel.mmr != nil {
            self.mmrLabelView.update(leftTitle: "MMR(avg)", rithtTitle: scholarModel.mmr!)
            self.mmrLabelView.rightLabel.textColor = UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
        }
        if scholarModel.winrate != nil {
            self.winRateLabelView.update(leftTitle: "Win rate", rithtTitle: scholarModel.winrate!)
        }
      
        if scholarModel.scholar_since != nil {
            self.expLabelView.update(leftTitle: "Exp.", rithtTitle: scholarModel.scholar_since!)
        }
        if scholarModel.available_time != nil {
            self.availabelLabelView.update(leftTitle: "Available", rithtTitle: scholarModel.available_time!)
        }

    }
    
    lazy var accountImgView : UIImageView = {
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
