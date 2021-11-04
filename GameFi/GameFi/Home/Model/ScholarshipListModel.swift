//
//  ScholarshipModel.swift
//  GameFi
//
//  Created by harden on 2021/11/4.
//

import Foundation
import HandyJSON

class ScholarshipListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ScholarshipModel>?
    required init() {}
}
