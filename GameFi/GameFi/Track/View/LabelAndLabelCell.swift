//
//  LabelAndLabelCell.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
let labelAndLabelCellIdentifier:String = "LabelAndLabelCell"
class LabelAndLabelCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15)
            make.height.equalTo(50)
        }
        self.rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(-25)
            make.height.equalTo(50)
        }
    }
    
    lazy var leftLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var rightLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        tempLabel.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}
