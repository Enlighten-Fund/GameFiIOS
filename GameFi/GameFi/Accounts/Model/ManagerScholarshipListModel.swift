//
//  ManagerScholarshipListModel.swift
//  GameFi
//
//  Created by harden on 2021/11/18.
//

import Foundation
import HandyJSON

class ManagerScholarshipListModel: BaseModel {
    var count : Int?
    var next_page : Int?
    var data : Array<ManagerScholarshipModel>?
    required init() {}
}
