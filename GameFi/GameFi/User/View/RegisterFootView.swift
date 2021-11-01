//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit
import YBAttributeTextTapAction
class RegisterFootView: UIView {
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
        self.privacyBtn.snp.makeConstraints { make in
            make.top.equalTo(self.scholarBtn.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(40)
            make.height.equalTo(40)
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
    
    lazy var privacyBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "tips"), for: .normal)
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
