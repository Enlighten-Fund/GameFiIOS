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
        tempLabel.isHidden = true
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
        self.totalContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.unclaimedContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.managerContentView.snp.makeConstraints { make in
            make.top.equalTo(self.totalContentView.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.scholarContentView.snp.makeConstraints { make in
            make.top.equalTo(self.unclaimedContentView.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
//        self.averageContentView.snp.makeConstraints { make in
//            make.top.equalTo(self.scholarContentView.snp.bottom).offset(10)
//            make.left.equalToSuperview()
//            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
//            make.height.equalTo(100)
//        }
//        self.totalContentView.snp.makeConstraints { make in
//            make.top.equalTo(self.managerContentView.snp.bottom).offset(10)
//            make.right.equalToSuperview()
//            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
//            make.height.equalTo(100)
//        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(trackSumModel:TrackSumModel) {
        if trackSumModel.track_slp_total != nil && trackSumModel.scholar_slp_total != nil && trackSumModel.manager_slp_total != nil{
            let total = Float(trackSumModel.track_slp_total!)! + Float(trackSumModel.scholar_slp_total!)! + Float(trackSumModel.manager_slp_total!)!
            self.totalContentView.totalLabel.text = String(lroundf(total))
        }
        if trackSumModel.track_slp_total != nil
            && trackSumModel.track_slp_balance != nil
            && trackSumModel.scholar_slp_total != nil
            && trackSumModel.scholar_slp_balance != nil
            && trackSumModel.manager_slp_total != nil
            && trackSumModel.manager_slp_balance != nil{
            let track = Float(trackSumModel.track_slp_total!)! - Float(trackSumModel.track_slp_balance!)!
            let scholar = Float(trackSumModel.scholar_slp_total!)! - Float(trackSumModel.scholar_slp_balance!)!
            let manager = Float(trackSumModel.manager_slp_total!)! - Float(trackSumModel.manager_slp_balance!)!
            self.unclaimedContentView.totalLabel.text = String(lroundf(track + scholar + manager))
        }
        if trackSumModel.track_slp_manager != nil && trackSumModel.scholar_slp_manager != nil && trackSumModel.manager_slp_manager != nil{
            let total = Float(trackSumModel.track_slp_manager!)! + Float(trackSumModel.scholar_slp_manager!)! + Float(trackSumModel.manager_slp_manager!)!
            self.managerContentView.totalLabel.text =  String(lroundf(total))
        }
        if trackSumModel.track_slp_scholar != nil && trackSumModel.scholar_slp_scholar != nil && trackSumModel.manager_slp_scholar != nil{
            let total = Float(trackSumModel.track_slp_scholar!)! + Float(trackSumModel.scholar_slp_scholar!)! + Float(trackSumModel.manager_slp_scholar!)!
            self.scholarContentView.totalLabel.text =  String(lroundf(total))
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
