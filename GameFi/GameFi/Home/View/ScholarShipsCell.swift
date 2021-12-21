//
//  HomeCollectionCell.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
import Kingfisher

let scholarshipsCelldentifier:String = "ScholarshipsCollectionCell"

class HomeLabelAndLabelView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(65)
            make.height.equalTo(20)
        }
        self.rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(20)
        }
    }
    
    func update(leftTitle:String,rithtTitle:String) {
        self.leftLabel.text = leftTitle
        self.rightLabel.text = rithtTitle
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var leftLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "PingFang SC Regular", size: 13)
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont(name: "PingFang SC Medium", size: 13)
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
}

class ScholarshipsCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
        self.axieImgView1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(80)
        }
        
        self.axieImgView2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalTo(self.axieImgView1.snp.left).offset(30)
            make.height.equalTo(64)
            make.width.equalTo(80)
        }
        
        self.axieImgView3.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.axieImgView1.snp.right).offset(-30)
            make.height.equalTo(64)
            make.width.equalTo(80)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.axieImgView1.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview()
        }
        self.creditLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accountLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
        self.slpImgView.snp.makeConstraints { make in
            make.centerY.equalTo(self.slpLabel.snp.centerY)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        self.slpLabel.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(25)
            make.left.equalTo(self.slpImgView.snp.right)
        }
        self.offerLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.slpLabel.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.mmrLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.offerLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.axiesLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.mmrLabelView.snp.bottom)
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.left.equalToSuperview()
        }
        self.contentView.bringSubviewToFront(self.axieImgView2)
        self.contentView.bringSubviewToFront(self.axieImgView1)
        self.contentView.bringSubviewToFront(self.axieImgView3)
    }

    func update(scholarshipModel:ScholarshipModel) {
        if scholarshipModel.axie_briefArry == nil || scholarshipModel.axie_briefArry!.count < 3{
            
        }else{
            let axiePic1 : String = String(scholarshipModel.axie_briefArry![0])
            self.axieImgView1.kf.setImage(with: URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic1)/axie/axie-full-transparent.png"))
            let axiePic2 : String = String(scholarshipModel.axie_briefArry![1])
            self.axieImgView2.kf.setImage(with:  URL.init(string: "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic2)/axie/axie-full-transparent.png"))
            let axiePic3 : String = String(scholarshipModel.axie_briefArry![2])
            let urls = "https://storage.googleapis.com/assets.axieinfinity.com/axies/\(axiePic3)/axie/axie-full-transparent.png"
            self.axieImgView3.kf.setImage(with: URL.init(string:urls))
        }
        
        if scholarshipModel.manager_user_name == nil {
            self.accountLabel.text = ""
        }else{
            self.accountLabel.text = scholarshipModel.manager_user_name!
        }
        
        if scholarshipModel.credit_score == nil {
            self.creditLabel.text = "Credit:"
        }else{
            self.creditLabel.text = "Credit: \(scholarshipModel.credit_score!)"
        }
        
        if scholarshipModel.estimate_daily_slp != nil && scholarshipModel.scholar_percentage != nil {
            self.slpLabel.text = "\(scholarshipModel.estimate_daily_slp!)/day (\(scholarshipModel.scholar_percentage!)%)"
        }
        if scholarshipModel.offer_period != nil {
            self.offerLabelView.update(leftTitle: "Offer", rithtTitle: "\(scholarshipModel.offer_period!) Days")
        }
        if scholarshipModel.mmr != nil {
            self.mmrLabelView.update(leftTitle: "MMR", rithtTitle: scholarshipModel.mmr!)
        }
        if scholarshipModel.axie_count != nil  {
            self.axiesLabelView.update(leftTitle: "Axies", rithtTitle: scholarshipModel.axie_count!)
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
    
    lazy var slpImgView : UIImageView = {
        let tempImgView = UIImageView.init()
        tempImgView.image = UIImage.init(named: "slp")
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var slpLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 1, green: 0.72, blue: 0.07, alpha: 1)
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        tempLabel.textAlignment = .right
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var offerLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var mmrLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var axiesLabelView : HomeLabelAndLabelView = {
        let tempLabelView = HomeLabelAndLabelView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
}
