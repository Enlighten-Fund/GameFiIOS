//
//  Usermodel.swift
//  GameFi
//
//  Created by harden on 2021/11/2.
//
import Foundation
import AWSMobileClient

class Usermodel : NSObject {
    var token : String?{
        get{
            var temp = ""
            AWSMobileClient.default().getTokens { tokens, error in
                if let error = error {
                    print("Error getting token \(error.localizedDescription)")
                    temp = ""
                } else if let tokens = tokens {
                    print(tokens.accessToken!.tokenString!)
                    temp = tokens.accessToken!.tokenString!
                }
            }
            return temp
        }
    }
    
    var gfrole : String?{
        get{
            var temp = ""
            AWSMobileClient.default().getUserAttributes {attributes, error in
                if(error != nil){
                        print("ERROR: \(error)")
                }else{
                        if let attributesDict = attributes{
                           print(attributesDict["gfrole"])
                           temp = attributesDict["gfrole"]!
                        }
                }
            }
            return temp
        }
    }
}
    
    
