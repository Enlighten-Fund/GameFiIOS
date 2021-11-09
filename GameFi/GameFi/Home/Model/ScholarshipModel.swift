//
//  ScholarshipModel.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import Foundation
import HandyJSON

class ScholarshipModel: BaseModel {
    var scholarship_id : Int?
    var estimate_daily_slp : Int?
    var scholar_percentage : Float?
    var offer_period : Int?
    var manager_user_name : String?
    var credit_score : Int?
    var mmr : Int?
    var axie_count : Int?
    var security_deposit : Int?
    required init() {}
}
