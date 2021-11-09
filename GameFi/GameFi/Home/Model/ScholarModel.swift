//
//  ScholarModel.swift
//  GameFi
//
//  Created by harden on 2021/11/8.
//

import Foundation
import HandyJSON

class ProfileModel: BaseModel {
    var age : String?
    var nation : String?
    
    required init() {}
}

class ScholarModel: BaseModel {
    var user_id : String?
    var username : String?
    var email : String?
    var credit_score : String?
    var scholar_profile : ProfileModel?
    
    required init() {}
}

