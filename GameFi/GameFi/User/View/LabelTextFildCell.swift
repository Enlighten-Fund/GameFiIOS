//
//  LabelTextFildCell.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
let labelTextFildCellIdentifier:String = "LabelTextFildCell"
class LabelTextFildCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.textFild?.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
        })
    }
    
    lazy var textFild : UITextField? = {
        let tempTextField = UITextField.init(frame: CGRect.zero)
        tempTextField.textColor = .white
        tempTextField.font = UIFont.systemFont(ofSize: 15)
        tempTextField.layer.borderWidth = 0.5
        tempTextField.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        tempTextField.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        tempTextField.layer.cornerRadius = 5
        tempTextField.layer.masksToBounds = true
        tempTextField.autocapitalizationType = .none
        self.contentView.addSubview(tempTextField)
        return tempTextField
    }()
}
