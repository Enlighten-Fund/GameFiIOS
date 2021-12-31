//
//  ScholarRentScholarshipController.swift
//  GameFi
//
//  Created by harden on 2021/11/18.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation


class ScholarRentScholarshipController: UIViewController {
    var pageIndex = 1
    var dataSource : Array<Any>? = Array.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.collectionView.mj_header?.beginRefreshing()
    }
    
    @objc func stopRentBtnClick(btn:UIButton) {
        if btn.tag - 90000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 90000] as! ScholarshipModel
            if scholarshipModel.status == "PENDING_PAYMENT" || scholarshipModel.status == "MANAGER_PAID"{
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.fetchPaymentStatus(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            let paymentModel : PaymentModel = reponse as! PaymentModel
                            GFAlert.showAlert(titleStr: "Notice:", msgStr: "\(Int(paymentModel.scholar_value!)!) SLP will be sent to [\(String(paymentModel.ronin_address!))].Please wait a moment or contact us", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                
                            }, otherBtns: nil) { index in
                                
                            }
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_success(result.msg!)
                            }
                        }
                    }
                }
            }else if scholarshipModel.status == "ACTIVE"{
                GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you terminate the contract, your credit score will drop", currentVC: self,cancelStr:"Cancel", cancelHandler: { alertAction in
                    
                }, otherBtns: ["Stop"]) { index in
                    self.mc_loading(text: "Loading")
                    DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: "PENDING_PAYMENT") { result, reponse in
                        DispatchQueue.main.async { [self] in
                            self.mc_remove()
                            if result.success!{
                                self.collectionView.mj_header?.beginRefreshing()
                            }else{
                                if  result.msg != nil && !result.msg!.isBlank {
                                    self.mc_success(result.msg!)
                                }
                            }
                        }
                    }
                }
            }
           
        }
    }
    
    @objc func stopRentBtnClick2(btn:UIButton) {
        if btn.tag - 70000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 70000] as! ScholarshipModel
            if scholarshipModel.status == "PENDING_PAYMENT" || scholarshipModel.status == "MANAGER_PAID"{
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.fetchPaymentStatus(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            let paymentModel : PaymentModel = reponse as! PaymentModel
                            GFAlert.showAlert(titleStr: "Notice:", msgStr: "\(Int(paymentModel.scholar_value!)!) SLP will be sent to [\(String(paymentModel.ronin_address!))].Please wait a moment or contact us", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                
                            }, otherBtns: nil) { index in
                                
                            }
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_success(result.msg!)
                            }
                        }
                    }
                }
            }else if scholarshipModel.status == "ACTIVE"{
                GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you terminate the contract, your credit score will drop", currentVC: self,cancelStr:"Cancel", cancelHandler: { alertAction in
                    
                }, otherBtns: ["Stop"]) { index in
                    self.mc_loading(text: "Loading")
                    DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: "PENDING_PAYMENT") { result, reponse in
                        DispatchQueue.main.async { [self] in
                            self.mc_remove()
                            if result.success!{
                                self.collectionView.mj_header?.beginRefreshing()
                            }else{
                                if  result.msg != nil && !result.msg!.isBlank {
                                    self.mc_success(result.msg!)
                                }
                            }
                        }
                    }
                }
            }
           
        }
    }
    
    @objc func renewBtnClick(btn:UIButton) {
        if btn.tag - 80000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 80000] as! ScholarshipModel
            if scholarshipModel.status == "ACTIVE" {
                if scholarshipModel.is_evergreen != nil{
                    if scholarshipModel.is_evergreen == 0{//scholar manager都未发起renew
                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                            "Your renewal Offer Period will be the same as the previous Offer Period. The Manager has not requested a Renewal on this Scholarship. You will need to wait for their response after you click on Confirm", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                            DispatchQueue.main.async { [self] in self.mc_loading()}
                            DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: 1){ result, reponse in
                                DispatchQueue.main.async { [self] in
                                    self.mc_remove()
                                    if result.success!{
                                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                            "We have notified the Manager about your Renewal Request. Once they accept, the Offer automatically starts. You can withdraw your Renewal Request anytime before the Scholar responses.", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                                            DispatchQueue.main.async { [self] in
                                                self.collectionView.mj_header?.beginRefreshing()
                                            }
                                        }, otherBtns: ["Cancel"]) { index in
            
                                        }
                                    }else{
                                        if  result.msg != nil && !result.msg!.isBlank {
                                            self.mc_success(result.msg!)
                                        }
                                    }
                                    
                                }
                        }
                        }, otherBtns: ["Cancel"]) { index in
                            
                        }
                    }else if scholarshipModel.is_evergreen == 1{//scholar 发起renew
                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                            "Your renewal Offer Period will be the same as the previous Offer Period. The Manager has requested a Renewal on this Scholarship. This Scholarship will immediately start once you click on Confirm", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                            DispatchQueue.main.async { [self] in self.mc_loading()}
                            DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: -1){ result, reponse in
                                DispatchQueue.main.async { [self] in
                                    self.mc_remove()
                                    if result.success!{
                                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                            "Congratulations! Your Renewed Scholarship starts from now.", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                                            DispatchQueue.main.async { [self] in
                                                self.collectionView.mj_header?.beginRefreshing()
                                            }
                                        }, otherBtns: ["Cancel"]) { index in
            
                                        }
                                    }else{
                                        if  result.msg != nil && !result.msg!.isBlank {
                                            self.mc_success(result.msg!)
                                        }
                                    }
                                    
                                }
                        }
                        }, otherBtns: ["Cancel"]) { index in
                            
                        }

                    }else if scholarshipModel.is_evergreen == 2{//manager 发起renew
                        DispatchQueue.main.async { [self] in self.mc_loading()}
                        DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: 1){ result, reponse in
                            DispatchQueue.main.async { [self] in
                                self.mc_remove()
                                if result.success!{
                                    self.collectionView.mj_header?.beginRefreshing()
                                }else{
                                    if  result.msg != nil && !result.msg!.isBlank {
                                        self.mc_success(result.msg!)
                                    }
                                }
                            }
                    }
                    }else if scholarshipModel.is_evergreen == 3{//manager scholar 都同意renew
                       
                    }
                }
            }
            
        }
    }
    
    func joinDiscordRequest(scholarship_id:Int) {
        DataManager.sharedInstance.joinDiscord(scholarship_id: scholarship_id) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    let dic:[String:Any] = reponse as! [String : Any]
                    let discordlink : String = dic["channel_invite_link"] as! String
                    if !discordlink.isBlank{
                        let url = URL(string: discordlink)
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
                    }
                }else{
                    if  result.msg != nil && !result.msg!.isBlank {
                        self.mc_success(result.msg!)
                    }
                }
            }
        }
    }
    
    @objc func joinDiscordBtnClick(sender: UIGestureRecognizer) {
        let label : UILabel = sender.view! as! UILabel
        if label.tag - 50000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![label.tag - 50000] as! ScholarshipModel
            self.mc_loading(text: "Loading")
            DataManager.sharedInstance.fetchDiscord { result, reponse in
                DispatchQueue.main.async { [self] in
                    if result.success!{
                        let dic:[String:Any] = reponse as! [String : Any]
                        let discordid : String = dic["discord_id"] as! String
                            if !discordid.isBlank{//已经绑定
                                self.joinDiscordRequest(scholarship_id: Int(scholarshipModel.scholarship_id!)!)
                            }
                        }else{
                            self.mc_remove()
                            if result.code == 500{//未绑定
                                let webVC = GFWebController.init()
                                webVC.isFormAccount = true
                                webVC.agreeDiscordBlock = {
                                    self.joinDiscordRequest(scholarship_id: Int(scholarshipModel.scholarship_id!)!)
                                }
                                webVC.webView.load(URLRequest(url: URL.init(string: "https://discord.com/api/oauth2/authorize?client_id=925574421094228058&redirect_uri=https%3A%2F%2F2njrgbv2l6.execute-api.ap-northeast-1.amazonaws.com%2Fprod%2Fdiscord%2Fredirect&response_type=code&scope=identify")!))
                                let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
                                 appdelegate.scholarAccontVC?.navigationController!.pushViewController(webVC, animated: true)
                            }else{
                                if  result.msg != nil && !result.msg!.isBlank {
                                    self.mc_success(result.msg!)
                                }
                            }
                            
                        }
                }
            }
        }
    }

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //水平间隔
        layout.minimumInteritemSpacing = 10
        //垂直行间距
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 370)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(ScholarRentCell.classForCoder(), forCellWithReuseIdentifier: scholarRentCellIdentifier)
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
}

