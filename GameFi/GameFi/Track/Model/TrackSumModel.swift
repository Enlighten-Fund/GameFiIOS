//
//  TrackSumModel.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//

import Foundation
import HandyJSON

class TrackSumModel: BaseModel {
    var track_slp_total : String?
    var track_slp_balance : String?
    var track_slp_checkpoint : String?
    var track_slp_scholar : String?
    var track_slp_manager : String?
    var scholar_slp_total : String?
    var scholar_slp_balance : String?
    var scholar_slp_checkpoint : String?
    var scholar_slp_scholar : String?
    var scholar_slp_manager : String?
    var manager_slp_total : String?
    var manager_slp_balance : String?
    var manager_slp_checkpoint : String?
    var manager_slp_scholar : String?
    var manager_slp_manager : String?
    var stats_update_timestamp_sec : String?
    required init() {}
}
