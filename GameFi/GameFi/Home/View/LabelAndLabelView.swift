//
//  LabelAndLabelView.swift
//  GameFi
//
//  Created by harden on 2021/11/5.
//

import Foundation
import UIKit
import SnapKit

class LabelAndLabelView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15)
            make.height.equalTo(35)
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
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "PingFang SC Regular", size: 15)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont(name: "PingFang SC Medium", size: 15)
        self.addSubview(tempLabel)
        return tempLabel
    }()
}


