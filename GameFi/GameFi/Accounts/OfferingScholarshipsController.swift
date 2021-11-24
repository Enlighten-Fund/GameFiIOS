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
    }
    
    @objc func stopOrPayBtnClick(btn:UIButton) {
        if btn.tag - 90000 < self.dataSource!.count {
            let scholarshipModel : ScholarshipModel = self.dataSource![btn.tag - 90000] as! ScholarshipModel
            var status = ""
            if scholarshipModel.status == "ACTIVE" {
                status = "PENDING_PAYMENT"
            } else if scholarshipModel.status == "PENDING_PAYMENT" {
                status = "PENDING_PAYMENT"
            }
            self.mc_loading()
            DataManager.sharedInstance.updateScholarshipStatus(scholarshipid: scholarshipModel.scholarship_id!, status: status) { result, reponse in
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: managerScholarshipCellIdentifier, for: indexPath) as! ManagerScholarshipCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
        cell.btn.tag = 90000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(stopOrPayBtnClick), for: .touchUpInside)
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
