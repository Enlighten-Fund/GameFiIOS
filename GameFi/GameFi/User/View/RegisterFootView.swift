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
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.privacyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.privacyBtn)
            make.left.equalTo(self.privacyBtn.snp.right).offset(10)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 40)
            make.height.equalTo(40)
        }
        self.registerBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.privacyLabel.snp.bottom).offset(10)
            make.width.equalTo(80)
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
        tempBtn.setBackgroundImage(UIImage.init(named: ""), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var privacyLabel : UILabel = {
        let tempLabel = UILabel.init()
        var mutableStr :NSMutableAttributedString = NSMutableAttributedString(string: "Accept the Privacy Policy and Terms of Service")
        mutableStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.blue, range:NSRange(location:10, length:15))
        mutableStr.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.blue, range:NSRange(location:30, length:16))
        tempLabel.attributedText = mutableStr
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var registerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign Up", for: .normal)
        tempBtn.backgroundColor = .blue
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
