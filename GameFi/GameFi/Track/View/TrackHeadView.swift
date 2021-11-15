//
//  TrackHeadView.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit
import SnapKit

class TrackContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.iconImgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        self.typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        self.totalLabel.snp.makeConstraints { make in
            make.top.equalTo(self.typeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(120)
            make.height.equalTo(25)
        }
        self.usdLabel.snp.makeConstraints { make in
            make.top.equalTo(self.totalLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
    }
    
    func update(total:String,usd:String) {
        self.totalLabel.text = total
        self.usdLabel.text = usd
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var typeLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var totalLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 25)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var usdLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font =  UIFont(name: "Avenir Next Medium", size: 12)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
}

class TrackHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.unclaimedContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.roninContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.scholarContentView.snp.makeConstraints { make in
            make.top.equalTo(self.unclaimedContentView.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.managerContentView.snp.makeConstraints { make in
            make.top.equalTo(self.roninContentView.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.averageContentView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarContentView.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.totalContentView.snp.makeConstraints { make in
            make.top.equalTo(self.managerContentView.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(trackSumModel:TrackSumModel) {
        if trackSumModel.track_slp_total != nil {
            self.unclaimedContentView.totalLabel.text = trackSumModel.track_slp_total
        }
        if trackSumModel.track_slp_scholar != nil {
            self.scholarContentView.totalLabel.text = trackSumModel.track_slp_scholar
        }
        if trackSumModel.track_slp_checkpoint != nil {
            self.averageContentView.totalLabel.text = trackSumModel.track_slp_checkpoint
        }
    }
    
    lazy var unclaimedContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "unclaimed")
        temp.typeLabel.text = "Unclaimed SLP"
        self.addSubview(temp)
        return temp
    }()
    lazy var roninContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "ronin")
        temp.typeLabel.text = "Ronin Account"
        self.addSubview(temp)
        return temp
    }()
    lazy var scholarContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "scholar")
        temp.typeLabel.text = "Scholar"
        self.addSubview(temp)
        return temp
    }()
    lazy var managerContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "manager")
        temp.typeLabel.text = "Manager"
        self.addSubview(temp)
        return temp
    }()
    lazy var averageContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "average")
        temp.typeLabel.text = "Average SLP"
        self.addSubview(temp)
        return temp
    }()
    lazy var totalContentView  : TrackContentView = {
        let temp = TrackContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "total")
        temp.typeLabel.text = "Total"
        self.addSubview(temp)
        return temp
    }()
    
}
