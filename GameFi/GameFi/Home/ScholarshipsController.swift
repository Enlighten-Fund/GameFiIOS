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
import SCLAlertView

class ScholarshipsController: UIViewController {
    var pageIndex = 1
    var dataSource : Array<Any>? = Array.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.collectionView.mj_header?.beginRefreshing()
    }

    
        lazy var collectionView: UICollectionView = {
                let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
            layout.itemSize = CGSize(width: (IPhone_SCREEN_WIDTH - 30)/2, height: 80)
            // 设置CollectionView
            let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
            ourCollectionView.delegate = self
            ourCollectionView.dataSource = self
            ourCollectionView.backgroundColor = UIColor.white
            ourCollectionView.register(HomeCollectionCell.classForCoder(), forCellWithReuseIdentifier: homeCollectionCellIdentifier)
            ourCollectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                self.refreshHttpRequest()
            })
            ourCollectionView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
                self.loadMoreHttpRequest()
            })
            ourCollectionView.mj_header?.isAutomaticallyChangeAlpha = true
            self.view.addSubview(ourCollectionView)
            return ourCollectionView
        }()
}

extension  ScholarshipsController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCollectionCellIdentifier, for: indexPath) as! HomeCollectionCell
        cell.backgroundColor = .orange
        return cell
    }

//    /**
//     - returns: 返回headview或者footview
//     */
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath)
//        headView.backgroundColor = UIColor.whiteColor()
//
//        return headView
//    }

    // #MARK: --UICollectionViewDelegate的代理方法
    /**
    Description:当点击某个Item之后的回应
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("(\(indexPath.section),\(indexPath.row))")
    }

    //#MARK: --UICollectionViewDelegateFlowLayout的代理方法
    /**
     - returns: header的大小
     */
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: width, height: 17)
//    }
    /**
     Description:可以定制不同的item

     - returns: item的大小
//     */
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        if  indexPath.row % 2 == 1{
//            return CGSize(width: width/2, height: height/3)
//        }
//        else{
//            return CGSize(width: width/2, height: height/2)
//        }
//    }
    func refreshHttpRequest() {
        pageIndex = 1
        self.requestListData()
    }
    
    func loadMoreHttpRequest() {
        self.requestListData()
    }
    
    func requestListData() {
        DataManager.sharedInstance.fetchScholarShip(pageIndex: pageIndex) { result, reponse in
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
                    let error : Error = reponse as! Error
                    SCLAlertView.init().showError("系统提示：", subTitle: "\(error)")
                    
                }
            }
        }
    }
}
