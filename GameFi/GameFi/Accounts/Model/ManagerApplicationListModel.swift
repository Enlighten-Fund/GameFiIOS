//
//  ManagerApplicationListModel.swift
//  GameFi
//
//  Created by harden on 2021/11/17.
//

import Foundation
import HandyJSON

class ManagerApplicationListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ManagerApplicationModel>?
    required init() {}
}

