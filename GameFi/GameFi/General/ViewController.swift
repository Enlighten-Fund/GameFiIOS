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
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftBtn!)
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.leftBtn?.isHidden = false
        }else{
            self.leftBtn?.isHidden = true
        }
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
        tempBtn.setImage(UIImage.init(named: "msg"), for: .normal)
        tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
       return tempBtn
    }()
    lazy var leftBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        tempBtn.setImage(UIImage.init(named: "arrow_left"), for: .normal)
        tempBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
       return tempBtn
    }()
}

