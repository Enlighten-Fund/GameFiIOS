//
//  MarketPlaceController.swift
//  GameFi
//
//  Created by harden on 2021/10/27.
//

import Foundation
import UIKit
import MJRefresh
import SnapKit


class MarketPlaceController: UIViewController {
    override func viewDidLoad() {
        self.tableView?.backgroundColor = .red
        
//        self.tableView?.mj_header = MJRefreshHeader.init(refreshingBlock: {
//            
//        })
//        self.tableView?.mj_header?.beginRefreshing {
//            
//        }
        
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.tableHeaderView = UIView.init(frame: CGRect.zero)
        tempTableView.separatorStyle = .none
        tempTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tempTableView.dataSource = self
        tempTableView.delegate = self
        view.addSubview(tempTableView)
        tempTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        return tempTableView
    }()
}

extension  MarketPlaceController : UITableViewDelegate,UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                }
                // cell? 可选更安全
                cell?.textLabel?.text = "hello \(indexPath.row)"
                return cell!
    }
    
}
