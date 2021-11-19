//
//  PostScholarFootView.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import Foundation
import UIKit
import SnapKit

class PostScholarFootView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cancelBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 35) / 2.0 )
            make.height.equalTo(40)
        }
        self.postBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 35) / 2.0 )
            make.height.equalTo(40)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var cancelBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Cancel", for: .normal)
        tempBtn.setTitle("Cancel", for: .selected)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(.white, for: .selected)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1).cgColor
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var postBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Save", for: .normal)
        tempBtn.setTitle("Save", for: .selected)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(.white, for: .selected)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.backgroundColor = UIColor(red: 0.36, green: 0.56, blue: 1, alpha: 1)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
