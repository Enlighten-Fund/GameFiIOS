//
//  TrackModel.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//

import Foundation
import HandyJSON

class TrackModel: BaseModel {
    var ronin_address : String?
    var name : String?
    var type : String?
    var scholar_percentage : String?
    var slp_total : String?
    var slp_balance : String?
    var slp_checkpoint : String?
    var mmr : String?
    var last_claim_timestamp_sec : String?
    var stats_update_timestamp_sec : String?
    required init() {}
}

