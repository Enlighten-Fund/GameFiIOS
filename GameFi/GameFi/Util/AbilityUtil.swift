//
//  AbilityUtil.swift
//  GameFi
//
//  Created by harden on 2021/11/15.
//

import Foundation
class AbilityUtil: NSObject {
    static let sharedInstance = AbilityUtil()
    var allAbility : Dictionary<String, Any>?
    private override init() {}
    func config(){
        let path = Bundle.main.path(forResource: "axieability", ofType: "json")
        let url = URL(fileURLWithPath: path!)
            do {
                let data = try Data(contentsOf: url)
                let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                self.allAbility = jsonDic
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
    }
}
