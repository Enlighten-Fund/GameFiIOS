//
//  NoOfferScholarshipController.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation

class NoOfferScholarshipController: UIViewController {
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.mj_header?.beginRefreshing()
    }
    
    @objc func showAddScholarshipVC() {
        let addScholarshipVC = AddScholarshipController.init(isFromHome: false)
        addScholarshipVC.addScholarBlock = {
            DispatchQueue.main.async { [self] in
                self.collectionView.mj_header?.beginRefreshing()
            }
           
        }
        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        let vc : GFNavController = appdelegate.tabbarVC?.viewControllers![1] as! GFNavController
        vc.pushViewController(addScholarshipVC, animated: true)
    }
    
    @objc func showEditScholarshipVC(btn:UIButton) {
        if btn.tag - 10000 < self.dataSource!.count {
            let scholarshipModel = self.dataSource![btn.tag - 10000]
            let editScholarshipVC = EditScholarshipController.init(scholarshipModel: scholarshipModel as! ScholarshipModel)
            editScholarshipVC.editScholarBlock = {
                DispatchQueue.main.async { [self] in
                    self.collectionView.mj_header?.beginRefreshing()
                }
            }
            let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
            let vc : GFNavController = appdelegate.tabbarVC?.viewControllers![1] as! GFNavController
            vc.pushViewController(editScholarshipVC, animated: true)
        }
        
    }
    
    @objc func postScholarship(btn:UIButton) {
        if btn.tag - 20000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 20000] as! ScholarshipModel
            if scholarshipModel.staking == true{
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.editStakingScholarShip(dic: ["id":Int(scholarshipModel.scholarship_id!) as Any,"status":"LISTING"]){ result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            GFAlert.showAlert(titleStr: "Notice:", msgStr: "We will verify your account and notify you with the minimum SLP return by email within 24 hours. ", currentVC: self,  cancelStr: "OK", cancelHandler: { action in
                                DispatchQueue.main.async { [self] in
                                    self.collectionView.mj_header?.beginRefreshing()
                                }
                            }, otherBtns: nil) { index in
                               
                            }
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_text(result.msg!)
                            }
                        }
                    }
                }
            }else{
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: "LISTING") { result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            self.mc_success("Finished! Under review.")
                            self.collectionView.mj_header?.beginRefreshing()
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_text(result.msg!)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    @objc func recallScholarship(btn:UIButton) {
        if btn.tag - 30000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 30000] as! ScholarshipModel
            if scholarshipModel.staking == true{
                if scholarshipModel.status == "AUDIT"{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "The applications you received for this scholarship will no longer be available.", currentVC: self, cancelStr: "Cancel", cancelHandler: { alertAction in
                        
                    }, otherBtns: ["OK"]) { index in
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.editStakingScholarShip(dic: ["id":Int(scholarshipModel.scholarship_id!) as Any,"status":"DRAFT"]) { result, reponse in
                            DispatchQueue.main.async { [self] in
                                self.mc_remove()
                                if result.success!{
                                    self.mc_text("Scholarship recalled successfully!")
                                    self.collectionView.mj_header?.beginRefreshing()
                                }else{
                                    if  result.msg != nil && !result.msg!.isBlank {
                                        self.mc_text(result.msg!)
                                    }
                                }
                            }
                        }
                    }
                }else if scholarshipModel.status == "LISTING"{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "The applications you received for this scholarship will no longer be available.", currentVC: self, cancelStr: "Cancel", cancelHandler: { alertAction in
                        
                    }, otherBtns: ["OK"]) { index in
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.editStakingScholarShip(dic: ["id":Int(scholarshipModel.scholarship_id!) as Any,"status":"DRAFT"]) { result, reponse in
                            DispatchQueue.main.async { [self] in
                                self.mc_remove()
                                if result.success!{
                                    self.mc_text("Scholarship recalled successfully!")
                                    self.collectionView.mj_header?.beginRefreshing()
                                }else{
                                    if  result.msg != nil && !result.msg!.isBlank {
                                        self.mc_text(result.msg!)
                                    }
                                }
                            }
                        }
                    }
                }
            }else{
                if scholarshipModel.status == "AUDIT"{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you recall the scholarship, the verification process will be terminated.", currentVC: self, cancelStr: "Cancel", cancelHandler: { alertAction in
                        
                    }, otherBtns: ["OK"]) { index in
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: "DRAFT") { result, reponse in
                            DispatchQueue.main.async { [self] in
                                self.mc_remove()
                                if result.success!{
                                    self.collectionView.mj_header?.beginRefreshing()
                                }else{
                                    if  result.msg != nil && !result.msg!.isBlank {
                                        self.mc_text(result.msg!)
                                    }
                                }
                            }
                        }
                    }
                }else if scholarshipModel.status == "LISTING"{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "If you recall the scholarship, the application you received will expire.", currentVC: self, cancelStr: "Cancel", cancelHandler: { alertAction in
                        
                    }, otherBtns: ["OK"]) { index in
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: "DRAFT") { result, reponse in
                            DispatchQueue.main.async { [self] in
                                self.mc_remove()
                                if result.success!{
                                    self.collectionView.mj_header?.beginRefreshing()
                                }else{
                                    if  result.msg != nil && !result.msg!.isBlank {
                                        self.mc_text(result.msg!)
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
        
    }
    
    @objc func editScholarBtnClick(btn:UIButton) {
        if btn.tag - 40000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 40000] as! ScholarshipModel
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
                                            let indexpath = IndexPath.init(row: btn.tag - 40000, section: 0)
                                            self.collectionView.reloadItems(at: [indexpath])
                                        }else{
                                            if  result.msg != nil && !result.msg!.isBlank {
                                                self.mc_text(result.msg!)
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
                                            let indexpath = IndexPath.init(row: btn.tag - 40000, section: 0)
                                            self.collectionView.reloadItems(at: [indexpath])
                                        }else{
                                            if  result.msg != nil && !result.msg!.isBlank {
                                                self.mc_text(result.msg!)
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
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //水平间隔
        layout.minimumInteritemSpacing = 10
        //垂直行间距
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 400)
        layout.headerReferenceSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 175)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(NoOfferHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: noOfferHeaderViewheaderIdentifier)
        ourCollectionView.register(NoOfferScholarshipCell.classForCoder(), forCellWithReuseIdentifier: noOfferScholarshipCellIdentifier)
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

extension  NoOfferScholarshipController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!
        if kind ==  UICollectionView.elementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: noOfferHeaderViewheaderIdentifier, for: indexPath) as! NoOfferHeaderView
            let temp : NoOfferHeaderView = reusableview as! NoOfferHeaderView
            temp.btn.addTarget(self, action: #selector(showAddScholarshipVC), for: .touchUpInside)
            temp.makeConstraints()
        }
        return reusableview
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: noOfferScholarshipCellIdentifier, for: indexPath) as! NoOfferScholarshipCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
        cell.leftBtn.addTarget(self, action: #selector(showEditScholarshipVC), for: .touchUpInside)
        cell.leftBtn.tag = 10000 + indexPath.row
        cell.rightBtn.addTarget(self, action: #selector(postScholarship), for: .touchUpInside)
        cell.rightBtn.tag = 20000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(recallScholarship), for: .touchUpInside)
        cell.btn.tag = 30000 + indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editScholarBtnClick), for: .touchUpInside)
        cell.editBtn.tag = 40000 + indexPath.row
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
        DataManager.sharedInstance.fetchManagerNoOfferScholarShip(pageIndex: pageIndex) { result, reponse in
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
                        self.mc_text(result.msg!)
                    }
                }
                
            }
        }
    }
}
