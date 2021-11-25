//
//  PaymentModel.swift
//  GameFi
//
//  Created by harden on 2021/11/25.
//

import Foundation
import HandyJSON

class PaymentModel: BaseModel {
    var id : String?
    var scholarship_id : String?
    var ronin_address : String?
    var value : String?
    var scholar_value : String?
    var paid_value : String?
    var token : String?
    var status : String?
    var modified_timestamp : String?
    
    required init() {}
}
