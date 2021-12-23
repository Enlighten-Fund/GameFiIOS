//
//  PostScholarshipCell.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
let postScholarshipCellIdentifier:String = "PostScholarshipCell"
class PostScholarshipCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.leftLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15)
            make.height.equalTo(40)
        }
        self.rightLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(self.leftLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }
        self.leftLabel1.snp.makeConstraints { make in
            make.top.equalTo(self.leftLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15)
            make.height.equalTo(40)
        }
        self.rightLabel1.snp.makeConstraints { make in
            make.top.equalTo(self.rightLabel.snp.bottom)
            make.left.equalTo(self.leftLabel1.snp.right).offset(0)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }
    }
    
    func update(isDeposit: Bool){
        if UserManager.sharedInstance.userinfoModel?.platform_fee != nil{
            self.rightLabel1.text = "\(UserManager.sharedInstance.userinfoModel!.platform_fee!)%"
            self.rightLabel.text = "\(100 - 50 - UserManager.sharedInstance.userinfoModel!.platform_fee!)%"
        }
       
    }
    
    lazy var bgView : UIView = {
        let tempView = UIView.init(frame: CGRect.zero)
        tempView.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempView.layer.cornerRadius = 5
        tempView.layer.masksToBounds = true
        self.contentView.addSubview(tempView)
        return tempView
    }()
    
    lazy var leftLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempLabel.text = "  Scholar percentage"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var leftLabel1 : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.text = "  Platform percentage"
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel1 : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.text = "\(UserManager.sharedInstance.userinfoModel?.platform_fee)%"
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}

