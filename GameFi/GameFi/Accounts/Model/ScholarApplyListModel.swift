//
//  ScholarApplyListModel.swift
//  GameFi
//
//  Created by harden on 2021/11/23.
//

import Foundation
import HandyJSON

class ScholarApplyModel: BaseModel {
    var scholar_user_name : String?
    var scholar_credit_score : String?
    var scholar_mmr : String?
    var scholar_available_time : String?
    var scholar_axie_exp : String?
    var scholar_nation : String?
    var scholar_user_id : String?
    var scholarship_name : String?
    required init() {}
}

class ScholarApplyListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ScholarApplyModel>?
    required init() {}
}
