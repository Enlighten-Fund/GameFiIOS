//
//  GFDatePickerView.swift
//  GameFi
//
//  Created by harden on 2021/11/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class GFDatePickerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cancelBtn!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        
        self.okBtn!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        
        self.titleLabel!.snp.makeConstraints { make in
            make.centerY.equalTo(self.cancelBtn!.snp.centerY)
            make.left.equalTo(self.cancelBtn!.snp.right)
            make.right.equalTo(self.okBtn!.snp.left)
            make.height.equalTo(25)
        }
        
        self.pickerView!.snp.makeConstraints { make in
            make.top.equalTo(self.okBtn!.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(340)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func dateFromString(string:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)! as NSDate
    }
    
    func stringFromDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date as Date)
    }
    
    lazy var pickerView: UIDatePicker? = {
        let tempPickerView = UIDatePicker.init(frame: CGRect.zero)
        tempPickerView.backgroundColor = UIColor(red: 0.19, green: 0.21, blue: 0.29, alpha: 1)
        tempPickerView.datePickerMode = .date
        tempPickerView.maximumDate = Date()
        if #available(iOS 13.4, *) {
            tempPickerView.preferredDatePickerStyle = .wheels
        }
        self.addSubview(tempPickerView)
        return tempPickerView
    }()
    
    lazy var cancelBtn: UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("Cancel", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 15)
//        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.setTitleColor(.white, for: .normal)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
    lazy var titleLabel: UILabel? = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Medium", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    lazy var okBtn: UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setTitle("OK", for: .normal)
        tempBtn.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 15)
//        tempBtn.backgroundColor = UIColor(red: 0.25, green: 0.43, blue: 0.84, alpha: 1)
        tempBtn.setTitleColor(.white, for: .normal)
        self.addSubview(tempBtn)
        return tempBtn
    }()
    
}

