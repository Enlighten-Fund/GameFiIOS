//
//  ManagerOfferingScholarshipModel.swift
//  GameFi
//
//  Created by harden on 2021/11/18.
//

import Foundation
import HandyJSON

class ManagerScholarshipModel: BaseModel {
    var scholarship_id : String?
    var scholarship_name : String?
    var account_ronin_address : String?
    var account_login : String?
    var account_passcode : String?
    var estimate_daily_slp : String?
    var scholar_percentage : String?
    var manager_percentage : String?
    var offer_period : String?
    var start_timestamp : String?
    var status : String?
    var scholar_user_name : String?
    var scholar_credit_score : String?
    var account_mmr_start : String?
    var account_mmr_latest : String?
    var account_lifecycle_slp_start : String?
    var account_lifecycle_slp_latest : String?
    var account_axie_count : String?
    var account_axie_brief : Array<String>?
    var account_security_deposit : String?
    
    //缺失
    var scholar_portrait : String?
    var mmr : String?
    required init() {}
}
