//
//  NotificationCell.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
let notificationCelllIdentifier:String = "NotificationCell"
class NotificationCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.bgView?.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        })
        self.titleLabel?.snp.makeConstraints({ make in
            make.bottom.equalTo(self.payBtn.snp.top).offset(-15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
        })
        self.payBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        })
        self.lineView!.snp.makeConstraints({ make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(10)
            make.right.equalToSuperview().offset(-15)
        })
    }
    
    func update(title:String){
        self.titleLabel?.text = title
       
    }
    
    lazy var bgView : UIView? = {
        let tempView = UIView.init(frame: CGRect.zero)
        tempView.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        tempView.layer.cornerRadius = 5
        tempView.layer.masksToBounds = true
        self.contentView.addSubview(tempView)
        return tempView
    }()
    
    lazy var titleLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.numberOfLines = 0
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var payBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Pay now", for: .normal)
        tempBtn.setTitle("Pay now", for: .highlighted)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(.white, for: .highlighted)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    lazy var lineView : UIView? = {
        let tempView = UIView.init(frame: CGRect.zero)
        tempView.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.contentView.addSubview(tempView)
        return tempView
    }()
}
