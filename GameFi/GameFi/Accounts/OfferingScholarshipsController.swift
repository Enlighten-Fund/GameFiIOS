//
//  AccountScholarshipsController.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation


class OfferingScholarshipsController: UIViewController {
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
        /// 自定义通知
        NotificationCenter.default.addObserver(self, selector: #selector(offerSuccess), name: NSNotification.Name(rawValue: OFFERSUCCESS_NOFI), object: nil)
    }
    
    @objc func offerSuccess()  {
        DispatchQueue.main.async { [self] in
            self.collectionView.mj_header?.beginRefreshing()
        }
    }
    
    @objc func stopOrPayBtnClick(btn:UIButton) {
        if btn.tag - 90000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 90000] as! ScholarshipModel
            if scholarshipModel.status == "ACTIVE" {
                GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you terminate the scholarship before the end date, [your credit score will decrease / you will have to pay an early termination fee of 50 SLP]. Are you sure you want to proceed?", currentVC: self,cancelStr:"Cancel", cancelHandler: { alertAction in
                    
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
                
            } else if scholarshipModel.status == "PENDING_PAYMENT" {
                if scholarshipModel.staking == true{
                    self.mc_loading(text: "Loading")
                    DataManager.sharedInstance.fetchStakingPayScholarship(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                        DispatchQueue.main.async { [self] in
                            self.mc_remove()
                            if result.success!{
                                let dic : Dictionary<String,AnyObject> = reponse as! Dictionary<String,AnyObject>
                                GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                    "Please send \(dic["payment"]!) SLP from[\(String(scholarshipModel.myaccount_ronin_address!))]to ronin:8be5173faa7f456466b74447a74f81361c49d135.There is a little delay. If you have already done this，don't do it again.", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                    
                                }, otherBtns: nil) { index in
                                    
                                }
                            }else{
                                if  result.msg != nil && !result.msg!.isBlank {
                                    self.mc_success(result.msg!)
                                }
                            }
                        }
                    }
                }else{
                    self.mc_loading(text: "Loading")
                    DataManager.sharedInstance.fetchPaymentStatus(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                        DispatchQueue.main.async { [self] in
                            self.mc_remove()
                            if result.success!{
                                let paymentModel : PaymentModel = reponse as! PaymentModel
                                let slp : Int = Int(paymentModel.value!)! - Int(paymentModel.paid_value!)!
                                GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                    "Please send \(slp) SLP from[\(String(scholarshipModel.myaccount_ronin_address!))]to ronin:8be5173faa7f456466b74447a74f81361c49d135.There is a little delay. If you have already done this，don't do it again.", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                    
                                }, otherBtns: nil) { index in
                                    
                                }
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
    
    @objc func stopOrPayBtnClick2(btn:UIButton) {
        if btn.tag - 70000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 70000] as! ScholarshipModel
            if scholarshipModel.status == "ACTIVE" {
                if scholarshipModel.staking == true{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "Your scholarship will be ended immediately.", currentVC: self,cancelStr:"Cancel", cancelHandler: { alertAction in
                        
                    }, otherBtns: ["OK"]) { index in
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.stopStakingScholarship(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
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
                }else{
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
            } else if scholarshipModel.status == "PENDING_PAYMENT" {
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.fetchPaymentStatus(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            let paymentModel : PaymentModel = reponse as! PaymentModel
                            let slp : Int = Int(paymentModel.value!)! - Int(paymentModel.paid_value!)!
                            GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                "Please send \(slp) SLP from[\(String(scholarshipModel.myaccount_ronin_address!))]to ronin:8be5173faa7f456466b74447a74f81361c49d135.There is a little delay. If you have already done this，don't do it again.", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                
                            }, otherBtns: nil) { index in
                                
                            }
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
    
    @objc func renewBtnClick(btn:UIButton) {
        if btn.tag - 80000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 80000] as! ScholarshipModel
            if scholarshipModel.staking == true{
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.fetchStakingPayScholarship(scholarshipid: scholarshipModel.scholarship_id!) { result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            let dic : Dictionary<String,AnyObject> = reponse as! Dictionary<String,AnyObject>
                            GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                "Please send \(dic["payment"]!) SLP from[\(String(scholarshipModel.myaccount_ronin_address!))]to ronin:8be5173faa7f456466b74447a74f81361c49d135.There is a little delay. If you have already done this，don't do it again.", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                
                            }, otherBtns: nil) { index in
                                
                            }
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_success(result.msg!)
                            }
                        }
                    }
                }
            }else{
                if scholarshipModel.is_evergreen != nil{
                    if scholarshipModel.is_evergreen == 0{//scholar manager都未发起renew
                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                            "Your renewal Offer Period will be the same as the previous Offer Period. The Scholar has not requested a Renewal on this Scholarship. You will need to wait for their response after you click on Confirm", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                            DispatchQueue.main.async { [self] in self.mc_loading()}
                            DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: 2){ result, reponse in
                                DispatchQueue.main.async { [self] in
                                    self.mc_remove()
                                    if result.success!{
                                        GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                            "We have notified the Scholar about your Renewal Request. Once they accept, the Offer automatically starts. You can withdraw your Renewal Request anytime before the Scholar responses.", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
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
                                            "Your renewal Offer Period will be the same as the previous Offer Period. The Scholar has requested a Renewal on this Scholarship. This Scholarship will immediately start once you click on Confirm.", currentVC: self,cancelStr:"Confirm", cancelHandler: { alertAction in
                            DispatchQueue.main.async { [self] in self.mc_loading()}
                            DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: 2){ result, reponse in
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
                        DataManager.sharedInstance.updateRenewState(id: Int(scholarshipModel.scholarship_id!)!, is_evergreen: -2){ result, reponse in
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
    
    @objc func editScholarBtnClick(btn:UIButton) {
        if btn.tag - 60000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 60000] as! ScholarshipModel
            let alertController = UIAlertController(title: "Edit scholarship name",
                                        message: "", preferredStyle: .alert)
                    alertController.addTextField {
                        (textField: UITextField!) -> Void in
                        textField.placeholder = "Scholarship name"
                        textField.text = scholarshipModel.scholarship_name
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action in
                        //也可以用下标的形式获取textField let login = alertController.textFields![0]
                        let login = alertController.textFields!.first!
                        if login.text == nil || login.text.isBlank {
                            DispatchQueue.main.async { [self] in
                                GFAlert.showAlert(titleStr: "Notice:", msgStr:
                                                    "Scholarship name should be filled in.", currentVC: self,cancelStr:"OK", cancelHandler: { alertAction in
                                   
                                }, otherBtns: nil) { index in

                                }
                            }
                        }else{
                            if scholarshipModel.staking == true{
                                DispatchQueue.main.async { [self] in self.mc_loading()}
                                DataManager.sharedInstance.editStakingScholarShip(dic: ["id":Int(scholarshipModel.scholarship_id!) as Any,"scholarship_name":login.text!]) { result, reponse in
                                    DispatchQueue.main.async {
                                        self.mc_remove()
                                        if result.success!{
                                            scholarshipModel.scholarship_name = login.text
                                            let indexpath = IndexPath.init(row: btn.tag - 60000, section: 0)
                                            self.collectionView.reloadItems(at: [indexpath])
                                        }else{
                                            if  result.msg != nil && !result.msg!.isBlank {
                                                self.mc_success(result.msg!)
                                            }
                                        }
                                    }
                                }
                            }else{
                                self.mc_loading(text: "Loading")
                                DataManager.sharedInstance.editScholarShip(dic: ["id":Int(scholarshipModel.scholarship_id!) as Any,"scholarship_name":login.text!]) { result, reponse in
                                    DispatchQueue.main.async { [self] in
                                        self.mc_remove()
                                        if result.success!{
                                            scholarshipModel.scholarship_name = login.text
                                            let indexpath = IndexPath.init(row: btn.tag - 60000, section: 0)
                                            self.collectionView.reloadItems(at: [indexpath])
                                        }else{
                                            if  result.msg != nil && !result.msg!.isBlank {
                                                self.mc_success(result.msg!)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    })
                    alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
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
                                 appdelegate.managerAccontVC?.navigationController!.pushViewController(webVC, animated: true)
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
        layout.itemSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 440)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(ManagerScholarshipCell.classForCoder(), forCellWithReuseIdentifier: managerScholarshipCellIdentifier)
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

extension  OfferingScholarshipsController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        let scholarshipModel : ScholarshipModel = self.dataSource![indexPath.row] as! ScholarshipModel
        if scholarshipModel.staking == true {
            return CGSize.init(width: IPhone_SCREEN_WIDTH - 30, height: 400 + 35)
        }
        return CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 440 + 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: managerScholarshipCellIdentifier, for: indexPath) as! ManagerScholarshipCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
        cell.leftBtn.tag = 70000 + indexPath.row
        cell.rightBtn.tag = 80000 + indexPath.row
        cell.btn.tag = 90000 + indexPath.row
        cell.editBtn.tag = 60000 + indexPath.row
        cell.joinDiscordLabel.tag = 50000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(stopOrPayBtnClick), for: .touchUpInside)
        cell.leftBtn.addTarget(self, action: #selector(stopOrPayBtnClick2), for: .touchUpInside)
        cell.rightBtn.addTarget(self, action: #selector(renewBtnClick), for: .touchUpInside)
        cell.editBtn.addTarget(self, action: #selector(editScholarBtnClick), for: .touchUpInside)
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
        DataManager.sharedInstance.fetchManagerOfferingScholarShip(pageIndex: pageIndex) { result, reponse in
                DispatchQueue.main.async { [self] in
                    self.collectionView.mj_footer?.endRefreshing()
                    self.collectionView.mj_header?.endRefreshing()
                    if result.success!{
                        let scholarshipListModel : ScholarshipListModel = reponse as! ScholarshipListModel
                        if self.pageIndex == 1{
                            self.dataSource = scholarshipListModel.data
                            if self.dataSource!.count == 0 {
                                let emptyView = DJEmptyView(tipInfo:"No Data", imageName: "nointernet")
                                emptyView.tipColor = UIColor(red: 0.32, green: 0.35, blue: 0.5, alpha: 1)
                                self.collectionView.dj_showEmptyView(emptyView)
                            }else{
                                self.collectionView.dj_hideEmptyView()
                            }
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
                    }else{
                        if  result.msg != nil && !result.msg!.isBlank {
                            self.mc_success(result.msg!)
                        }
                    }
                    
                }
        }
    }
}
