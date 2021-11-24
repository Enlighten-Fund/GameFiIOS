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

class ProfileGuestController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.headerView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(170)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
        }
        self.tableView!.snp.makeConstraints { make in
            make.top.equalTo(self.headerView!.snp.bottom)
            make.height.equalTo(235)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
     
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserManager.sharedInstance.isLogin() {
            self.navigationController?.pushViewController(ProfileController.init(), animated: false)
        }
    }
    
    
    
    @objc func signBtnClick() {
        let navVC = GFNavController.init(rootViewController: LoginController.init())
        navVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true, completion: {
            
        })
    }
    
    
    lazy var headerView: ProfileGuestHeaderView? = {
        let tempView = ProfileGuestHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH - 30, height: 170))
        tempView.backgroundColor = self.view.backgroundColor
        tempView.signBtn.addTarget(self, action: #selector(signBtnClick), for: .touchUpInside)
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
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
}

extension  ProfileGuestController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 7
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    switch indexPath.row {
    case 0:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_help")
        cell.textLabel?.text = "Help document"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 1:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_privacy")
        cell.textLabel?.text = "Privacy policy"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 2:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_term")
        cell.textLabel?.text = "Terms of Service"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 3:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_discord")
        cell.textLabel?.text = "Join our Discord"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 4:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_twitter")
        cell.textLabel?.text = "Join our Twitter"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 5:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_youtube")
        cell.textLabel?.text = "Join our Youtube"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    case 6:
        cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdentifier", for: indexPath)
        cell.imageView?.image = UIImage.init(named: "profile_notion")
        cell.textLabel?.text = "Join our Notion"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    default:
        cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
    }
    cell.contentView.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
    return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 3:
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
        case 4:
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
        case 5:
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
        case 6:
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
        default:
            break
        }
    }
}


