//
//  HomeCollectionCell.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import UIKit
let homeCollectionCellIdentifier:String = "HomeCollectionCell"
class HomeCollectionCell: UICollectionViewCell {
    
    func makeConstraints(){
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = UIColor.init(hexString: "0x30354B")
    }

}
