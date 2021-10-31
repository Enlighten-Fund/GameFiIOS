//
//  LabelTFTipModel.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import HandyJSON
class LabelTFTipModel : NSObject {
    var title : String
    var tip : String
    
    init(title:String,tip:String) {
        self.title = title
        self.tip = tip
    }
}
