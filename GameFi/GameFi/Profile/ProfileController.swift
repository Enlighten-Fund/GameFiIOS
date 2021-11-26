//
//  ProfileController.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import UIKit
import SnapKit

import MJRefresh
import AWSMobileClient

class ProfileController: ViewController {
    var userInfoModel : UserInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.headerView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        self.tableView!.snp.makeConstraints { make in
            make.top.equalTo(self.headerView!.snp.bottom)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLeftBtn()
        self.requestData()
    }
    
    func updateLeftBtn(){
        if UserManager.sharedInstance.currentRole() == 1 {
            self.leftBtn!.setImage(UIImage.init(named: "profile_scholar"), for: .normal)
        }else{
            self.leftBtn!.setImage(UIImage.init(named: "profile_manager"), for: .normal)
        }
    }
    
    
    func requestData() {
//        self.mc_loading()
        DataManager.sharedInstance.fetchUserDetailinfo { result, reponse in
            DispatchQueue.main.async { [self] in
//                self.mc_remove()
                if result.success!{
                    let userInfoModel : UserInfoModel = reponse as! UserInfoModel
                    self.userInfoModel = userInfoModel
                    self.headerView?.update(userInfoModel: userInfoModel)
                    
                }
            }
        }
    }
    
    @objc override func leftBtnClick() {
        var notiMsg = ""
        var torole = ""
        if UserManager.sharedInstance.currentRole() == 1 {//
            notiMsg = "Your current identity is scholar. Are you sure you want to switch to manager?"
            torole = "2"
        }else if UserManager.sharedInstance.currentRole() == 2{
            notiMsg = "Your current identity is manager. Are you sure you want to switch to scholar?"
            torole = "1"
        }
        //change role
        GFAlert.showAlert(titleStr: "Notice:", msgStr: notiMsg, currentVC: self, cancelHandler: { aletAction in
            
        }, otherBtns: ["YES"]) { idex in
            UserManager.sharedInstance.updateRole(role: torole){
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CHANGEROLE_NOFI), object: torole)
            }
        }
    }
    
    @objc func signBtnClick() {
        if userInfoModel!.scholar_status != nil {
            if userInfoModel!.scholar_status == "NO" {
                self.navigationController?.pushViewController(EditProfileController.init(), animated: true)
            }
        }
    }
    
    func uploadIdPhoto(image:UIImage) {
        DataManager.sharedInstance.uploadImage(url: self.userInfoModel!.avatar!, image: image) { result,reponse in
            DispatchQueue.main.async { [self] in
                self.headerView?.iconImgView.image = image
            }
        }

    }
    
    @objc func  imageViewClick(){
        GFAlert.showAlert(titleStr: nil, msgStr: nil, style: .actionSheet, currentVC: self, cancelBtn: "Cancel", cancelHandler: { (cancelAction) in
            
        }, otherBtns: ["Capture","Photo"]) { (idx) in
            DispatchQueue.main.async { [self] in
                if idx == 0{
                    imagePicker.takePhoto(presentFrom: self, completion: { [unowned self] (image, status) in
                        DispatchQueue.main.async { [self] in
                            if status == .success {
                                self.uploadIdPhoto(image: image!)
                            }else{
                                if status == .denied{
                                    HImagePickerUtils.showTips(at: self,type: .takePhoto)
                                }else{
                                    print(status.description())
                                }
                                
                            }
                        }
                    })
                }else if idx == 1{
                    imagePicker.choosePhoto(presentFrom: self, completion: { [unowned self] (image, status) in
                        DispatchQueue.main.async { [self] in
                            if status == .success {
                                self.uploadIdPhoto(image: image!)
                            }else{
                                if status == .denied{
                                    HImagePickerUtils.showTips(at: self,type: .choosePhoto)
                                }else{
                                    print(status.description())
                                }
                                
                            }
                        }
                        
                    })
                }
            }
        }
    }
    
    lazy var headerView: ProfileHeaderView? = {
        let tempView = ProfileHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH - 30, height: 100))
        tempView.backgroundColor = self.view.backgroundColor
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        tempView.iconImgView.addGestureRecognizer(singleTapGesture)
        tempView.iconImgView.isUserInteractionEnabled = true
        tempView.cetifiedBtn.addTarget(self, action: #selector(signBtnClick), for: .touchUpInside)
        view.addSubview(tempView)
        return tempView
    }()
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.layer.cornerRadius = 5
        tempTableView.layer.masksToBounds = true
        tempTableView.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        tempTableView.separatorStyle = .singleLine
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "profileCellIdentifier")
        tempTableView.dataSource = self
        tempTableView.delegate = self
        tempTableView.separatorColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        view.addSubview(tempTableView)
        return tempTableView
    }()
    lazy var imagePicker = HImagePickerUtils()
}

