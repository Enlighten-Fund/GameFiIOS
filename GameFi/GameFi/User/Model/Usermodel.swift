//
//  Usermodel.swift
//  GameFi
//
//  Created by harden on 2021/11/2.
//
import Foundation
import AWSMobileClient

class Usermodel {
    static let shared = Usermodel()
       
       // Make sure the class has only one instance
       // Should not init outside
       private init() {}
       
       // Optional
       func reset() {
           // Reset all properties to default value
       }
    
    var _gfrole : String?
    var gfrole : String?{
        get{
            if _gfrole == nil{
                _gfrole = UserDefaults.standard.string(forKey: "gfrole")
                return _gfrole
            }
            
            return _gfrole
        }
        set{
            _gfrole = newValue
            UserDefaults.standard.setValue(newValue, forKey: "gfrole")
        }
    }
}
    
    
