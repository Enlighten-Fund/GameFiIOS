//
//  RegisterHeadView.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit
import SnapKit
class RegisterFootView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var scholarBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "shop"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "shop_1"), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var scholarTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a scholar", for: .normal)
        tempBtn.setTitle("I'm a scholar", for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var managerBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "shop"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "shop_1"), for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var managerTitleBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("I'm a manager", for: .normal)
        tempBtn.setTitle("I'm a manager", for: .selected)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var privacyBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setImage(UIImage.init(named: "tips"), for: .normal)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
