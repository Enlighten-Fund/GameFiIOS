//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit
class RegisterFootView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.scholarTitleBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 40)/2.0)
            make.height.equalTo(40)
        }
        
        self.managerTitleBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 40)/2.0)
            make.height.equalTo(40)
        }
        self.privacyBtn.snp.makeConstraints { make in
            make.top.equalTo(self.scholarTitleBtn.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        self.privacyLabel1.snp.makeConstraints { make in
            make.centerY.equalTo(self.privacyBtn)
            make.left.equalTo(self.privacyBtn.snp.right).offset(10)
            make.width.equalTo(self.privacyLabel1.intrinsicContentSize.width + 1)
            make.height.equalTo(40)
        }
        
        self.privacyLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(self.privacyBtn)
            make.left.equalTo(self.privacyLabel1.snp.right)
            make.width.equalTo(self.privacyLabel2.intrinsicContentSize.width + 1)
            make.height.equalTo(40)
        }
        
        self.privacyLabel3.snp.makeConstraints { make in
            make.centerY.equalTo(self.privacyBtn)
            make.left.equalTo(self.privacyLabel2.snp.right)
            make.width.equalTo(self.privacyLabel3.intrinsicContentSize.width + 1)
            make.height.equalTo(40)
        }
        
        self.privacyLabel4.snp.makeConstraints { make in
            make.centerY.equalTo(self.privacyBtn)
            make.left.equalTo(self.privacyLabel3.snp.right)
            make.width.equalTo(self.privacyLabel4.intrinsicContentSize.width + 1)
            make.height.equalTo(40)
        }
        self.registerBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.privacyLabel1.snp.bottom).offset(20)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var scholarTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a scholar", for: .normal)
        tempBtn.setTitle("I'm a scholar", for: .selected)
        tempBtn.setTitle("I'm a scholar", for: .highlighted)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .selected)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .highlighted)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.borderColor = UIColor.init(hexString: "#5D8FFF").cgColor
        tempBtn.layer.borderWidth = 0.5
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var managerTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a manager", for: .normal)
        tempBtn.setTitle("I'm a manager", for: .selected)
        tempBtn.setTitle("I'm a manager", for: .highlighted)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .selected)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .highlighted)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.borderColor = UIColor.white.cgColor
        tempBtn.layer.borderWidth = 0.5
        
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var privacyBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setBackgroundImage(UIImage.init(named: ""), for: .normal)
        tempBtn.setBackgroundImage(UIImage.init(named: ""), for: .highlighted)
        tempBtn.setBackgroundImage(UIImage.init(named: "pravicy_select"), for: .selected)
        tempBtn.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.borderWidth = 1
        tempBtn.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var privacyLabel1 : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = .white
        tempLabel.text = "Accept the "
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var privacyLabel2 : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1)
        tempLabel.text = "Privacy Policy"
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var privacyLabel3 : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = .white
        tempLabel.text = " and "
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var privacyLabel4 : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1)
        tempLabel.text = "Terms of Service"
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var registerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign Up", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
