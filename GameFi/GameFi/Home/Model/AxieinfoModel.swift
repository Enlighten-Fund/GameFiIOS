//
//  AxieinfoModel.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//

import Foundation
import HandyJSON

class AxieinfoModel: BaseModel {
    var id : String?
    var axie_class : String?
    var stats_hp : String?
    var stats_speed : String?
    var stats_skill : String?
    var stats_morale : String?
    var ability_back : String?
    var ability_horn : String?
    var ability_mouth : String?
    var ability_tail : String?
    required init() {}
}

