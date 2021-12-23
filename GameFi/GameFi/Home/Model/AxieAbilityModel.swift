//
//  AxieAbilityModel.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//

import Foundation
import HandyJSON

class AxieAbilityModel: BaseModel {
    var id : String?
    var partName : String?
    var skillName : String?
    var defaultAttack : String?
    var defaultDefense : String?
    var defaultEnergy : String?
    var expectType : String?
    var triggerText : String?
    var description : String?
    var iconId : String?
    required init() {}
}

