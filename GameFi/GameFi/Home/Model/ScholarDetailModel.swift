//
//  ScholarDetailModel.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import HandyJSON

class ScholarDetailModel: ScholarModel {
    var scholarship_id : Int?
    var manager_user_id : Int?
    var scholar_user_id : Int?
    var account_ronin_address : String?
    var gamepalybefore : String?
    var selfintroduction : String?
    var status : String?
    var start_timestamp : String?
    var end_timestamp : String?
    required init() {}
}
