//
//  TrackHeadView.swift
//  GameFi
//
//  Created by harden on 2021/11/10.
//

import Foundation
import UIKit
import SnapKit
import AttributedString
class BillContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.iconImgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(62)
        }
        self.typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        self.totalLabel.snp.makeConstraints { make in
            make.top.equalTo(self.typeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(300)
            make.height.equalTo(25)
        }
    }
    
    func update(total:String) {
        self.totalLabel.text = total
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var typeLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var totalLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Bold", size: 25)
        self.addSubview(tempLabel)
        return tempLabel
    }()

    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
}

class RoninAddressView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.iconImgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(62)
        }
        self.manangerTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        self.manangerRoninLabel.snp.makeConstraints { make in
            make.top.equalTo(self.manangerTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(self.copyBtn1.snp.left)
            make.height.equalTo(40)
        }
        self.copyBtn1.snp.makeConstraints { make in
            make.centerY.equalTo(self.manangerRoninLabel.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        self.ninjaDAOsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.manangerRoninLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        self.ninjaDAOsRoninLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ninjaDAOsTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(self.copyBtn2.snp.left)
            make.height.equalTo(25)
        }
        self.copyBtn2.snp.makeConstraints { make in
            make.centerY.equalTo(self.ninjaDAOsRoninLabel.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        self.owedTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ninjaDAOsRoninLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(130)
            make.height.equalTo(20)
        }
        self.owedLabel.snp.makeConstraints { make in
            make.top.equalTo(self.owedTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(25)
        }
    }
    
    func update(owed:String?) {
        self.owedLabel.text = owed
    }
    
    func update(manangerRonin:String?) {
        if manangerRonin == nil || manangerRonin!.isBlank{
            var att1 : ASAttributedString =  .init(string: "Please contact ",.font(.systemFont(ofSize: 13)))
            att1.add(attributes: [.background(.white)])
            let att2 : ASAttributedString = .init(string: "NinjaDAOs Team ", .foreground(UIColor.init(hexString: "0x3F6DD5")),.action {
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
            })
            var att3 : ASAttributedString =  .init(string: "to set up your Manager Address. ",.font(.systemFont(ofSize: 13)))
            att3.add(attributes: [.background(.white)])
            self.manangerRoninLabel.attributed.text = att1 + att2 + att3
            
            self.copyBtn1.isHidden = true
        }else{
            self.manangerRoninLabel.text = manangerRonin
            self.copyBtn1.isHidden = false
        }
    }
    
    @objc func copyBtnClick(abtn:UIButton) {
        if abtn == self.copyBtn1{
            UIPasteboard.general.string = self.manangerRoninLabel.text
            self.mc_text("Copied successfully!")
        }else if abtn == self.copyBtn2{
            UIPasteboard.general.string = self.ninjaDAOsRoninLabel.text
            self.mc_text("Copied successfully!")
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var iconImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.image = UIImage.init(named: "roninaddress")
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var manangerTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        tempLabel.text = "Manager Address:"
        tempLabel.textColor = UIColor.init(hexString: "0x959EC7")
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var manangerRoninLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.numberOfLines = 0
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var copyBtn1 : UIButton = {
        let temp = UIButton.init(frame: CGRect.zero)
        temp.setTitle("C", for: .normal)
        temp.setTitleColor(.red, for: .normal)
        temp.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.addSubview(temp)
        return temp
    }()
    
    lazy var ninjaDAOsTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempLabel.text = "NinjaDAOs Address:"
        tempLabel.textColor = UIColor.init(hexString: "0x959EC7")
        self.addSubview(tempLabel)
        return tempLabel
    }()
    
    lazy var ninjaDAOsRoninLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.text = "ronin:8be5173faa7f456466b74447a74f81361c49d135"
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var copyBtn2 : UIButton = {
        let temp = UIButton.init(frame: CGRect.zero)
        temp.setTitle("C", for: .normal)
        temp.setTitleColor(.red, for: .normal)
        temp.addTarget(self, action: #selector(copyBtnClick), for: .touchUpInside)
        self.addSubview(temp)
        return temp
    }()

    lazy var owedTitleLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 14)
        tempLabel.text = "Owed:"
        tempLabel.textColor = UIColor.init(hexString: "0x959EC7")
        self.addSubview(tempLabel)
        return tempLabel
    }()
    lazy var owedLabel : UILabel = {
        let tempLabel = UILabel.init(frame: CGRect.zero)
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Avenir Next Medium", size: 13)
        self.addSubview(tempLabel)
        return tempLabel
    }()
}

class BillHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.totalEarnContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.totalOWedContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview()
            make.width.equalTo(IPhone_SCREEN_WIDTH / 2.0 - 15 - 5)
            make.height.equalTo(100)
        }
        self.roninAddressView.snp.makeConstraints { make in
            make.top.equalTo(self.totalEarnContentView.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(160)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(dic:[String : Float?]) {
        if dic["total_earn_value"] != nil{
            let total : Float? = dic["total_earn_value"]!
            if total != nil{
                self.totalEarnContentView.update(total: "\(lroundf(total!)) SLP")
            }
        }
        if dic["total_pay_value"] != nil{
            let total : Float? = dic["total_pay_value"]!
            if total != nil{
                self.totalOWedContentView.update(total: "\(lroundf(total!)) SLP")
                self.update(owed: "\(lroundf(total!)) SLP")
            }
        }
    }
    
    func update(managerRonin:String?) {
        self.roninAddressView.update(manangerRonin: managerRonin)
    }
    
    func update(owed:String?) {
        self.roninAddressView.update(owed: owed)
    }
    
    lazy var totalEarnContentView  : BillContentView = {
        let temp = BillContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "total_earn")
        temp.typeLabel.text = "Total Earned"
        self.addSubview(temp)
        return temp
    }()
    lazy var totalOWedContentView  : BillContentView = {
        let temp = BillContentView.init(frame: CGRect.zero)
        temp.iconImgView.image = UIImage.init(named: "total_owed")
        temp.typeLabel.text = "Total Owed"
        self.addSubview(temp)
        return temp
    }()
    lazy var roninAddressView  : RoninAddressView = {
        let temp = RoninAddressView.init(frame: CGRect.zero)
        self.addSubview(temp)
        return temp
    }()
}
