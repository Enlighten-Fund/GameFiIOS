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
    var manager_user_id : Int?
    var scholar_user_id : Int?
    var account_ronin_address : String?
    var account_passcode : String?
    var account_qrcode : String?
    var status : String?
    var start_timestamp : String?
    var end_timestamp : String?
    required init() {}
}

