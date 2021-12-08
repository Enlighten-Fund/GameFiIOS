//
//  ScholarshipModel.swift
//  GameFi
//
//  Created by harden on 2021/11/24.
//

import Foundation
import HandyJSON

class ScholarshipModel: BaseModel {
    var scholarship_id : String?
    var scholarship_name : String?
    var account_ronin_address : String?
    var account_login : String?
    var account_lifecycle_slp_start : String?
    var account_lifecycle_slp_latest : String?
    var account_axie_count : String?
    var account_axie_brief : String?
    var account_security_deposit : String?
    var account_passcode : String?
    var account_mmr_start : String?
    var account_mmr_latest : String?
    var offer_period : String?
    var scholar_percentage : String?
    var manager_percentage : String?
    var start_timestamp : String?
    var status : String?
    var manager_user_name : String?
    var manager_credit_score : String?
    var estimate_daily_slp : String?
    var accountAxieArry : Array<String>?{
        get{
            if account_axie_brief == nil {
                return []
            }
            return account_axie_brief?.components(separatedBy: ",")
        }
    }
   
    var axie_brief : String?//图片列表
    var axie_briefArry : Array<String>?{
        get{
            if axie_brief == nil {
                return []
            }
            return axie_brief?.components(separatedBy: ",")
        }
    }
    var credit_score : String?
    var mmr : String?
    var axie_count : String?
    var security_deposit : String?
    var scholar_user_name : String?
    var scholar_credit_score : String?
    var application_id : String?
    var scholar_portrait : String?
    var account_mmr : String?
    var end_timestamp : String?
    required init() {}
}

class ScholarshipListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ScholarshipModel>?
    required init() {}
}