extension  ScholarRentScholarshipController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    // #MARK: --UICollectionViewDataSource的代理方法
    /**
    - 该方法是可选方法，默认为1
    - returns: CollectionView中section的个数
    */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    /**
     - returns: Section中Item的个数
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataSource == nil {
            return 0
        }
        return self.dataSource!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let scholarshipModel : ScholarshipModel = self.dataSource![indexPath.row] as! ScholarshipModel
        return CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 370 + 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scholarRentCellIdentifier, for: indexPath) as! ScholarRentCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
        cell.leftBtn.tag = 70000 + indexPath.row
        cell.rightBtn.tag = 80000 + indexPath.row
        cell.btn.tag = 90000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(stopRentBtnClick), for: .touchUpInside)
        cell.leftBtn.addTarget(self, action: #selector(stopRentBtnClick2), for: .touchUpInside)
        cell.rightBtn.addTarget(self, action: #selector(renewBtnClick), for: .touchUpInside)
        cell.joinDiscordLabel.tag = 50000 + indexPath.row
        cell.joinDiscordLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(joinDiscordBtnClick(sender:)))
        cell.joinDiscordLabel.addGestureRecognizer(tap)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
//        let scholarshipModel : ScholarshipModel = self.dataSource![indexPath.row] as! ScholarshipModel
//        let scholarshipDetailVC = ScholarshipsDetailController.init(scholarshipId: scholarshipModel.scholarship_id!)
//        appdelegate.homeVC?.navigationController!.pushViewController(scholarshipDetailVC, animated: true)
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
        DataManager.sharedInstance.fetchScholarRentScholarShip(pageIndex: pageIndex) { result, reponse in
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
