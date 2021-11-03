//
//  ViewController.swift
//  GameFi
//
//  Created by harden on 2021/10/25.
//

import UIKit
import AWSMobileClient
import SCLAlertView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
    }

        @objc func msgBtnClick() {
            AWSMobileClient.default().signOut { error in
                if let error = error  {
                    print("\(error.localizedDescription)")
                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                }
            }
        }
        lazy var msgBtn : UIButton? = {
            let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            tempBtn.setImage(UIImage.init(named: "message"), for: .normal)
            tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
           return tempBtn
        }()
}

