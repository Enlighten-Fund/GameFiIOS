//
//  File.swift
//  GameFi
//
//  Created by harden on 2021/10/28.
//

import Foundation
import UIKit
import SnapKit

class RegisterController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(IPhone_NavHeight)
            make.bottom.equalToSuperview().offset(-IPhone_TabbarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    
    
    
    lazy var tableView: UITableView? = {
        let tempTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tempTableView.backgroundColor = .lightGray
        tempTableView.tableHeaderView = RegisterHeadView.init(frame: CGRect.init(x: 0, y: 0, width: IPhone_SCREEN_WIDTH, height: 100))
        tempTableView.separatorStyle = .none
        tempTableView.register(LabelTextFildCell.classForCoder(), forCellReuseIdentifier: labelTextFildCellIdentifier)
        tempTableView.register(EmptyTableViewCell.classForCoder(), forCellReuseIdentifier: emptyTableViewCellIdentifier)
        tempTableView.register(ConfirmCodeCell.classForCoder(), forCellReuseIdentifier: confirmCodeCellIdentifier)
        tempTableView.dataSource = self
        tempTableView.delegate = self
        view.addSubview(tempTableView)
        return tempTableView
    }()
    
    lazy var emailModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Email", tip: "")
    }()
    
    lazy var usernameModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Username", tip: "")
    }()
    
    lazy var passwordModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Password", tip: "")
    }()
    
    lazy var codeModel : LabelTFTipModel = {
        return LabelTFTipModel.init(title: "Confirm\ncode", tip: "")
    }()
}

extension  RegisterController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
           return 4
       }
        
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
        
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        switch indexPath.row {
        case 0:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier, for: indexPath) as! LabelTextFildCell
            tempCell.update(model: self.emailModel)
            cell = tempCell
        case 1:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier, for: indexPath) as! LabelTextFildCell
            tempCell.update(model: self.usernameModel)
            cell = tempCell
        case 2:
            let tempCell : LabelTextFildCell = tableView.dequeueReusableCell(withIdentifier: labelTextFildCellIdentifier, for: indexPath) as! LabelTextFildCell
            tempCell.textFild?.setupShowPasswordButton()
            tempCell.update(model: self.passwordModel)
            cell = tempCell
        case 3:
            let tempCell : ConfirmCodeCell = tableView.dequeueReusableCell(withIdentifier: confirmCodeCellIdentifier, for: indexPath) as! ConfirmCodeCell
            tempCell.titleLabel?.numberOfLines = 2
            tempCell.update(model: self.codeModel)
            cell = tempCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: emptyTableViewCellIdentifier, for: indexPath)
        }
            cell.contentView.backgroundColor = .lightGray
           return cell
       }
        
       
}
