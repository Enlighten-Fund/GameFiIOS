//
//  DepositView.swift
//  GameFi
//
//  Created by harden on 2021/12/22.
//

import Foundation
import UIKit
import SnapKit

class DepositView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        self.depositSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(0)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var titleLabel : UILabel = {
        let temp = UILabel.init(frame: CGRect.zero)
        temp.text = "Automatic posting"
        temp.textColor = .white
        temp.font = UIFont(name: "Avenir Next Regular", size: 15)
        self.addSubview(temp)
        return temp
    }()
    lazy var depositSwitch : UISwitch = {
        let temp = UISwitch.init()
        temp.isOn = true
        self.addSubview(temp)
        return temp
    }()
}
