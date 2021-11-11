//
//  TextViewCell.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
let textViewCellIdentifier:String = "TextViewCell"
class TextViewCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.textView?.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.height.equalTo(130)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 30)
        })
    }
    
    lazy var textView : UITextView? = {
        let tempTextView = UITextView.init(frame: CGRect.zero)
        tempTextView.textColor = .white
        tempTextView.font = UIFont.systemFont(ofSize: 15)
        tempTextView.layer.borderWidth = 0.5
        tempTextView.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        tempTextView.backgroundColor = UIColor(red: 0.11, green: 0.12, blue: 0.18, alpha: 1)
        tempTextView.layer.cornerRadius = 5
        tempTextView.layer.masksToBounds = true
        tempTextView.autocapitalizationType = .none
        self.contentView.addSubview(tempTextView)
        return tempTextView
    }()
}
