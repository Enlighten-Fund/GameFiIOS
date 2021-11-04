////
////  MarketPlaceController.swift
////  GameFi
////
////  Created by harden on 2021/10/27.
////
//
import Foundation
import UIKit
import MJRefresh
import SnapKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            DataManager.sharedInstance.fetchScholarShip(pageIndex: 1) { result, reponse in
                
            }
        })
        self.collectionView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            
        })
        
        self.collectionView.mj_header?.isAutomaticallyChangeAlpha = true
    }
    
    
    @objc func msgBtnClick() {
        print("个人消息")
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
        self.view.addSubview(ourCollectionView)
        return ourCollectionView
    }()
    
    lazy var msgBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        tempBtn.setImage(UIImage.init(named: "message"), for: .normal)
        tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
       return tempBtn
    }()
}

extension  HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
        return 80
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
    
}
