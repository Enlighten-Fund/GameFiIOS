//
//  PickerViewCell.swift
//  GameFi
//
//  Created by harden on 2021/11/20.
//

import Foundation
import UIKit
let pickerViewCellIdentifier:String = "PickerViewCell"
class PickerViewCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.titleLabel?.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        })
        self.imgView?.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(10)
            make.right.equalToSuperview().offset(-15)
        })
    }
    
    lazy var titleLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.textColor = .white
        tempLabel.layer.borderWidth = 0.5
        tempLabel.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        tempLabel.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        tempLabel.layer.cornerRadius = 5
        tempLabel.layer.masksToBounds = true
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var imgView : UIImageView? = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.image = UIImage.init(named: "arrow_down")
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
}

