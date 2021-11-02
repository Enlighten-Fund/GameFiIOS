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
        self.scholarBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.scholarTitleBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.scholarBtn)
            make.left.equalTo(self.scholarBtn.snp.right).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        self.managerBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalTo(self.managerTitleBtn.snp.left).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.managerTitleBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.scholarBtn)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        self.loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.managerTitleBtn.snp.bottom).offset(20)
            make.width.equalTo(80)
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
    
    lazy var rememberBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "shop"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "shop_1"), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var rememberLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Remember me"
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    
    lazy var forgetPwdBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Forget", for: .normal)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var scholarBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "shop"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "shop_1"), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var scholarTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a scholar", for: .normal)
        tempBtn.setTitle("I'm a scholar", for: .selected)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var managerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "shop"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "shop_1"), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var managerTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a manager", for: .normal)
        tempBtn.setTitle("I'm a manager", for: .selected)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var loginBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Login in", for: .normal)
        tempBtn.backgroundColor = .blue
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var registerLabel : UILabel = {
        let tempLabel = UILabel.init()
        tempLabel.text = "Don't have an account? "
        tempLabel.textAlignment = .right
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var registerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign up", for: .normal)
        tempBtn.setTitleColor(.blue, for: .normal)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
