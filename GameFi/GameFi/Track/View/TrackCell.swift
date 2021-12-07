//
//  TrackCell.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit

let trackCellIdentifier:String = "TrackCell"

class LabelAndLabelInterView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 30 - 30)
            make.height.equalTo(20)
        }
        self.rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftLabel.snp.right).offset(0)
            make.right.equalToSuperview()
            make.height.equalTo(35)
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
        tempLabel.textColor =  UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        self.addSubview(tempLabel)
        return tempLabel
    }()
}

class TrackCell: TableViewCell {

    override func makeConstraints() {
        super.makeConstraints()
        self.bgView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(165 + 15 + 25)
        }
        self.accountView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview()
            make.height.equalTo(45)
        }
        self.accountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            make.height.equalTo(45)
        }
        self.moreBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(self.accountLabel)
            make.height.equalTo(25)
            make.width.equalTo(20)
        }
        self.typeImgView.snp.makeConstraints { make in
            make.right.equalTo(self.moreBtn.snp.left)
            make.centerY.equalTo(self.accountLabel)
            make.height.equalTo(20)
            make.width.equalTo(120)
        }
        
        self.totalInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.accountLabel.snp.bottom)
            make.height.equalTo(25)
        }
        self.unclaimedLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.totalInterView.snp.bottom)
            make.height.equalTo(25)
        }
        self.managerInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.unclaimedLabelInterView.snp.bottom)
            make.height.equalTo(25)
        }
        self.scholarLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.managerInterView.snp.bottom)
            make.height.equalTo(25)
        }
        self.mmrLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.scholarLabelInterView.snp.bottom)
            make.height.equalTo(25)
        }
        self.nextClaimLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.mmrLabelInterView.snp.bottom)
            make.height.equalTo(25)
        }
    }
    
    func update(trackModel:TrackModel)  {
        self.accountLabel.text = trackModel.name
        self.totalInterView.rightLabel.text = trackModel.slp_total! + " SLP"
        self.unclaimedLabelInterView.rightLabel.text = String(lroundf(Float(trackModel.slp_total!)! - Float(trackModel.slp_balance!)!)) + " SLP"
        self.managerInterView.rightLabel.text = String(lroundf(Float(trackModel.manager_percentage!)! / 100.0 * Float(trackModel.slp_total!)!)) + " SLP"
        self.scholarLabelInterView.rightLabel.text = String(lroundf(Float(trackModel.scholar_percentage!)! / 100.0 * Float(trackModel.slp_total!)!)) + " SLP"
        self.mmrLabelInterView.rightLabel.text = trackModel.mmr
        let nowInterval = Date.init().timeIntervalSince1970
        if nowInterval - trackModel.last_claim_timestamp_sec! >= 14 * 24 * 60 * 60 {
            self.nextClaimLabelInterView.rightLabel.text = "Claim is ready"
        }else{
            let day = (trackModel.last_claim_timestamp_sec! + 14 * 24 * 60 * 60 - nowInterval) / (24 * 60 * 60) + 1
            let a = Int(day)
            self.nextClaimLabelInterView.rightLabel.text = "In \(a) days "
            self.nextClaimLabelInterView.rightLabel.textColor = .orange
        }
        if trackModel.type == "MANAGER" {
            self.accountView.backgroundColor = UIColor(red: 0.11, green: 0.4, blue: 0.4, alpha: 1)
            self.moreBtn.isHidden = true
            self.typeImgView.image = UIImage.init(named: "track_manager")
        }else if trackModel.type == "SCHOLAR"{
            self.accountView.backgroundColor = UIColor(red: 0.16, green: 0.29, blue: 0.5, alpha: 1)
            self.moreBtn.isHidden = true
            self.typeImgView.image = UIImage.init(named: "track_scholar")
        }else{
            self.accountView.backgroundColor = .clear
            self.moreBtn.isHidden = false
            self.typeImgView.image = UIImage.init(named: "track_self")
        }
    }
    
    lazy var bgView : UIView = {
        let temp = UIView.init(frame: CGRect.zero)
        temp.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        temp.layer.cornerRadius = 5
        temp.layer.masksToBounds = true
        temp.clipsToBounds = true
        self.contentView.addSubview(temp)
        return temp
    }()
    
    lazy var accountView : UIView = {
        let temp = UIView.init(frame: CGRect.zero)
        temp.backgroundColor = UIColor(red: 0.16, green: 0.29, blue: 0.5, alpha: 1)
        self.bgView.addSubview(temp)
        return temp
    }()
    
    lazy var accountLabel : UILabel = {
        let temp = UILabel.init(frame: CGRect.zero)
        temp.font = UIFont(name: "Avenir Next Medium", size: 15)
        temp.textColor = .white
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var moreBtn : UIButton = {
        let temp = UIButton.init(frame: CGRect.zero)
        temp.setImage(UIImage.init(named: "more"), for: .normal)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var typeImgView : UIImageView = {
        let temp = UIImageView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var totalInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "Total"
        self.contentView.addSubview(temp)
        return temp
    }()
    
    lazy var unclaimedLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "Unclaimed"
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var managerInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "Manager"
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var scholarLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "Scholar"
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var mmrLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "MMR"
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var nextClaimLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        temp.leftLabel.text = "Next claim"
        self.contentView.addSubview(temp)
        return temp
    }()
}
