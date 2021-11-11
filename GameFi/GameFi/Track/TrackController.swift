//
//  TrackController.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
import SnapKit
import SCLAlertView
import MJRefresh

class TrackController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tracker"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.addTrackBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.bottom.equalToSuperview().offset(-20 - IPhone_TabbarHeight)
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
    
    @objc func showAddTrack(){
        self.navigationController?.pushViewController(AddTrackController.init(), animated: true)
    }
    
    lazy var tableView: UITableView? = {
        let headerview = TrackHeadView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 335))
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.tableHeaderView = headerview
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(TrackCell.classForCoder(), forCellReuseIdentifier: trackCellIdentifier)
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
    
    lazy var addTrackBtn: UIButton = {
        let tempBtn = UIButton.init()
        tempBtn.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.45, alpha: 1)
        tempBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        tempBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        tempBtn.layer.shadowOpacity = 1
        tempBtn.layer.shadowRadius = 5
        tempBtn.layer.cornerRadius = 25
        tempBtn.setImage(UIImage.init(named: "add"), for: .normal)
        tempBtn.setImage(UIImage.init(named: "add"), for: .highlighted)
        tempBtn.addTarget(self, action: #selector(showAddTrack), for: .touchUpInside)
        self.view.addSubview(tempBtn)
        return tempBtn
    }()
}

extension  TrackController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 2
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 46))
        label.text = "Accounts"
        label.font = UIFont(name: "Avenir Heavy", size: 16)
        label.textColor = .white
        return label
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    let tempCell : TrackCell = tableView.dequeueReusableCell(withIdentifier: trackCellIdentifier, for: indexPath) as! TrackCell
    cell = tempCell
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}

