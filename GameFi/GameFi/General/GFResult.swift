//
//  GFResult.swift
//  GameFi
//
//  Created by harden on 2021/10/27.
//

import Foundation
import HandyJSON

enum HttpResponseCode : Int {
    case HttpResponseCodeSuccess = 1
    case HttpResponseCodeUnkonwError               = 90000
    case HttpResponseCodeErrorFailedConnect        = -1009
}

class GFResult : NSObject{
    var code : Int?
    var msg : String?

    var data : Dictionary<String, Any>?
    
    
    init(reponse: Dictionary<String, Any>?){
        self.code = reponse?["code"] as? Int
        self.msg = reponse?["msg"] as? String
        self.data = reponse
    }
    
    init(error:Error){
        let terror = error as NSError
        self.code = terror.code
        self.msg = error.localizedDescription
       
    }
    
    var success : Bool?{
        get{
            if code == 1 {
                return true
            }
            return false
        }
    }
}
