//
//  NotificationController.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh

class NotificationController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
//        self.tableView?.mj_header?.beginRefreshing()
     
    }
    
    func requestData() {
//        DataManager.sharedInstance.fetchScholarShipDetail(scholarshipId: self.scholarshipId!) { result, reponse in
//            DispatchQueue.main.async { [self] in
//                self.tableView!.mj_header?.endRefreshing()
//                if result.success!{
//                    let tempModel : ScholarshipDetailModel = reponse as! ScholarshipDetailModel
//                    self.scholarshipsDetailModel = tempModel
//                    self.headerview?.update(scholarshipDetailModel: scholarshipsDetailModel!)
//                    self.tableView!.reloadData()
//                }
//            }
//        }
    }
    
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(NotificationCell.classForCoder(), forCellReuseIdentifier: notificationCelllIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.requestData()
        })
        tempTableView.mj_header?.isAutomaticallyChangeAlpha = true
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
}

extension  NotificationController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 2
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let font:UIFont! = UIFont(name: "Avenir Next Regular", size: 15)
        let attributes = [NSAttributedString.Key.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = ("A scholarship has been terminated, the ronin address is ronin: 384819991203902asdjaldjk129100192. The account is back to marketplace".boundingRect(with: CGSize.init(width: IPhone_SCREEN_WIDTH - 60, height: 10000),options: option,attributes: attributes as [NSAttributedString.Key : Any],context: nil))
        return size.height + 85 + 2 + 10
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    let tempCell : NotificationCell = tableView.dequeueReusableCell(withIdentifier: notificationCelllIdentifier, for: indexPath) as! NotificationCell
    tempCell.update(title: "A scholarship has been terminated, the ronin address is ronin: 384819991203902asdjaldjk129100192. The account is back to marketplace")
    cell = tempCell
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}


