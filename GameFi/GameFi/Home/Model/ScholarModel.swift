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
    var avatar:String?
    var axie_exp:String?
    
    var rent_times:Int?
    var rent_days: Float?
    var total_slp: Int?
    var total_mmr_change: Int?
    var total_mmr_day: Float? // avg_mmr = total_mmr_day / rent_days
    required init() {}
}

