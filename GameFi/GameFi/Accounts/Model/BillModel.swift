//
//  BillModel.swift
//  GameFi
//
//  Created by lu chen on 2022/1/7.
//

import Foundation
import HandyJSON

class BillPayModel: BaseModel {
    var account_ronin_address : String?
    var admin_ronin_address : String?
    var pay_value : Float?
    var scholarship_name : String?
    var total_value : Float?
    
    required init() {}
}

class BillPayListModel: BaseModel {
    var count : Int?
    var data : Array<BillPayModel>?
    var next_page : Int?
    
    required init() {}
}

class BillModel: BaseModel {
    var admin_ronin_address : String?
    var manager_ronin_address : String?
    var tatal_pay_value : Float?
    var payment_data_vo : BillPayListModel?
    
    required init() {}
}
