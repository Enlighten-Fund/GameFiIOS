//
//  ScholarHistoryController.swift
//  GameFi
//
//  Created by harden on 2021/12/17.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation


class ScholarHistoryController: UIViewController {
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
        ourCollectionView.register(ScholarHistoryCell.classForCoder(), forCellWithReuseIdentifier: scholarHistoryCellIdentifier)
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

extension  ScholarHistoryController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
//        if scholarshipModel.status == "END" {
//            return CGSize.init(width: IPhone_SCREEN_WIDTH - 30, height: 270)
//        }
        return CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scholarHistoryCellIdentifier, for: indexPath) as! ScholarHistoryCell
        cell.makeConstraints()
        let scholarshipModel = self.dataSource![indexPath.row]
        cell.update(scholarshipModel: scholarshipModel as! ScholarshipModel)
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
        DataManager.sharedInstance.fetchScholarHistoryScholarShip(pageIndex: pageIndex) { result, reponse in
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
                    }
                    
                }
        }
    }
}

