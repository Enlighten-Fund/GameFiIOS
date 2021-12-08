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
    var user_id : String?
    var username : String?
    var avatar : String?
    var credit_score : String?
    var scholar_status : String?
    var scholar_since : String?
    var nation : String?
    var age : String?
    var mmr : String?
    var available_time : String?
    var axie_exp : String?
    var game_history : String?
    var self_intro : String?
    var billing_ronin_address : String?
    var id_photo : String?
    var first_name : String?
    var last_name : String?
    var id_num : String?
    var dob : String?
    var email : String?
    required init() {}
}
