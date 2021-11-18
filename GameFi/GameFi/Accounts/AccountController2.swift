//
//  AccountController2.swift
//  GameFi
//
//  Created by harden on 2021/11/18.
//

import Foundation
import UIKit
import MJRefresh
import SnapKit

class AccountsController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 自定义通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeRole), name: NSNotification.Name(rawValue: CHANGEROLE_NOFI), object: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
        self.pageView?.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.right.equalToSuperview()
        })
    }
    
    /// 析构函数.类似于OC的 dealloc
    deinit {
     /// 移除通知
     NotificationCenter.default.removeObserver(self)
    }
    
    /// 接受到通知后的方法回调
    @objc private func changeRole(noti: Notification) {
        let currentRole = UserManager.sharedInstance.currentRole()
        if currentRole == 1 {
            self.pageView!.removeFromSuperview()
            let tpageView = TYPageView(frame: view.bounds,
                                    titles: ["Renting","Applying"],
                                    childControllers: [ScholarRentScholarshipController(),ScholarApplingScholarshipController()],
                                    parentController: self)
            
            view.addSubview(tpageView)
            tpageView.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(0)
                make.left.equalToSuperview()
                make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
                make.right.equalToSuperview()
            })
            self.pageView = tpageView
            
        }else if currentRole == 2{
            self.pageView?.removeFromSuperview()
            let tpageView = TYPageView(frame: view.bounds,
                                    titles: ["Application","Offering","Not offerd"],
                                    childControllers: [LatestScholarshipController(),OfferingScholarshipsController(),NoOfferScholarshipController()],
                                    parentController: self)
            
            view.addSubview(tpageView)
            tpageView.snp.makeConstraints({ make in
                make.top.equalToSuperview().offset(0)
                make.left.equalToSuperview()
                make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
                make.right.equalToSuperview()
            })
            self.pageView = pageView
        }
        self.pageView?.updateConstraintsIfNeeded()
    }
    
    @objc func msgBtnClick() {
        self.navigationController?.pushViewController(NotificationController.init(), animated: true)
    }
    
    lazy var msgBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        tempBtn.setImage(UIImage.init(named: "msg"), for: .normal)
        tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
       return tempBtn
    }()
    
    lazy var pageView : TYPageView? = {
        let pageView = TYPageView(frame: view.bounds,
                                titles: ["Renting","Applying"],
                                childControllers: [ScholarRentScholarshipController(),ScholarApplingScholarshipController()],
                                parentController: self)
        view.addSubview(pageView)
        self.pageView = pageView
        return pageView
    }()
}