extension  ProfileController : UITableViewDelegate,UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }else if section == 1{
            return 4
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_icon")
            cell.textLabel?.text = "Profile"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_help")
            cell.textLabel?.text = "Help document"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_privacy")
            cell.textLabel?.text = "Privacy policy"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_term")
            cell.textLabel?.text = "Terms of Service"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_logout")
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }else {
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_discord")
            cell.textLabel?.text = "Join our Discord"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_twitter")
            cell.textLabel?.text = "Join our Twitter"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_youtube")
            cell.textLabel?.text = "Join our Youtube"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
            cell.imageView?.image = UIImage.init(named: "profile_notion")
            cell.textLabel?.text = "Join our Notion"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
    }
   
    cell.contentView.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
    return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row
            {
            case 0:
                self.navigationController?.pushViewController(EditProfileController.init(), animated: true)
            case 4:
                GFAlert.showAlert(titleStr: "Notice:", msgStr: "Are you sure you want to log out？", currentVC: self, cancelHandler: { alertaction in
                    
                }, otherBtns: ["YES"]) { index in
                    AWSMobileClient.default().signOut { error in
                        DispatchQueue.main.async {
                            if let error = error  {
                                print("\(error.localizedDescription)")
                            }else{
                                self.navigationController?.popViewController(animated: true)
                               
                            }
                        }
                        
                    }
                }
            default:
                break
            }
        }else{
            switch indexPath.row
            {
            case 0:
                let url = URL(string: "https://discord.gg/Kpsk9tWXS4")
                // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
                if !UIApplication.shared.canOpenURL(url!) {
                     // 不能跳转就不要往下执行了
                     return
                }
                UIApplication.shared.open(url!, options: [:]) { (success) in
                     if (success) {
                          print("10以后可以跳转url")
                     }else{
                          print("10以后不能完成跳转")
                     }
                 }
            case 1:
                let url = URL(string: "https://twitter.com/0xcyberninja?s=11")
                // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
                if !UIApplication.shared.canOpenURL(url!) {
                     // 不能跳转就不要往下执行了
                     return
                }
                UIApplication.shared.open(url!, options: [:]) { (success) in
                     if (success) {
                          print("10以后可以跳转url")
                     }else{
                          print("10以后不能完成跳转")
                     }
                 }
            case 2:
                let url = URL(string: "https://youtube.com/channel/UC65EXHxwic4cEcebK8iJCjg")
                // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
                if !UIApplication.shared.canOpenURL(url!) {
                     // 不能跳转就不要往下执行了
                     return
                }
                UIApplication.shared.open(url!, options: [:]) { (success) in
                     if (success) {
                          print("10以后可以跳转url")
                     }else{
                          print("10以后不能完成跳转")
                     }
                 }
            case 3:
                let url = URL(string: "https://loud-macaroon-715.notion.site/CyberNinja-WiKi-e6709296d97445b988a3bb87b552e3f9")
                // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
                if !UIApplication.shared.canOpenURL(url!) {
                     // 不能跳转就不要往下执行了
                     return
                }
                UIApplication.shared.open(url!, options: [:]) { (success) in
                     if (success) {
                          print("10以后可以跳转url")
                     }else{
                          print("10以后不能完成跳转")
                     }
                 }
            default:
                break
            }
        }
        
    }
}


