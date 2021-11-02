//
//  Usermodel.swift
//  GameFi
//
//  Created by harden on 2021/11/2.
//
import Foundation
import HandyJSON
class Usermodel : NSObject {
    var _token : String?
    var token : String?{
        get{
            if _token == nil  {
                _token = UserDefaults.init().string(forKey: "token")
            }
            return _token
        }
    }
    var _gfrole : String?
    var gfrole : String?{
        get{
            if _gfrole == nil  {
                _gfrole = UserDefaults.init().string(forKey: "gfrole")
            }
            return _gfrole
        }
    }
}
    
    
