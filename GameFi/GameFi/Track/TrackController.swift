//
//  TrackController.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import UIKit
import SnapKit

import MJRefresh

class TrackController: ViewController {
    var dataSource : Array<Any>? = Array.init()
    var trackModel : TrackSumModel?
    var trackHeadView : TrackHeadView?
    var pageIndex = 1
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
        self.tableView?.mj_header?.beginRefreshing()
     
    }
    
    //#MARK: --请求
    func refreshHttpRequest() {
        pageIndex = 1
        self.requestData()
    }
    
    func loadMoreHttpRequest() {
        DataManager.sharedInstance.fetchTrackerList(pageIndex: self.pageIndex) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_header?.endRefreshing()
                self.tableView!.mj_footer?.endRefreshing()
                if result.success!{
                    let trackListModel : TrackListModel = reponse as! TrackListModel
                    if self.pageIndex == 1{
                        self.dataSource = trackListModel.data
                    }else{
                        if trackListModel.data != nil {
                            self.dataSource?.append(contentsOf: trackListModel.data!)
                        }
            
                    }
                    if trackListModel.next_page! > pageIndex {
                        pageIndex = trackListModel.next_page!
                    }else{
                        self.tableView!.mj_footer?.endRefreshingWithNoMoreData()
                    }
                    self.tableView!.reloadData()
                }
            }
        }
    }
    
    func requestData() {
        DataManager.sharedInstance.fetchTrackerSummary { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_header?.endRefreshing()
                if result.success!{
                    let tempModel : TrackSumModel = reponse as! TrackSumModel
                    self.trackModel = tempModel
                    self.trackHeadView!.update(trackSumModel: tempModel)
                }
            }
        }
        DataManager.sharedInstance.fetchTrackerList(pageIndex: self.pageIndex) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.tableView!.mj_footer?.endRefreshing()
                self.tableView!.mj_header?.endRefreshing()
                if result.success!{
                    let trackListModel : TrackListModel = reponse as! TrackListModel
                    if self.pageIndex == 1{
                        self.dataSource = trackListModel.data
                    }else{
                        if trackListModel.data != nil {
                            self.dataSource?.append(contentsOf: trackListModel.data!)
                        }
            
                    }
                    if trackListModel.next_page! > pageIndex {
                        pageIndex = trackListModel.next_page!
                    }else{
                        self.tableView!.mj_footer?.endRefreshingWithNoMoreData()
                    }
                    self.tableView!.reloadData()
                }
            }
        }
    }
    
    @objc func showAddTrack(){
        let addTrackerVC = AddTrackController.init()
        addTrackerVC.addTrackBlock = {
            DispatchQueue.main.async { [self] in
                self.tableView?.mj_header?.beginRefreshing()
            }
        }
        self.navigationController?.pushViewController(addTrackerVC, animated: true)
    }
    @objc func showOpertate(btn:UIButton){
        GFAlert.showAlert(titleStr: nil, msgStr: nil, style: .actionSheet, currentVC: self, cancelStr: "Cancel", cancelHandler: { (cancelAction) in
            
        }, otherBtns: ["Edit","Delete"]) { (idx) in
            DispatchQueue.main.async { [self] in
                if idx == 0{
                    let row = btn.tag - 88888
                    let trackModel = dataSource![row]
                    self.navigationController?.pushViewController(EditTrackController.init(trackModel: trackModel as! TrackModel), animated: true)
                }else if idx == 1{
                    GFAlert.showAlert(titleStr: "Notice:", msgStr: "You will lost the tracking of this account", currentVC: self, cancelStr: "Cancel", cancelHandler: { cancelAction in
                        
                    }, otherBtns: ["OK"]) { idx in
                        let row = btn.tag - 88888
                        let trackModel : TrackModel = dataSource![row] as! TrackModel
                        self.mc_loading(text: "Loading")
                        DataManager.sharedInstance.deleteTracker(ronin_address: trackModel.ronin_address!) { result, reponse in
                            self.mc_remove()
                            if result.success!{
                                DispatchQueue.main.async { [self] in
                                    self.mc_text("delete success")
                                    self.tableView?.mj_header?.beginRefreshing {
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    lazy var tableView: UITableView? = {
        let headerview = TrackHeadView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 235))
        self.trackHeadView = headerview
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.tableHeaderView = headerview
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(TrackCell.classForCoder(), forCellReuseIdentifier: trackCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.backgroundColor = self.view.backgroundColor
        tempTableView.mj_header = MJChiBaoZiHeader.init(refreshingBlock: {
            self.requestData()
        })
        tempTableView.mj_header?.isAutomaticallyChangeAlpha = true
        tempTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.loadMoreHttpRequest()
        })
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
        if self.dataSource == nil {
            return 0
        }
        return self.dataSource!.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
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
    let trackModel = self.dataSource![indexPath.row]
    tempCell.update(trackModel: trackModel as! TrackModel)
    tempCell.moreBtn.addTarget(self, action: #selector(showOpertate), for: .touchUpInside)
    tempCell.moreBtn.tag = 88888 + indexPath.row
    cell.contentView.backgroundColor = self.view.backgroundColor
       return cell
   }
}

