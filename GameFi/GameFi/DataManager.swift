import Foundation
import Alamofire
import HandyJSON

typealias CompleteBlock = (GFResult,Any) -> Void
 
let BaseUrl = "http://a2a7cb64ab5d94072bc625bdedd3f7ff-1574935958.ap-northeast-1.elb.amazonaws.com/v2/"
let jkver = "1.0"


class DataManager: NSObject {
    static let sharedInstance = DataManager()
    private override init() {}
    
    func commonParameters() -> Dictionary<String, Any> {
        var dic: [String:Any] =  [String:Any]()
        dic["appver"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        dic["appbuild"] = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        dic["jkver"] = jkver
        dic["os"] = "iOS" + UIDevice.current.systemVersion
        return dic
    }
    //MARK: - GET请求
//    func GET(url:String,param:[String:Any]?,success: @escaping CompleteBlock) {
//            if param != nil {
//                print("\n param:")
//                print(param! as [String:Any])
//            }
//            print("url===:" + url)
//        let urlPath:URL = URL(string: BaseUrl + url)!
//            let headers:HTTPHeaders = ["Content-Type":"application/json;charset=utf-8"]
//            let request = AF.request(urlPath,method: .get,parameters: param,encoding: JSONEncoding.default, headers: headers)
//            request.responseJSON { (response) in
//                DispatchQueue.global().async(execute: {
//                    print(response.result)
//                    let resultDict:[String:Any] = response.result as! [String:Any]
////                    var result = Han
//                    switch response.result {
//                    case let .success(result):
//                        do {
//                            let resultDict:[String:Any] = result as! [String:Any]
//                            DispatchQueue.main.async(execute: {
//                                /** 返回码处理 */
//                                let resp_code: Int = (resultDict["resp_code"] as! Int)
//                                switch resp_code {
//                                case 0:
////                                    success(resultDict)
//                                case 1: break
//                                    // SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
//                                default: break
//                                    // SVProgressHUD.showError(withStatus: (resultDict["resp_msg"] as! String))
//                                }
//                            })
//                        }
//                    case let .failure(error):
//                        print(error)
//                    }
//
//                })
//            }
//        }
        //MARK: - POST请求  字典参数 ["id":"1","value":""]
        func POST(url:String,param:[String:Any],completeBlock: @escaping CompleteBlock) {
            var tempDic = commonParameters()
            let tempDic2 = param
            tempDic.merge(tempDic2) { _, _ in
                
            }
            let urlPath:URL = URL(string: BaseUrl + url)!
            let headers:HTTPHeaders = ["Content-Type":"application/json;charset=UTF-8"]
            let request = AF.request(urlPath,method: .post,parameters: tempDic,encoding: JSONEncoding.default, headers: headers)
            request.responseJSON { (response) in
                print("请求\(url)\n入参:\(tempDic)\n返回:\(response.result)")
                switch response.result {
                case let .success(result):
                    do {
                        let resultDict:[String:Any] = result as! [String:Any]
                        let result = GFResult.init(reponse: resultDict)
                        completeBlock(result,resultDict["data"] as Any)
                    }
                case let .failure(error):
                    print(error)
                    let result = GFResult.init(error: error)
                    completeBlock(result,error)
                }
            }
        }
    
    func checkEmail(email:String,completeBlock: @escaping CompleteBlock) {
        let dic = ["email" : email]
        self.POST(url: "user/check_exist", param: dic as [String : Any]) { result, reponse in
            completeBlock(result,reponse)
        }
    }
    
    func checkUsername(username:String,completeBlock: @escaping CompleteBlock) {
        let dic = ["username" : username]
        self.POST(url: "user/check_exist", param: dic as [String : Any]) { result, reponse in
            completeBlock(result,reponse)
        }
    }
    
    func fetchScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        var roleStr = ""
        let role : String? = Usermodel.shared.gfrole
        if role == nil {
            roleStr = "marketplace"
        }else if role == "1"{
            roleStr = "scholar"
        }else if role == "2"{
            roleStr = "manager"
        }
        let dic = ["page_index" : pageIndex,"page_size" : 20]
        self.POST(url: "scholarship/list_by_\(roleStr)", param: dic) { result, reponse in
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
 
}
