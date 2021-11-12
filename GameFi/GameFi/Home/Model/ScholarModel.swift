//
//  ScholarModel.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import HandyJSON

class ProfileModel: BaseModel {
    var age : String?
    var nation : String?
    
    required init() {}
}

class ScholarModel: BaseModel {
    var user_id : String?
    var username : String?
    var email : String?
    var credit_score : String?
    var mmr : String?
    var available_time : String?
    var scholar_since : String?
    
    
    //缺失
    var scholar_portrait:String?
    var winrate : String?
    required init() {}
}

