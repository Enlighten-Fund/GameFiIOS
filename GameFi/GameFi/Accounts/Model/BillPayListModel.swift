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
    var myaccount_ronin_address : String?{
        get{
            return self.account_ronin_address?.replacingOccurrences(of: "0x", with: "ronin:")
        }
    }
    var admin_ronin_address : String?
    var myadmin_ronin_address : String?{
        get{
            return self.admin_ronin_address?.replacingOccurrences(of: "0x", with: "ronin:")
        }
    }
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

