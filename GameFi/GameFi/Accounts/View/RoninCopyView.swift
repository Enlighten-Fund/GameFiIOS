//
//  RoninCopyView.swift
//  GameFi
//
//  Created by lu chen on 2022/1/12.
//

import Foundation
import UIKit
import SnapKit

class RoninCopyView: UIView {
    var ronin : String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.copyBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(20)
        }
        self.roninLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.copyBtn.snp.left)
            make.height.equalToSuperview()
            make.left.equalTo(self.roninTitleLabel.snp.right)
        }
        self.roninTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    func update(roninTitle:String?,ronin:String?){
        if ronin == nil || ronin!.isBlank{
            return
        }
        self.ronin = ronin
        let newRonin = ronin!.prefix(20) + "..." + ronin!.suffix(4)
        self.roninLabel.text = String(newRonin)
        self.roninTitleLabel.text = roninTitle
    }
    
    @objc func copyBtnClick(abtn:UIButton) {
        UIPasteboard.general.string = self.ronin
        self.mc_text("Copied successfully!")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var roninTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var roninLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.adjustsFontSizeToFitWidth = true
        tempLabel.textAlignment = .right
        self.addSubview(tempLabel)
        return tempLabel
    }()

    lazy var copyBtn : UIButton = {
        let temp = UIButton.init(frame: CGRect.zero)
        temp.setTitle("C", for: .normal)
        temp.setTitleColor(.red, for: .normal)
        temp.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.addSubview(temp)
        return temp
    }()
    
}
