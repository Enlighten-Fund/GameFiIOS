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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftBtn!)
    }

        @objc func msgBtnClick() {
            AWSMobileClient.default().signOut { error in
                if let error = error  {
                    print("\(error.localizedDescription)")
                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                }
            }
        }
    
    
    @objc func leftBtnClick() {
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }
    }
    
        lazy var msgBtn : UIButton? = {
            let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
            tempBtn.setImage(UIImage.init(named: "message"), for: .normal)
            tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
           return tempBtn
        }()
    lazy var leftBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        tempBtn.setImage(UIImage.init(named: "home"), for: .normal)
        tempBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
       return tempBtn
    }()
}

