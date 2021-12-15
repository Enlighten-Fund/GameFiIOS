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

class EditProfileBtnView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.leftBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        self.rightBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
        self.btn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(0)
            make.width.equalTo(IPhone_SCREEN_WIDTH - 70)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(userInfoModel : UserInfoModel) {
       if userInfoModel.scholar_status == "DRAFT" || userInfoModel.scholar_status == "NO"{
           self.leftBtn.snp.remakeConstraints { make in
               make.top.equalTo(self.snp.top).offset(0)
               make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
               make.height.equalTo(40)
               make.left.equalToSuperview().offset(15)
           }
           self.rightBtn.snp.remakeConstraints { make in
               make.top.equalTo(self.snp.top).offset(0)
               make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
               make.height.equalTo(40)
               make.right.equalToSuperview().offset(-15)
           }
           self.btn.snp.remakeConstraints { make in
               make.top.equalTo(self.snp.top).offset(0)
               make.width.equalTo(IPhone_SCREEN_WIDTH - 70)
               make.height.equalTo(0)
               make.right.equalToSuperview().offset(-15)
           }
        }else if userInfoModel.scholar_status == "AUDIT"{
            self.leftBtn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(10)
                make.width.equalTo(IPhone_SCREEN_WIDTH - 60)
                make.height.equalTo(0)
                make.left.equalToSuperview().offset(15)
            }
            self.rightBtn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(10)
                make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                make.height.equalTo(0)
                make.right.equalToSuperview().offset(-15)
            }
            self.btn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(0)
                make.width.equalTo(IPhone_SCREEN_WIDTH - 70)
                make.height.equalTo(40)
                make.right.equalToSuperview().offset(-15)
            }
            self.btn.setTitle("Recall", for: .normal)
            self.btn.setTitle("Recall", for: .highlighted)
        }else if userInfoModel.scholar_status == "YES"{
            self.leftBtn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(10)
                make.width.equalTo(IPhone_SCREEN_WIDTH - 60)
                make.height.equalTo(0)
                make.left.equalToSuperview().offset(15)
            }
            self.rightBtn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(10)
                make.width.equalTo((IPhone_SCREEN_WIDTH - 70)/2.0)
                make.height.equalTo(0)
                make.right.equalToSuperview().offset(-15)
            }
            self.btn.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(0)
                make.width.equalTo(IPhone_SCREEN_WIDTH - 70)
                make.height.equalTo(40)
                make.right.equalToSuperview().offset(-15)
            }
            self.btn.setTitle("Update", for: .normal)
            self.btn.setTitle("Update", for: .highlighted)
        }
    }
    
    lazy var leftBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Save", for: .normal)
        tempBtn.setTitle("Save", for: .highlighted)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
//        tempBtn.layer.borderWidth = 0.5
//        tempBtn.layer.borderColor = UIColor.white.cgColor
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var rightBtn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Submit", for: .normal)
        tempBtn.setTitle("Submit", for: .highlighted)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.setTitle("Update", for: .normal)
        tempBtn.setTitle("Update", for: .highlighted)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
