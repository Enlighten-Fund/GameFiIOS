//
//  EmptyView.swift
//  GameFi
//
//  Created by lu chen on 2022/1/12.
//

import Foundation
import UIKit
import SnapKit

class EmptyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var typeLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var totalLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 25)
        self.addSubview(tempLabel)
        return tempLabel
    }()

    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
}
