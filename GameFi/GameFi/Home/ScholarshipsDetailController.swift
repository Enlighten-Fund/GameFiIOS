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
import MJRefresh

class ScholarshipsDetailController: ViewController {
    var headerview : ScholarshipDetailHeaderView?
    var scholarshipsDetailModel : ScholarshipModel?
    var scholarshipId : String?
    var axieIds : [String]?
    var newAxieIds : [String]?
    var dataSource : Array<Any>? = Array.init()
    var status : String?
    
    init(scholarshipId : String,axieIds:[String],status:String) {
        super.init(nibName: nil, bundle: nil)
        self.scholarshipId = scholarshipId
        self.axieIds = axieIds
        self.newAxieIds = []
        if self.axieIds!.count > 20 {
            for i in 0..<20 {
                self.newAxieIds?.append(axieIds[i])
            }
        }else{
            for axieId in self.axieIds! {
                self.newAxieIds?.append(axieId)
            }
        }
        self.status = status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scholarship Detail"
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalTo(self.applyView!.snp.top)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.applyView!.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarSafeBottomMargin)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        if status == "ACTIVE" || status == "PENDING_PAYMENT"{
            self.applyView?.submitBtn.backgroundColor = .gray
            self.applyView?.submitBtn.isEnabled = false
            self.applyView?.submitBtn.setTitle("Offered", for: .normal)
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
                    let tempModel : ScholarshipModel = reponse as! ScholarshipModel
                    self.scholarshipsDetailModel = tempModel
                    self.headerview?.update(scholarshipDetailModel: scholarshipsDetailModel!)
                }
            }
        }
        if self.newAxieIds != nil && self.newAxieIds!.count > 0 {
            for axieId in self.newAxieIds! {
                DataManager.sharedInstance.fetchAxieDetail(axieId: axieId) { result, reponse in
                    if result.success!{
                        let tempModel : AxieinfoModel = reponse as! AxieinfoModel
                        self.dataSource?.append(tempModel)
//                        if self.dataSource?.count == self.newAxieIds?.count {
//                            DispatchQueue.main.async { [self] in
//                                self.tableView!.mj_header?.endRefreshing()
//                                self.tableView?.reloadData()
//                            }
//                        }
                        DispatchQueue.main.async { [self] in
                            self.tableView!.mj_header?.endRefreshing()
                            self.tableView?.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
    
    func changeRoleToScholar() {
        DispatchQueue.main.async {
            GFAlert.showAlert(titleStr: "Notice:", msgStr: "Please switch your role to a scholar", currentVC: self, cancelStr: "Cancel", cancelHandler: { aletAction in
                
            }, otherBtns: ["YES"]) { idex in
                UserManager.sharedInstance.updateRole(role: "1"){
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CHANGEROLE_NOFI), object: "1")
                }
            }
        }
        
    }
    
    func valifiyUserProfileStatus() {
        if UserManager.sharedInstance.userinfoModel!.scholar_status == nil
            || UserManager.sharedInstance.userinfoModel!.scholar_status! == "NO" {
            GFAlert.showAlert(titleStr: "Notice:", msgStr: "Please complete and submit your profile", currentVC: self, cancelStr: "Cancel", cancelHandler: { action in
                
            }, otherBtns: ["Go now"]) { index in
                DispatchQueue.main.async { [self] in
                    let editProfileVC = EditProfileController.init()
                    self.navigationController?.pushViewController(editProfileVC, animated: true)
                }
            }
        }else if UserManager.sharedInstance.userinfoModel!.scholar_status! == "AUDIT" {
            GFAlert.showAlert(titleStr: "Notice:", msgStr: "Your information is auditing, please try again in a few minutes", currentVC: self, cancelStr: "Cancel", cancelHandler: { action in
                
            }, otherBtns: ["Get help"]) { index in
                DispatchQueue.main.async { [self] in
                    //show Join our discord link
                }
            }
        }else if UserManager.sharedInstance.userinfoModel!.scholar_status! == "YES" {
            self.requestApplay()
        }
    }
    
    func requestApplay() {
        self.mc_loading(text: "Loading")
        DataManager.sharedInstance.applyScholarShipDetail(scholarshipId: self.scholarshipId!) { result, reponse in
            DispatchQueue.main.async { [self] in
                self.mc_remove()
                if result.success!{
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: APPLYSUCCESS_NOFI), object: nil)
                    DispatchQueue.main.async { [self] in
                        GFAlert.showAlert(titleStr: "Notice:", msgStr: "Apply success,please wait for the manager's consent", currentVC: self,cancelStr:"OK", cancelHandler: { action in
                            DispatchQueue.main.async { [self] in
                                self.navigationController?.popViewController(animated: true)
                            }
                        }, otherBtns: nil) { index in
                            
                        }
                    }
                }else{
                    if !result.msg!.isBlank {
                        DispatchQueue.main.async { [self] in
                            GFAlert.showAlert(titleStr: "Notice:", msgStr: result.msg!, currentVC: self, cancelStr: "Cancel", cancelHandler: { action in
                                
                            }, otherBtns: nil) { index in
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func submitBtnClick() {
        if UserManager.sharedInstance.isLogin() {
            if UserManager.sharedInstance.currentRole() == 1 {
                self.valifiyUserProfileStatus()
            }else if UserManager.sharedInstance.currentRole() == 2{
                self.changeRoleToScholar()
                
            }
        }else{
            let loginVC = LoginController.init()
            loginVC.loginSuccessBlock = {()  in
                if UserManager.sharedInstance.currentRole() == 1 {
                    self.valifiyUserProfileStatus()
                }else if UserManager.sharedInstance.currentRole() == 2{
                    self.changeRoleToScholar()
                }
            }
            let navVC = GFNavController.init(rootViewController: loginVC)
            navVC.modalPresentationStyle = .fullScreen
            self.navigationController!.present(navVC, animated: true, completion: {
                
            })
        }
    }
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = self.view.backgroundColor
        let theaderView = ScholarshipDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 300))
        self.headerview = theaderView
        tempTableView.tableHeaderView = theaderView
        tempTableView.separatorStyle = .none
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(ScholarshipDetailCell.classForCoder(), forCellReuseIdentifier: scholarshipDetailCellIdentifier)
        
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
    lazy var applyView: SubmitView? = {
        let tempView = SubmitView.init(frame: CGRect.zero)
        tempView.submitBtn.setTitle("Apply", for: .normal)
        tempView.submitBtn.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside)
        view.addSubview(tempView)
        return tempView
    }()
}

extension  ScholarshipsDetailController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.newAxieIds == nil || self.newAxieIds!.count == 0 {
            return 0
        }
           return self.newAxieIds!.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 850
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
       cell.isUserInteractionEnabled = false
       cell.contentView.isUserInteractionEnabled = false
       return cell
   }
}

