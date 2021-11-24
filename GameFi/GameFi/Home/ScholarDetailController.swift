
//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit

import MJRefresh

class ScholarDetailController: ViewController {
    var scholarDetailModel : ScholarDetailModel?
    var headerView : ScholarDetailHeaderView?
    var scholarId : String?
    init(scholarId : String) {
        super.init(nibName: nil, bundle: nil)
        self.scholarId = scholarId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scholar Detail"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.tableView?.mj_header?.beginRefreshing()
     
    }
    
    func requestData() {
        DataManager.sharedInstance.fetchUserDetail(userid:self.scholarId!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_header?.endRefreshing()
                if result.success!{
                    self.scholarDetailModel = (reponse as! ScholarDetailModel)
                    self.headerView?.update(scholarDetailModel: self.scholarDetailModel!)
                    self.tableView!.reloadData()
                }
            }
        }
    }
    
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        let headerView = ScholarDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 330))
        self.headerView = headerView
        tempTableView.tableHeaderView = headerView
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(ScholarDetailCell.classForCoder(), forCellReuseIdentifier: scholarDetailCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.mj_header = MJChiBaoZiHeader.init(refreshingBlock: {
            self.requestData()
        })
        tempTableView.mj_header?.isAutomaticallyChangeAlpha = true
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
}

extension  ScholarDetailController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.scholarDetailModel == nil {
            return 0
        }
           return 2
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let font:UIFont! = UIFont(name: "Avenir Next Regular", size: 15)
            let attributes = [NSAttributedString.Key.font:font]
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let size = (self.scholarDetailModel?.game_history!.boundingRect(with: CGSize.init(width: IPhone_SCREEN_WIDTH - 30, height: 10000),options: option,attributes: attributes as [NSAttributedString.Key : Any],context: nil))!
            return size.height + 50 + 10
        }else if indexPath.row == 1{
            let font:UIFont! = UIFont(name: "Avenir Next Regular", size: 15)
            let attributes = [NSAttributedString.Key.font:font]
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let size = (self.scholarDetailModel?.self_intro!.boundingRect(with: CGSize.init(width: IPhone_SCREEN_WIDTH - 30, height: 10000),options: option,attributes: attributes as [NSAttributedString.Key : Any],context: nil))!
            return size.height + 50 + 10
        }
        return 0.01
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    switch indexPath.row {
    case 0:
        cell = tableView.dequeueReusableCell(withIdentifier: scholarDetailCellIdentifier, for: indexPath)
        let tempcell :ScholarDetailCell  = cell as! ScholarDetailCell
        tempcell.update(title: "Games played before", content: (self.scholarDetailModel?.game_history)!)
    case 1:
        cell = tableView.dequeueReusableCell(withIdentifier: scholarDetailCellIdentifier, for: indexPath) as! ScholarDetailCell
        let tempcell :ScholarDetailCell  = cell as! ScholarDetailCell
        tempcell.update(title: "Self introduction", content: (self.scholarDetailModel?.self_intro)!)
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = self.view.backgroundColor
    return cell
   }
}

