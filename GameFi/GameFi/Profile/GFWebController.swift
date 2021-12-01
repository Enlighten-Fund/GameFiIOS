//
//  GFWebController.swift
//  GameFi
//
//  Created by harden on 2021/12/1.
//

import Foundation
import UIKit
import SnapKit
import JXWebViewController

class GFWebController: JXWebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftBtn!)
        self.leftBtn?.isHidden = false
    }

    
    @objc func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var leftBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        tempBtn.setImage(UIImage.init(named: "arrow_left"), for: .normal)
        tempBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
       return tempBtn
    }()
}
