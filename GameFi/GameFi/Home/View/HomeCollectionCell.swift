//
//  HomeCollectionCell.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
let homeCollectionCellIdentifier:String = "HomeCollectionCell"

class HomeLabelAndLabelView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(40)
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
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont(name: "PingFang SC Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
}

class HomeCollectionCell: UICollectionViewCell {
    
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
        self.slpImgView.snp.makeConstraints { make in
            make.top.equalTo(self.creditLabel.snp.bottom)
            make.left.equalToSuperview().offset(14)
            make.height.equalTo(15)
            make.width.equalTo(15)
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
    }

    func update(scholarshipModel:ScholarshipModel) {
        self.axieImgView.image = UIImage.init(named: "explore_select")
        self.accountLabel.text = "Mr_isthestrangee"
        self.creditLabel.text = "Credit: 150"
        self.slpLabel.text = "160/day (60%)"
        self.offerLabelView.update(leftTitle: "Offer", rithtTitle: "14 Days")
        self.mmrLabelView.update(leftTitle: "MMR", rithtTitle: "1300")
        self.axiesLabelView.update(leftTitle: "Axies", rithtTitle: "4")
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
    
    lazy var slpImgView : UIImageView = {
        let tempImgView = UIImageView.init()
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
