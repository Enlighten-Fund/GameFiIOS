//
//  TrackHeadView.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit
import SnapKit

class BillContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.iconImgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(62)
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
    }
    
    func update(total:String) {
        self.totalLabel.text = total
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

    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
}

class BillHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.totalEarnContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.totalOWedContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(dic:[String : Float?]) {
        if dic["total_earn_value"] != nil{
            let total : Float? = dic["total_earn_value"]!
            if total != nil{
                self.totalEarnContentView.update(total: "\(lroundf(total!))")
            }
        }
        if dic["total_pay_value"] != nil{
            let total : Float? = dic["total_pay_value"]!
            if total != nil{
                self.totalOWedContentView.update(total: "\(lroundf(total!))")
            }
        }
    }
    
    lazy var totalEarnContentView  : BillContentView = {
        let temp = BillContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "total_earn")
        temp.typeLabel.text = "Total Earned"
        self.addSubview(temp)
        return temp
    }()
    lazy var totalOWedContentView  : BillContentView = {
        let temp = BillContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "total_owed")
        temp.typeLabel.text = "Total Owed"
        self.addSubview(temp)
        return temp
    }()
    
}
