//
//  ScholarshipsController.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation

import AWSMobileClient


class ScholarshipsController: UIViewController {
    var pageIndex = 1
    var dataSource : Array<Any>? = Array.init()
    var filter : String? = ""
    let sortArray:[String] = ["Latest","Highest Credit","Most SLP"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.filter = sortArray[0]
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.dropListView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.sortLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(60)
        }
        self.dropListView.snp.makeConstraints { make in
            make.centerY.equalTo(self.sortLabel)
            make.height.equalTo(44)
            make.width.equalTo(SCREEN_WIDTH)
            make.right.equalToSuperview()
        }
        self.addScholarshipBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
       
        UserManager.sharedInstance.updateToken {
            DispatchQueue.main.async { [self] in
                self.collectionView.mj_header?.beginRefreshing()
            }
            self.checkVersion()
            DataManager.sharedInstance.fetchUserDetailinfo { result, reponse in
                
            }
            UserManager.sharedInstance.fetchAndUpdateRole {
                
            }
        }
     
        
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
                                        let url = URL(string: "itms-apps://itunes.apple.com/cn/app/id1598869169?mt=8")
//                                        let url = URL(string: "https://www.pgyer.com/rrZh")
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
    
    func showAddScholarshipVC() {
        DispatchQueue.main.async {
            let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
            let addScholarVC = AddScholarshipController.init(isFromHome: true)
            addScholarVC.addScholarBlock = {
                DispatchQueue.main.async {
                    self.collectionView.mj_header?.beginRefreshing()
                }
            }
            appdelegate.homeVC?.navigationController!.pushViewController(addScholarVC, animated: true)
        }
    }
    
    func changeRoleToManager() {
        DispatchQueue.main.async {
            GFAlert.showAlert(titleStr: "Notice:", msgStr: "Please switch your role to a manager", currentVC: self, cancelStr: "Cancel", cancelHandler: { aletAction in
                
            }, otherBtns: ["YES"]) { idex in
                UserManager.sharedInstance.updateRole(role: "2"){
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CHANGEROLE_NOFI), object: "2")
                }
            }
        }
        
    }
    
    @objc func addScholarshipBtnClick() {
        if UserManager.sharedInstance.isLogin() {
            if UserManager.sharedInstance.currentRole() == 1 {
                self.changeRoleToManager()
            }else if UserManager.sharedInstance.currentRole() == 2{
                self.showAddScholarshipVC()
            }
        }else{
            let loginVC = LoginController.init()
            loginVC.loginSuccessBlock = {()  in
                if UserManager.sharedInstance.currentRole() == 1 {
                    self.changeRoleToManager()
                }else if UserManager.sharedInstance.currentRole() == 2{
                    self.showAddScholarshipVC()
                }
            }
            let navVC = GFNavController.init(rootViewController: loginVC)
            navVC.modalPresentationStyle = .fullScreen
            let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
            appdelegate.homeVC?.navigationController!.present(navVC, animated: true, completion: {
                
            })
        }
    }
    
    lazy var sortLabel:UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "Sort by")
        label.frame = CGRect(x: 20, y: 151.5, width: 49.5, height: 21)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Avenir Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        self.view.addSubview(label)
        return label
    }()
    
    lazy var dropListView:LYDropListView = {
        //传入一个二维数组即可
        let drop = LYDropListView.init(frame: CGRect.init(x: 0, y: kNaviHeight, width: screenWidth, height: 40), tableArr: [sortArray], selectClosure: { [self] (tag, row) in
            self.filter = sortArray[row]
            self.collectionView.mj_header?.beginRefreshing()
        })
        drop.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        let tline = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 0.5))
        tline.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        drop.addSubview(tline)
        let bline = UIView.init(frame: CGRect.init(x: 0, y: 43.5, width: screenWidth, height: 0.5))
        bline.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        drop.addSubview(bline)
        self.view.addSubview(drop)
        return drop
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //水平间隔
        layout.minimumInteritemSpacing = 10
        //垂直行间距
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: (IPhone_SCREEN_WIDTH - 40)/2, height: 200)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(ScholarshipsCell.classForCoder(), forCellWithReuseIdentifier: scholarshipsCelldentifier)
        ourCollectionView.mj_header = MJChiBaoZiHeader.init(refreshingBlock: {
            self.refreshHttpRequest()
        })
       
        ourCollectionView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.loadMoreHttpRequest()
        })
        ourCollectionView.mj_header?.isAutomaticallyChangeAlpha = true
        ourCollectionView.backgroundColor = self.view.backgroundColor
        
        self.view.addSubview(ourCollectionView)
        return ourCollectionView
    }()
    
    lazy var addScholarshipBtn: UIButton = {
        let tempBtn = UIButton.init()
        tempBtn.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.45, alpha: 1)
        tempBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        tempBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        tempBtn.layer.shadowOpacity = 1
        tempBtn.layer.shadowRadius = 5
        tempBtn.layer.cornerRadius = 25
        tempBtn.setImage(UIImage.init(named: "add"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "add"), for: .highlighted)
        tempBtn.addTarget(self, action: #selector(addScholarshipBtnClick), for: .touchUpInside)
        self.view.addSubview(tempBtn)
        return tempBtn
    }()
}

extension  ScholarshipsController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataSource == nil {
            return 0
        }
        return self.dataSource!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scholarshipsCelldentifier, for: indexPath) as! ScholarshipsCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        let scholarshipModel : ScholarshipModel = self.dataSource![indexPath.row] as! ScholarshipModel
        if scholarshipModel.scholarship_id != nil &&  scholarshipModel.axie_brief != nil &&  scholarshipModel.status != nil{
            let scholarshipDetailVC = ScholarshipsDetailController.init(scholarshipId: scholarshipModel.scholarship_id!, axieIds: scholarshipModel.axie_briefArry!, status: scholarshipModel.status!)
            appdelegate.homeVC?.navigationController!.pushViewController(scholarshipDetailVC, animated: true)
        }
    }

    //#MARK: --请求
    func refreshHttpRequest() {
        pageIndex = 1
        self.requestListData()
    }
    
    func loadMoreHttpRequest() {
        self.requestListData()
    }
    
    func requestListData() {
        var desc = ""
        if self.filter == "Latest" {
            desc = "modified_timestamp_desc"
        }else if self.filter == "Highest Credit"{
            desc = "credit_score_desc"
        }else if self.filter == "Most SLP"{
            desc = "estimate_daily_slp_desc"
        }
        
        DataManager.sharedInstance.fetchMarketPlaceScholarShip(filter:desc, pageIndex: pageIndex) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.collectionView.mj_footer?.endRefreshing()
                self.collectionView.mj_header?.endRefreshing()
                if result.success!{
                    let scholarshipListModel : ScholarshipListModel = reponse as! ScholarshipListModel
                    if self.pageIndex == 1{
                        self.dataSource = scholarshipListModel.data
                    }else{
                        if scholarshipListModel.data != nil {
                            self.dataSource?.append(contentsOf: scholarshipListModel.data!)
                        }
            
                    }
                    if scholarshipListModel.next_page! > pageIndex {
                        pageIndex = scholarshipListModel.next_page!
                    }else{
                        self.collectionView.mj_footer?.endRefreshingWithNoMoreData()
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
