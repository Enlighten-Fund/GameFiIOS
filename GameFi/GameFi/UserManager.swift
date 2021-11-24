//
//  UserManager.swift
//  GameFi
//
//  Created by harden on 2021/11/12.
//

import Foundation
import AWSMobileClient
typealias CommonEmptyBlock = ()->Void
class UserManager: NSObject {
    var fetchRoleBlock : CommonEmptyBlock?
//    var fetchTokenBlock : CommonEmptyBlock?
    static let sharedInstance = UserManager()
    private override init() {}
    
    //当前角色 0游客 1scholar 2manager
    func currentRole() ->Int {
        let temp = Usermodel.shared.gfrole
        if temp == nil || temp!.isEmpty {
            return 0
        }else if temp == "1"{
            return 1
        }else if temp == "2"{
            return 2
        }
        return 0
    }
    //更新role aws服务器，本地缓存，内存
    func updateRole(role:String) {
        if role.isEmpty {
            return
        }
        Usermodel.shared.gfrole = role
        AWSMobileClient.default().updateUserAttributes(attributeMap: ["custom:gfrole":role]) { result, error in
            if let error = error  {
                print("\(error.localizedDescription)")
            }
        }
    }
    //从AWS查询role 并更新本地缓存，内存，查询成功后回调block
    func fetchAndUpdateRole()  {
        AWSMobileClient.default().getUserAttributes { [self]attributes, error in
            if(error != nil){
                print("ERROR: \(error)")
            }else{
                if let attributesDict = attributes{
                    if attributesDict["custom:gfrole"] != nil {
                        Usermodel.shared.gfrole = attributesDict["custom:gfrole"]!
                    }
                }
            }
            if self.fetchRoleBlock != nil{
                self.fetchRoleBlock!()
            }
        }
    }
    
    func isLogin() ->Bool {
        let temp = Usermodel.shared.token
        if temp == nil || temp!.isEmpty {
            return false
        }
        return true
    }
    //login register forgetpassword时  把token保存在本地
    func updateToken(updateTokenBlock:@escaping CommonEmptyBlock){
        AWSMobileClient.default().getTokens { [self] tokens, error in
            if let error = error {
                print("Error getting token \(error.localizedDescription)")
            } else if let tokens = tokens {
                Usermodel.shared.token = tokens.accessToken!.tokenString!
                updateTokenBlock()
            }
        }
    }
}

