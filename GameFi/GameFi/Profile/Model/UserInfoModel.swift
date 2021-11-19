//
//  UserInfoModel.swift
//  GameFi
//
//  Created by harden on 2021/11/19.
//

import Foundation
import HandyJSON


class UserInfoModel: BaseModel {
    var id : String?
    var username : String?
    var avatar : String?
    var credit_score : String?
    var nation : String?
    var available_time : String?
    var scholar_since : String?
    
    var email : String?
    required init() {}
}
