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
    init(scholarshipId : String) {
        super.init(nibName: nil, bundle: nil)
        self.scholarshipId = scholarshipId
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
        DataManager.sharedInstance.fetchScholarShipDetail(scholarshipId: self.scholarshipId!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_header?.endRefreshing()
                if result.success!{
                    let tempModel : ScholarshipDetailModel = reponse as! ScholarshipDetailModel
                    self.scholarshipsDetailModel = tempModel
                    self.headerview?.update(scholarshipDetailModel: scholarshipsDetailModel!)
                    self.tableView!.reloadData()
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
            
           return 10
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.01
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    switch indexPath.row {
//    case 0:
//        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "0", for: indexPath) as! LabelTextFildCell
//        tempCell.textFild?.delegate = self
//        tempCell.textFild?.tag = 10001
//        self.usernameTextField = tempCell.textFild
//        tempCell.textFild?.placeholder = "Please enter 5 to 16 alphanumeric characters or underscores"
//        tempCell.update(model: self.usernameModel)
//        cell = tempCell
//    case 1:
//        let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier + "1", for: indexPath) as! LabelTextFildCell
//        tempCell.textFild?.setupShowPasswordButton()
//        tempCell.textFild?.delegate = self
//        tempCell.textFild?.tag = 10002
//        tempCell.textFild?.placeholder = "Please enter a 6-20 digit password with at least two of letters, numbers and symbols"
//        self.passwordTextField = tempCell.textFild
//        tempCell.update(model: self.passwordModel)
//        cell = tempCell
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}

