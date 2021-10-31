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
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        self.textFild!.snp.updateConstraints { make in
            make.right.equalToSuperview().offset(-65)
        }
    }
    
    
    lazy var codeBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Send", for: .normal)
        tempBtn.backgroundColor = .blue
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        tempBtn.setTitleColor(.white, for: .normal)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
