//
//  ProfileHeaderView.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ProfileHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        self.usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconImgView)
            make.left.equalTo(self.iconImgView.snp.right).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.usernameLabel.snp.bottom)
            make.left.equalTo(self.iconImgView.snp.right).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        self.creditLabel.snp.makeConstraints { make in
            make.top.equalTo(self.emailLabel.snp.bottom)
            make.left.equalTo(self.iconImgView.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        self.cetifiedBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.creditLabel.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(115)
            make.height.equalTo(35)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(userInfoModel : UserInfoModel) {
//        self.iconImgView.image = UIImage.init(named: "portrait")
        if userInfoModel.avatar != nil {
//            self.iconImgView.kf.setImage(with:URL.init(string: userInfoModel.avatar!))
            self.iconImgView.kf.setImage(with: URL.init(string: userInfoModel.avatar!), placeholder:  UIImage.init(named: "portrait"), options: nil) {result, error in
                
            }
        }
        if userInfoModel.username != nil {
            self.usernameLabel.text = userInfoModel.username
        }
        if userInfoModel.email != nil {
            self.emailLabel.text = userInfoModel.email
        }
        if userInfoModel.credit_score != nil {
            self.creditLabel.text = "Credit Score: \(userInfoModel.credit_score!)"
        }
        
    }
    
    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 65 / 2.0
        tempImgView.layer.masksToBounds = true
        self.addSubview(tempImgView)
        return tempImgView
    }()
    lazy var usernameLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 17)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var emailLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var creditLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = UIColor(red: 0.58, green: 0.62, blue: 0.78, alpha: 1)
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var cetifiedBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Certified now", for: .normal)
        tempBtn.setTitle("Certificated", for: .selected)
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitleColor(UIColor(red: 0.3, green: 0.82, blue: 0.43, alpha: 1), for: .selected)
        tempBtn.layer.cornerRadius = 5
        tempBtn.layer.masksToBounds = true
        tempBtn.layer.borderWidth = 0.5
        tempBtn.layer.borderColor = UIColor(red: 0.3, green: 0.82, blue: 0.43, alpha: 1).cgColor
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
}
