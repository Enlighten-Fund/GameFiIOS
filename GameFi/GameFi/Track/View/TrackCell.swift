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
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 30)
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
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
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
            make.height.equalTo(140)
        }
        self.accountLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(20)
        }
        self.todayInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.accountLabelInterView.snp.bottom)
            make.height.equalTo(20)
        }
        self.averageLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.todayInterView.snp.bottom)
            make.height.equalTo(20)
        }
        self.mmrLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.averageLabelInterView.snp.bottom)
            make.height.equalTo(20)
        }
        self.managerLabelInterView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.mmrLabelInterView.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    func update(trackModel:TrackModel)  {
        
    }
    
    lazy var bgView : UIView = {
        let temp = UIView.init(frame: CGRect.zero)
        temp.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        temp.layer.cornerRadius = 5
        temp.layer.masksToBounds = true
        self.contentView.addSubview(temp)
        return temp
    }()
    
    lazy var accountLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var todayInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var averageLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var mmrLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
    lazy var managerLabelInterView : LabelAndLabelInterView = {
        let temp = LabelAndLabelInterView.init(frame: CGRect.zero)
        self.contentView.addSubview(temp)
        return temp
    }()
}
