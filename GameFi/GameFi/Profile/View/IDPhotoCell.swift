//
//  IDPhotoCell.swift
//  GameFi
//
//  Created by harden on 2021/11/20.
//

import Foundation
import UIKit
let IDPhotoCellIdentifier:String = "IDPhotoCell"
class IDPhotoCell: TableViewCell {
    
    override func makeConstraints(){
        super.makeConstraints()
        self.bgImgView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        self.interImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.noticeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(self.btn.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.reUploadBtn.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    lazy var bgImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 5
        tempImgView.layer.masksToBounds = true
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var interImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.contentView.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setBackgroundImage(UIImage.init(named: "account_add"), for: .normal)
        tempBtn.setBackgroundImage(UIImage.init(named: "account_add"), for: .highlighted)
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
    lazy var noticeLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.font = UIFont(name: "Avenir Next Regular", size: 14)
        tempLabel.textColor = .white
        tempLabel.text = "Upload a photo holding your ID card.\nOnly used for authentication.\nDon't worry about the security."
        tempLabel.numberOfLines = 0
        tempLabel.textAlignment = .center
        self.contentView.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var reUploadBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.setTitle("Re-upload", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Regular", size: 12)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.isHidden = true
        self.contentView.addSubview(tempBtn)
        return tempBtn
    }()
}
