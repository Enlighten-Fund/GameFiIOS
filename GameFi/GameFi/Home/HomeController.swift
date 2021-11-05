////
////  MarketPlaceController.swift
////  GameFi
////
////  Created by harden on 2021/10/27.
////
//
import Foundation
import UIKit
import MJRefresh
import SnapKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
        self.pageView?.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.right.equalToSuperview()
        })
    }
    
    
    @objc func msgBtnClick() {
        print("个人消息")
    }
    
    lazy var msgBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        tempBtn.setImage(UIImage.init(named: "message"), for: .normal)
        tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
       return tempBtn
    }()
    
    lazy var pageView : TYPageView? = {
        let pageView = TYPageView(frame: view.bounds,
                                titles: ["Scholarships","Scholars"],
                                childControllers: [ScholarshipsController(),ScholarsController()],
                                parentController: self)
        view.addSubview(pageView)
        return pageView
    }()
}


