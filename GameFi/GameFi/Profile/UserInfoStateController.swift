//
//  ProfileController.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import UIKit
import SnapKit

class UserInfoStateController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.iconImgView!.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        self.tipLabel!.snp.makeConstraints { make in
            make.top.equalTo(self.iconImgView!.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        self.applyView!.snp.makeConstraints { make in
            make.height.equalTo(57)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarSafeBottomMargin)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
    }
    
    @objc func goToTavern()  {
        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        appdelegate.tabbarVC?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    lazy var iconImgView: UIImageView? = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.image = UIImage.init(named: "profile_update")
        view.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var tipLabel: UILabel? = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.text = "Your profile is under review and will be posted to Tavern after approval."
        tempLabel.numberOfLines = 0
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 15)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
        view.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var applyView: SubmitView? = {
        let tempView = SubmitView.init(frame: CGRect.zero)
        tempView.submitBtn.setTitle("Go to Tavern", for: .normal)
        tempView.submitBtn.addTarget(self, action: #selector(goToTavern), for: .touchUpInside)
        view.addSubview(tempView)
        return tempView
    }()
}


