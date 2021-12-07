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
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
        self.pageView?.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.right.equalToSuperview()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.checkVersion()
    }
    
    func checkVersion() {
        DataManager.sharedInstance.fetchAppVersion { result, reponse in
            if result.success!{
                let localV : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                let dic : [String:AnyObject] = reponse as! [String : AnyObject]
                let str : String = dic["data"] as! String
                let data = Data(str.utf8)
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let dic2 = json as? [String : String] {
                            let lastV : String = dic2["version"]!
                            if localV != lastV {
                                DispatchQueue.main.async { [self] in
                                    GFAlert.showAlert(titleStr: "App notice：", msgStr: "We have a new version", currentVC: self, cancelStr: "OK", cancelHandler: { alert in
//                                        let url = URL(string: "itms-apps://itunes.apple.com/cn/app/id1598869169?mt=8")
                                        let url = URL(string: "https://www.pgyer.com/rrZh")
                                        // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
                                        if !UIApplication.shared.canOpenURL(url!) {
                                             // 不能跳转就不要往下执行了
                                             return
                                        }
                                        UIApplication.shared.open(url!, options: [:]) { (success) in
                                             if (success) {
                                                  print("10以后可以跳转url")
                                             }else{
                                                  print("10以后不能完成跳转")
                                             }
                                         }
                                    }, otherBtns: nil) { index in

                                    }
                                }

                            }
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }

            }
        }
        
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
                                titles: ["Scholarship","Scholar"],
                                childControllers: [ScholarshipsController(),ScholarsController()],
                                parentController: self)
        view.addSubview(pageView)
        return pageView
    }()
}


