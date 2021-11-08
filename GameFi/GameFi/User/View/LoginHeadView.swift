//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit
class LoginHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.welcomeLabel!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var welcomeLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 17)
        tempLabel.text = "Welcome!"
        tempLabel.textColor = .white
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
}
