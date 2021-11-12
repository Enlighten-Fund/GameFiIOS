//
//  ScholarshipModel.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import Foundation
import HandyJSON

class ScholarshipModel: BaseModel {
    var axie_brief : Array<String>?//图片列表
    
    var scholarship_id : String?
    var estimate_daily_slp : String?
    var myestimate_daily_slp : String?{
        get{
            if estimate_daily_slp == nil {
                return ""
            }
            return estimate_daily_slp
        }
    }
    var scholar_percentage : String?
    var offer_period : String?
    var manager_user_name : String?
    var credit_score : String?
    var mmr : String?
    var axie_count : String?
    var security_deposit : String?
    required init() {}
}
