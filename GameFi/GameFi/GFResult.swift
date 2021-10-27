//
//  GFResult.swift
//  GameFi
//
//  Created by harden on 2021/10/27.
//

import Foundation

enum HttpResponseCode : Int {
    case HttpResponseCodeSuccess = 200
    case HttpResponseCodeUnkonwError               = 90000
    case HttpResponseCodeErrorFailedConnect        = -1009
}

class GFResult : NSObject{
    var code : HttpResponseCode?
    var msg : String?
    var success : Bool?
    var data : Dictionary<String, Any>?
    
    
    init(reponse: Dictionary<String, Any>?){
        self.code = reponse?["code"] as? HttpResponseCode
        self.msg = reponse?["msg"] as? String
        self.data = reponse
    }
    
    init(error:Error){
        let terror = error as NSError
        self.code = HttpResponseCode(rawValue: terror.code)
        self.msg = error.localizedDescription
       
    }
}
