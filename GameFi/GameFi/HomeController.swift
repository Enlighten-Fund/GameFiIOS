////
////  MarketPlaceController.swift
////  GameFi
////
////  Created by harden on 2021/10/27.
////
//
//import Foundation
//import UIKit
//import MJRefresh
//import SnapKit
//
//
//class MarketPlaceController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.msgBtn!)
//        
//        self.tableView?.backgroundColor = .red
//        
//        self.tableView?.mj_header = MJRefreshHeader.init(refreshingBlock: {
//            self.tableView?.mj_header?.endRefreshing()
//        })
////        self.tableView?.mj_header?.beginRefreshing {
////
////        }
//        
//    }
//    
//    
//    @objc func msgBtnClick() {
//        print("个人消息")
//    }
//    
//    lazy var collectionView: UICollectionView = {
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = UICollectionViewScrollDirection.Vertical  //滚动方向
//            layout.itemSize = CGSizeMake((screenWidth - 30)/2, 80)
//            // 设置CollectionView
//            let ourCollectionView : UICollectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight), collectionViewLayout: layout)
//            ourCollectionView.delegate = self
//            ourCollectionView.dataSource = self
//            ourCollectionView.backgroundColor = UIColor.whiteColor()
//            ourCollectionView .registerClass(MyTestCollectionViewCell.self, forCellWithReuseIdentifier: idenContentString)
//            
//            self.view .addSubview(ourCollectionView)
//    }()
//    
//    lazy var msgBtn : UIButton? = {
//        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
//        tempBtn.setImage(UIImage.init(named: "message"), for: .normal)
//        tempBtn.addTarget(self, action: #selector(msgBtnClick), for: .touchUpInside)
//       return tempBtn
//    }()
//}
//
//extension  HomeController : UICollectionViewDelegate,UITableViewDataSource{
//   
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//                if cell == nil {
//                    cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//                }
//                // cell? 可选更安全
//                cell?.textLabel?.text = "hello \(indexPath.row)"
//                return cell!
//    }
//    
//}
