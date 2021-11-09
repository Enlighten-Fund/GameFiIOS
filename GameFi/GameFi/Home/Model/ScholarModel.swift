//
//  ScholarModel.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import HandyJSON

class ScholarModel: BaseModel {
    var scholarship_id : Int?
    var account_ronin_address : String?
    var account_login : String?
    var account_passcode : String?
    var estimate_daily_slp : Int?
    var scholar_percentage : Float?
    var offer_period : Int?
    var start_timestamp : String?
    var status : String?
    var manager_user_name : String?
    var credit_score : Int?
    required init() {}
}

