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
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        self.interImgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(60)
        }
        self.btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
    
    lazy var bgImgView : UIImageView = {
        let tempImgView = UIImageView.init(frame: CGRect.zero)
        tempImgView.layer.cornerRadius = 5
        tempImgView.layer.masksToBounds = true
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
