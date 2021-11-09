//
//  ScholarListModel.swift
//  GameFi
//
//  Created by harden on 2021/11/9.
//

import Foundation
import HandyJSON

class ScholarListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ScholarModel>?
    required init() {}
}

