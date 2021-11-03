//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit

class SubmitView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.submitBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var submitBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("OK", for: .normal)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempBtn.backgroundColor = .blue
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(.white, for: .highlighted)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
