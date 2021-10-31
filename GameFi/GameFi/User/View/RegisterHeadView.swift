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
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 20)
        }
        self.loginLabel!.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel!.snp.bottom).offset(0)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(self.loginLabel!.intrinsicContentSize.width + 10)
        }
        self.loginBtn.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel!.snp.bottom).offset(0)
            make.height.equalTo(30)
            make.left.equalTo(loginLabel!.snp.right)
            make.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var welcomeLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Welcome!"
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var loginLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Already have an account?"
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var loginBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Login", for: .normal)
        tempBtn.setTitleColor(.blue, for: .normal)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
