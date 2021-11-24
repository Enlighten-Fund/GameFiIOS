//
//  LatestScholarshipController.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

import UIKit
import MJRefresh
import SnapKit
import Foundation

class LatestApplyController: UIViewController {
    var pageIndex = 1
    var dataSource : Array<Any>? = Array.init()
//    let sortArray:[String] = ["Latest","Highest credit","Modt everyday","SLP Most Axie","counts"]
//    var filter : String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
//        self.sortLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(12)
//            make.height.equalTo(20)
//            make.left.equalToSuperview().offset(20)
//            make.width.equalTo(60)
//        }
//        self.dropListView.snp.makeConstraints { make in
//            make.centerY.equalTo(self.sortLabel)
//            make.height.equalTo(44)
//            make.width.equalTo(SCREEN_WIDTH)
//            make.right.equalToSuperview()
//        }
        self.collectionView.mj_header?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //水平间隔
        layout.minimumInteritemSpacing = 10
        //垂直行间距
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical  //滚动方向
        layout.itemSize = CGSize(width: IPhone_SCREEN_WIDTH - 30, height: 270)
        // 设置CollectionView
        let ourCollectionView : UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: IPhone_SCREEN_HEIGHT), collectionViewLayout: layout)
        ourCollectionView.delegate = self
        ourCollectionView.dataSource = self
        ourCollectionView.register(LatestScholarshipCell.classForCoder(), forCellWithReuseIdentifier: latestScholarshipCellIdentifier)
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
    
//    lazy var sortLabel:UILabel = {
//        let label = UILabel()
//        let attrString = NSMutableAttributedString(string: "Sort by")
//        label.frame = CGRect(x: 20, y: 151.5, width: 49.5, height: 21)
//        label.numberOfLines = 0
//        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Avenir Medium", size: 15) as Any,.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
//        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
//        label.attributedText = attrString
//        self.view.addSubview(label)
//        return label
//    }()
//
//    lazy var dropListView:LYDropListView = {
//        //传入一个二维数组即可
//        let drop = LYDropListView.init(frame: CGRect.init(x: 0, y: kNaviHeight, width: screenWidth, height: 40), tableArr: [sortArray], selectClosure: { [self] (tag, row) in
//            self.filter = sortArray[row]
//            self.collectionView.mj_header?.beginRefreshing()
//        })
//        drop.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
//        let tline = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 0.5))
//        tline.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
//        drop.addSubview(tline)
//        let bline = UIView.init(frame: CGRect.init(x: 0, y: 43.5, width: screenWidth, height: 0.5))
//        bline.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
//        drop.addSubview(bline)
//        self.view.addSubview(drop)
//        return drop
//    }()
}

extension  LatestApplyController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: latestScholarshipCellIdentifier, for: indexPath) as! LatestScholarshipCell
        cell.makeConstraints()
        let scholarApplyModel = self.dataSource![indexPath.row]
        cell.update(scholarApplyModel: scholarApplyModel as! ScholarApplyModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
        let vc : GFNavController = appdelegate.tabbarVC?.viewControllers![1] as! GFNavController
        let scholarApplyModel : ScholarApplyModel = self.dataSource![indexPath.row] as! ScholarApplyModel
        let scholarDetailVC = ScholarDetailController.init(scholarId: scholarApplyModel.scholar_user_id! )
        vc.pushViewController(scholarDetailVC, animated: true)
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
        DataManager.sharedInstance.fetechScholarApplyListModel(pageIndex: pageIndex) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.collectionView.mj_footer?.endRefreshing()
                self.collectionView.mj_header?.endRefreshing()
                if result.success!{
                    let scholarApplyListModel : ScholarApplyListModel = reponse as! ScholarApplyListModel
                    if self.pageIndex == 1{
                        self.dataSource = scholarApplyListModel.data
                    }else{
                        if scholarApplyListModel.data != nil {
                            self.dataSource?.append(contentsOf: scholarApplyListModel.data!)
                        }

                    }
                    if scholarApplyListModel.next_page! > pageIndex {
                        pageIndex = scholarApplyListModel.next_page!
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

