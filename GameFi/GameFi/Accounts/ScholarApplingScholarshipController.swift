//
//  ScholarApplingScholarshipController.swift
//  GameFi
//
//  Created by harden on 2021/11/18.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation
import EmptyKit

class ScholarApplingScholarshipController: UIViewController,EmptyDataSource,EmptyDelegate{
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
    
    
    @objc func deleteBtnClick(btn:UIButton) {
        if btn.tag - 50000 < self.dataSource!.count {
            let applicationModel : ApplicationModel = self.dataSource![btn.tag - 50000] as! ApplicationModel
            GFAlert.showAlert(titleStr: "Notice:", msgStr: "Do you want to give up this application？", currentVC: self,cancelBtn:"NO", cancelHandler: { action in
                
            }, otherBtns: ["YES"]) { index in
                self.mc_loading()
                DataManager.sharedInstance.updateApplicationStatus(applicationId: applicationModel.application_id!, status: "SCHOLAR_REJ") { result, reponse in
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

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //水平间隔
        layout.minimumInteritemSpacing = 10
        //垂直行间距
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 295)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(ScholarApplyCell.classForCoder(), forCellWithReuseIdentifier: scholarApplyCellIdentifier)
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

extension  ScholarApplingScholarshipController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scholarApplyCellIdentifier, for: indexPath) as! ScholarApplyCell
        cell.makeConstraints()
        let applicationModel = self.dataSource![indexPath.row]
        cell.update(applicationModel: applicationModel as! ApplicationModel)
        cell.btn.tag = 50000 + indexPath.row
        cell.btn.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
//        let scholarshipModel : ScholarshipModel = self.dataSource![indexPath.row] as! ScholarshipModel
//        let scholarshipDetailVC = ScholarshipsDetailController.init(scholarshipId: scholarshipModel.scholarship_id!)
//        appdelegate.homeVC?.navigationController!.pushViewController(scholarshipDetailVC, animated: true)
    }
    
    
    func imageForEmpty(in view: UIView) -> UIImage? {
            return UIImage(named: "nointernet")
        }

        func titleForEmpty(in view: UIView) -> NSAttributedString? {
            let title = "no data"
            let font = UIFont.systemFont(ofSize: 14)
            let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.black, .font: font]
            return NSAttributedString(string: title, attributes: attributes)
        }

    func buttonTitleForEmpty(forState state: UIControl.State, in view: UIView) -> NSAttributedString? {
            let title = "click me"
            let font = UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white, .font: font]
            return NSAttributedString(string: title, attributes: attributes)
        }

        func buttonBackgroundColorForEmpty(in view: UIView) -> UIColor {
            return UIColor.blue
        }
    
    func emptyButton(_ button: UIButton, didTappedIn view: UIView) {
            print( #function, #line, type(of: self))
        }

        func emptyView(_ emptyView: UIView, didTapppedIn view: UIView) {
            print( #function, #line, type(of: self))
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
        DataManager.sharedInstance.fetchScholarApplyingScholarShip(pageIndex: pageIndex) { result, reponse in
                DispatchQueue.main.async { [self] in
                    self.collectionView.mj_footer?.endRefreshing()
                    self.collectionView.mj_header?.endRefreshing()
                    if result.success!{
                        let applicationListModel : ApplicationListModel = reponse as! ApplicationListModel
                        if self.pageIndex == 1{
                            self.dataSource = applicationListModel.data
                            if self.dataSource!.count == 0 {
//                                self.collectionView.ept.reloadData()
//                                collectionView.ept.dataSource = self
//                                collectionView.ept.delegate = self
                            }
                        }else{
                            if applicationListModel.data != nil {
                                self.dataSource?.append(contentsOf: applicationListModel.data!)
                            }

                        }
                        if applicationListModel.next_page! > pageIndex {
                            pageIndex = applicationListModel.next_page!
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

