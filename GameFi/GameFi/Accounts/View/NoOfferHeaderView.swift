//
//  NoOfferHeaderView.swift
//  GameFi
//
//  Created by harden on 2021/11/11.
//

// 自定义headerview
import UIKit
 
let noOfferHeaderViewheaderIdentifier = "NoOfferHeaderView"
 
class NoOfferHeaderView: UICollectionReusableView {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints(){
        self.bgImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(165)
        }
        self.interImgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(60)
        }
        self.btn.snp.makeConstraints { make in
            make.center.equalTo(self.interImgView.snp.center)
            make.width.height.equalTo(60)
        }
    }
    
    lazy var bgImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 5
        tempImgView.layer.masksToBounds = true
        tempImgView.layer.borderWidth = 1
        tempImgView.layer.borderColor = UIColor(red: 0.27, green: 0.3, blue: 0.41, alpha: 1).cgColor
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var interImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(tempImgView)
        return tempImgView
    }()
    
    lazy var btn : UIButton = {
        let tempBtn = UIButton.init(frame: CGRect.zero)
        tempBtn.setBackgroundImage(UIImage.init(named: "account_add"), for: .normal)
        tempBtn.setBackgroundImage(UIImage.init(named: "account_add"), for: .highlighted)
        self.addSubview(tempBtn)
        return tempBtn
    }()
}
