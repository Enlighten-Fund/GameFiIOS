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
import SCLAlertView

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
        
        self.collectionView.mj_header?.beginRefreshing()
    }
    
    @objc func showAddScholarshipVC() {
        let addScholarshipVC = AddScholarshipController.init(status: "DRAFT")
        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        let vc : GFNavController = appdelegate.tabbarVC?.viewControllers![1] as! GFNavController
        vc.pushViewController(addScholarshipVC, animated: true)
    }
    
    @objc func showEditScholarshipVC(btn:UIButton) {
        if btn.tag - 10000 < self.dataSource!.count {
            let managerScholarshipModel = self.dataSource![btn.tag - 10000]
            let editScholarshipVC = EditScholarshipController.init(managerScholarshipModel: managerScholarshipModel as! ManagerScholarshipModel)
            let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
            let vc : GFNavController = appdelegate.tabbarVC?.viewControllers![1] as! GFNavController
            vc.pushViewController(editScholarshipVC, animated: true)
        }
        
    }
    
    @objc func postScholarship(btn:UIButton) {
        if btn.tag - 20000 < self.dataSource!.count {
            let managerScholarshipModel : ManagerScholarshipModel = self.dataSource![btn.tag - 20000] as! ManagerScholarshipModel
            self.mc_loading()
            DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: managerScholarshipModel.scholarship_id!, status: "LISTING") { result, reponse in
                DispatchQueue.main.async { [self] in
                    self.mc_remove()
                    if result.success!{
                        self.mc_success("Finished！Waiting the review")
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
    
    @objc func recallScholarship(btn:UIButton) {
        if btn.tag - 30000 < self.dataSource!.count {
            let managerScholarshipModel : ManagerScholarshipModel = self.dataSource![btn.tag - 30000] as! ManagerScholarshipModel
            self.mc_loading()
            DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: managerScholarshipModel.scholarship_id!, status: "DRAFT") { result, reponse in
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
        ourCollectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
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
        let managerScholarshipModel = self.dataSource![indexPath.row]
        cell.update(managerScholarshipModel: managerScholarshipModel as! ManagerScholarshipModel)
        cell.leftBtn.addTarget(self, action: #selector(showEditScholarshipVC), for: .touchUpInside)
        cell.leftBtn.tag = 10000 + indexPath.row
        cell.rightBtn.addTarget(self, action: #selector(postScholarship), for: .touchUpInside)
        cell.rightBtn.tag = 20000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(recallScholarship), for: .touchUpInside)
        cell.btn.tag = 30000 + indexPath.row
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
                    let managerScholarshipListModel : ManagerScholarshipListModel = reponse as! ManagerScholarshipListModel
                    if self.pageIndex == 1{
                        self.dataSource = managerScholarshipListModel.data
                    }else{
                        if managerScholarshipListModel.data != nil {
                            self.dataSource?.append(contentsOf: managerScholarshipListModel.data!)
                        }

                    }
                    if managerScholarshipListModel.next_page! > pageIndex {
                        pageIndex = managerScholarshipListModel.next_page!
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
