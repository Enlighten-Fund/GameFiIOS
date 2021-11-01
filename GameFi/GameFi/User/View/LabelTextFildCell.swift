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
        self.titleLabel?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        })
        self.textFild?.snp.makeConstraints({ make in
            make.top.equalTo(self.titleLabel!)
            make.left.equalTo(self.titleLabel!.snp.right)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
        })
        self.tipLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.textFild!.snp.bottom)
            make.left.equalTo(self.textFild!.snp.left)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        })
    }
    
    func update(model:LabelTFTipModel){
        if model.tip.isBlank {
            self.tipLabel.isHidden = true
        }
        self.tipLabel.text = model.tip
        self.titleLabel?.text = model.title
        self.textFild?.text = model.text
    }
    
    lazy var titleLabel : UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var textFild : UITextField? = {
        let tempTextField = UITextField.init(frame: CGRect.zero)
        tempTextField.borderStyle = .roundedRect
        self.contentView.addSubview(tempTextField)
        return tempTextField
    }()
    
    lazy var tipLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .red
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
}
