//
//  ScholarDetailCell.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import UIKit
let scholarDetailCellIdentifier:String = "ScholarDetailCell"
class ScholarDetailCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.titleLabel?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(0)
            make.height.equalTo(30)
            make.width.equalTo(200)
        })
        self.contentLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(0)
        })
    }
    
    func update(title:String,content:String){
        self.titleLabel?.text = title
        self.contentLabel.text = content
    }
    
    lazy var titleLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 16)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var contentLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 15)
        tempLabel.textColor = .white
        tempLabel.layer.cornerRadius = 10
        tempLabel.layer.masksToBounds = true
        tempLabel.numberOfLines = 0
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}
