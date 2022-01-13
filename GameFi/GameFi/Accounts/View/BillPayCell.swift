//
//  BillPayCell.swift
//  GameFi
//
//  Created by lu chen on 2022/1/7.
//

import Foundation
import UIKit
let billPayCellCellIdentifier:String = "BillPayCell"
class BillPayCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
      
        self.scholarShipLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.managerAddressView.snp.makeConstraints { make in
            make.top.equalTo(self.scholarShipLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.ninjaAddressView.snp.makeConstraints { make in
            make.top.equalTo(self.managerAddressView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.totalReturnLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.ninjaAddressView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
        self.owedLabelView.snp.makeConstraints { make in
            make.top.equalTo(self.totalReturnLabelView.snp.bottom)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }
    }

    func update(billPayModel:BillPayModel) {
        if billPayModel.scholarship_name != nil {
            self.scholarShipLabelView.rightLabel.text = billPayModel.scholarship_name
        }
        if billPayModel.account_ronin_address != nil {
//            self.managerAddressLabelView.rightLabel.text = billPayModel.account_ronin_address
            self.managerAddressView.update(roninTitle: "Manager Address", ronin: billPayModel.myaccount_ronin_address)
        }
        if billPayModel.admin_ronin_address != nil {
//            self.ninjaAddressLabelView.rightLabel.text = billPayModel.admin_ronin_address
            self.ninjaAddressView.update(roninTitle: "NinjaDAOs Address", ronin: billPayModel.myadmin_ronin_address)
        }
        if billPayModel.total_value != nil {
            self.totalReturnLabelView.rightLabel.text = "\(lroundf(billPayModel.total_value!))"
        }
        if billPayModel.pay_value != nil {
            self.owedLabelView.rightLabel.text = "\(lroundf(billPayModel.pay_value!))"
        }        
    }
    
    lazy var scholarShipLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Scholarship Name"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
//    lazy var managerAddressLabelView : LabelAndLabelInterView = {
//        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
//        tempLabelView.leftLabel.text = "Manager Address"
//        self.contentView.addSubview(tempLabelView)
//        return tempLabelView
//    }()
//    lazy var ninjaAddressLabelView : LabelAndLabelInterView = {
//        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
//        tempLabelView.leftLabel.text = "NinjaDAOs Address"
//        self.contentView.addSubview(tempLabelView)
//        return tempLabelView
//    }()
    
    lazy var managerAddressView : RoninCopyView = {
        let roninCopyView = RoninCopyView.init(frame: CGRect.zero)
        self.contentView.addSubview(roninCopyView)
        return roninCopyView
    }()
    
    lazy var ninjaAddressView : RoninCopyView = {
        let roninCopyView = RoninCopyView.init(frame: CGRect.zero)
        self.contentView.addSubview(roninCopyView)
        return roninCopyView
    }()
    
    lazy var totalReturnLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Total Return"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
    lazy var owedLabelView : LabelAndLabelInterView = {
        let tempLabelView = LabelAndLabelInterView.init(frame: CGRect.zero)
        tempLabelView.leftLabel.text = "Owed(value-paid_value)"
        self.contentView.addSubview(tempLabelView)
        return tempLabelView
    }()
}

