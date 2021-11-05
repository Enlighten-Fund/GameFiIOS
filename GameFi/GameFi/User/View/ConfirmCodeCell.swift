//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit

let confirmCodeCellIdentifier:String = "ConfirmCodeCell"
class ConfirmCodeCell: LabelTextFildCell {
    
    override func makeConstraints() {
        super.makeConstraints()
        self.codeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    
    lazy var codeBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Send code", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .selected)
        tempBtn.setTitleColor(UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1), for: .highlighted)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
