//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit
class RegisterHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.welcomeLabel!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 20)
        }
        self.loginLabel!.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel!.snp.bottom).offset(10)
            make.height.equalTo(15)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(self.loginLabel!.intrinsicContentSize.width + 10)
        }
        self.loginBtn.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel!.snp.bottom).offset(10)
            make.height.equalTo(15)
            make.left.equalTo(loginLabel!.snp.right)
            make.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var welcomeLabel : UILabel? = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "Welcome!")
        label.frame = CGRect(x: 15, y: 110.5, width: 185.5, height: 17)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Avenir Next Bold", size: 17) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        self.addSubview(label)
        return label
    }()
    
    lazy var loginLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Already have an account?"
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = .white
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var loginBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Sign in", for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1.000000), for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1,alpha:1.000000), for: .highlighted)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
