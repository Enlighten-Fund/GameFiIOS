//
//  ScholarshipsDetailController.swift
//  GameFi
//
//  Created by harden on 2021/11/5.
//

//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit
import SCLAlertView
import MJRefresh

class ScholarshipsDetailController: ViewController {
    var headerview : ScholarshipDetailHeaderView?
    var scholarshipsDetailModel : ScholarshipDetailModel?
    var scholarshipId : String?
    var axieIds : [String]?
    var dataSource : Array<Any>? = Array.init()
    init(scholarshipId : String,axieIds:[String]) {
        super.init(nibName: nil, bundle: nil)
        self.scholarshipId = scholarshipId
        self.axieIds = axieIds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scholarship Detail"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.tableView?.mj_header?.beginRefreshing()
     
    }
    
    func requestData() {
        self.dataSource = Array.init()
        //基本信息 表头
        DataManager.sharedInstance.fetchScholarShipDetail(scholarshipId: self.scholarshipId!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_header?.endRefreshing()
                if result.success!{
                    let tempModel : ScholarshipDetailModel = reponse as! ScholarshipDetailModel
                    self.scholarshipsDetailModel = tempModel
                    self.headerview?.update(scholarshipDetailModel: scholarshipsDetailModel!)
                }
            }
        }
        if self.axieIds != nil && self.axieIds!.count > 0 {
            for axieId in self.axieIds! {
                DataManager.sharedInstance.fetchAxieDetail(axieId: axieId) { result, reponse in
                    let tempModel : AxieinfoModel = reponse as! AxieinfoModel
                    self.dataSource?.append(tempModel)
                    if self.dataSource?.count == self.axieIds?.count {
                        DispatchQueue.main.async { [self] in
                            self.tableView!.mj_header?.endRefreshing()
                            self.tableView?.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        let theaderView = ScholarshipDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 300))
        self.headerview = theaderView
        tempTableView.tableHeaderView = theaderView
//        let footView = LoginFootView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 200))
//        footView.scholarBtn.isSelected = true
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(ScholarshipDetailCell.classForCoder(), forCellReuseIdentifier: scholarshipDetailCellIdentifier)
        
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

extension  ScholarshipsDetailController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.axieIds == nil || self.axieIds!.count == 0 {
            return 0
        }
           return self.axieIds!.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 920.0
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if indexPath.row < self.dataSource!.count {
            cell = tableView.dequeueReusableCell(withIdentifier: scholarshipDetailCellIdentifier, for: indexPath)
            let tempcell :ScholarshipDetailCell  = cell as! ScholarshipDetailCell
            let axieInfoModel = self.dataSource![indexPath.row]
            tempcell.update(axieinfoModel: axieInfoModel as! AxieinfoModel)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    
       cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}

