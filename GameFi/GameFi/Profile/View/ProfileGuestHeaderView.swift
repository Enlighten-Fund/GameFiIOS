//
//  ProfileGuestHeaderView.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import UIKit
import SnapKit

class ProfileGuestHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        self.welcomeLabel.snp.makeConstraints { make in
            make.left.equalTo(self.iconImgView.snp.right).offset(10)
            make.centerY.equalTo(self.iconImgView)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        self.signBtn.snp.makeConstraints { make in
            make.top.equalTo(self.iconImgView.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(50)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 65 / 2.0
        tempImgView.layer.masksToBounds = true
        tempImgView.image = UIImage.init(named: "portrait")
        self.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var welcomeLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Welcome"
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 17)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var signBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign in", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempBtn.titleLabel?.textColor = .white
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
}
