//
//  ApplicationModel.swift
//  GameFi
//
//  Created by harden on 2021/11/24.
//

import Foundation
import HandyJSON

class ApplicationModel: BaseModel {
    var application_id : String?
    var scholarship_id : String?
    var scholar_user_id : String?
    var manager_user_id : String?
    var application_status : String?
    
    var scholarship_name : String?
    var scholarship_estimate_daily_slp : String?
    var scholarship_scholar_percentage : String?
    var scholarship_manager_percentage : String?
    var scholarship_offer_period : String?
    
    var scholar_user_name : String?
    var scholar_credit_score : String?
    var scholar_mmr : String?
    var scholar_available_time : String?
    var scholar_axie_exp : String?
    var scholar_nation : String?
    
//    var nation : String?
//    var age : String?
//    var game_history : String?
//    var self_intro : String?
    
    required init() {}
}

class ApplicationListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ApplicationModel>?
    required init() {}
}
