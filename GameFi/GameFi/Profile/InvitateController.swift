//
//  InvitateController.swift
//  GameFi
//
//  Created by harden on 2021/12/20.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh
import AWSMobileClient

class InvitateController: ViewController {
    var invitateCode = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invitation"
        self.subTitleLabel?.snp.makeConstraints({ make in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(40)
        })
        self.contentLabel?.snp.makeConstraints({ make in
            make.center.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        })
        self.copyBtn?.snp.makeConstraints({ make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.contentLabel!.snp.bottom)
            make.width.equalTo(200)
            make.height.equalTo(40)
        })
        self.request()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    @objc func copyBtnClick(){
        UIPasteboard.general.string = String(self.invitateCode)
        self.mc_text("Copied successfully!")
    }
    
    func request(){
        self.mc_loading()
        DataManager.sharedInstance.fetchInviatateCode { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    let dic : [String:AnyObject] = reponse as! [String : AnyObject]
                    self.invitateCode = dic["invite_code"] as! Int
                    
                }
            }
        }
    }
    
    lazy var subTitleLabel: UILabel? = {
        let temp = UILabel.init(frame: CGRect.zero)
        temp.font = UIFont(name: "Avenir Heavy", size: 16)
        temp.text = "Your own invitation code"
        temp.textColor = .white
        view.addSubview(temp)
        return temp
    }()
    lazy var contentLabel: UILabel? = {
        let temp = UILabel.init(frame: CGRect.zero)
        temp.font = UIFont(name: "Avenir Heavy", size: 14)
        temp.text = "invitation_code"
        temp.textColor = .white
        temp.textAlignment = .center
        view.addSubview(temp)
        return temp
    }()
    lazy var copyBtn: UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.layer.cornerRadius = 3
        tempBtn.layer.masksToBounds = true
        tempBtn.setTitleColor(.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempBtn.setTitle("Copy", for: .normal)
        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.view.addSubview(tempBtn)
        return tempBtn
    }()
}
