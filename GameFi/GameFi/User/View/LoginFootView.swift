//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit

class LoginFootView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.forgetPwdBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        self.loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.forgetPwdBtn.snp.bottom).offset(10)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
            make.height.equalTo(40)
        }
        self.registerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-30)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(10)
            make.width.equalTo(self.registerLabel.intrinsicContentSize.width)
            make.height.equalTo(40)
        }
        self.registerBtn.snp.makeConstraints { make in
            make.left.equalTo(self.registerLabel.snp.right)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var forgetPwdBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Forget Password?", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "PingFang SC Regular", size: 15)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .highlighted)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var loginBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Log in", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var registerLabel : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.text = "Don't have an account? "
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont.systemFont(ofSize: 14)
        tempLabel.textColor = .white
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var registerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign up", for: .normal)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1), for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1), for: .highlighted)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
