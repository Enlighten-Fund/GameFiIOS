import Foundation
import Alamofire
import HandyJSON

typealias CompleteBlock = (GFResult,Any) -> Void
 
let BaseUrl = "http://a2a7cb64ab5d94072bc625bdedd3f7ff-1103167960.ap-northeast-1.elb.amazonaws.com/v2/"
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
        dic["role"] = UserManager.sharedInstance.currentRole()
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
    //无需鉴权
    func fetchMarketPlaceScholarShip(filter:String, pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"order_by_key" : filter] as [String : Any]
        self.POST(url: "scholarship/list_by_marketplace", param: dic) { result, reponse in
            let path = Bundle.main.path(forResource: "list_by_marketplace", ofType: "json")
            let url = URL(fileURLWithPath: path!)
                do {
                        let data = try Data(contentsOf: url)
                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                    let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ScholarshipListModel.self) as! ScholarshipListModel
                        completeBlock(result,scholarshipListModel)
                } catch let error as Error? {
                        print("读取本地数据出现错误!",error)
                }
            
//            if result.success!{
//                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
//                completeBlock(result,scholarshipListModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
    
    func fetchScholarShipDetail(scholarshipId:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Int(scholarshipId)]
        self.POST(url: "scholarship/get_by_id", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                let scholarshipDetailModel : ScholarshipDetailModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipDetailModel.self) as! ScholarshipDetailModel
                completeBlock(result,scholarshipDetailModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func fetchAxieDetail(axieId:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Int(axieId)]
        self.POST(url: "axie/get_by_id", param: dic as [String : Any]) { result, reponse in
            let path = Bundle.main.path(forResource: "axieinfo", ofType: "json")
            let url = URL(fileURLWithPath: path!)
                do {
                        let data = try Data(contentsOf: url)
                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                    let axieinfoModel : AxieinfoModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, AxieinfoModel.self) as! AxieinfoModel
                        completeBlock(result,axieinfoModel)
                } catch let error as Error? {
                        print("读取本地数据出现错误!",error)
                }
//            if result.success!{
//                let axieinfoModel : AxieinfoModel = JsonUtil.jsonToModel(reponse as! String, AxieinfoModel.self) as! AxieinfoModel
//                completeBlock(result,axieinfoModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
    
    func fetchScholar(filter:String, pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"order_by_key" : filter] as [String : Any]
        self.POST(url: "user/list_scholar", param: dic) { result, reponse in
            let path = Bundle.main.path(forResource: "list_scholar", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                let scholarListModel : ScholarListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ScholarListModel.self) as! ScholarListModel
                    completeBlock(result,scholarListModel)
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
            
//            if result.success!{
//                let scholarListModel : ScholarListModel = JsonUtil.jsonToModel(reponse as! String, ScholarListModel.self) as! ScholarListModel
//                completeBlock(result,scholarListModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
    
    func fetchUserDetail(userid:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : userid]
        self.POST(url: "user/get_by_id", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                let scholarDetailModel : ScholarDetailModel = JsonUtil.jsonToModel(reponse as! String, ScholarDetailModel.self) as! ScholarDetailModel
                completeBlock(result,scholarDetailModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    //获取Tracker总数据
    func fetchTrackerSummary(completeBlock: @escaping CompleteBlock) {
        let dic = ["user_id" : "123"]
        self.POST(url: "game_accounts/get_summary_by_user", param: dic as [String : Any]) { result, reponse in
            let path = Bundle.main.path(forResource: "tracksum", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                let trackSumModel : TrackSumModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, TrackSumModel.self) as! TrackSumModel
                    completeBlock(result,trackSumModel)
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
            
//            if result.success!{
//                let trackSumModel : TrackSumModel = JsonUtil.jsonToModel(reponse as! String, TrackSumModel.self) as! TrackSumModel
//                completeBlock(result,trackSumModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
    
    //获取Tracker 列表
    func fetchTrackerList(pageIndex:Int,completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"user_id" : "123"] as [String : Any]
        self.POST(url: "game_accounts/list_all_by_user", param: dic as [String : Any]) { result, reponse in
            let path = Bundle.main.path(forResource: "tracklist", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                let trackListModel : TrackListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, TrackListModel.self) as! TrackListModel
                    completeBlock(result,trackListModel)
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
//            if result.success!{
//                let trackListModel = JsonUtil.jsonToModel(reponse as! String, TrackListModel.self)
//                completeBlock(result,trackListModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
    
    //Create Tracker
    func createTracker(accountName:String,ronin_address:String,manager_percentage:Float,completeBlock: @escaping CompleteBlock) {
        let dic = ["name" : accountName,
                   "ronin_address" : ronin_address,
                   "manager_percentage" : manager_percentage,
                   "scholar_percentage": 100 - manager_percentage,
                   "user_id": "123"] as [String : Any]
        self.POST(url: "game_accounts/create_tracker", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                let trackListModel = JsonUtil.jsonToModel(reponse as! String, TrackListModel.self)
                completeBlock(result,trackListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //Delete Tracker
    func deleteTracker(ronin_address:String,completeBlock: @escaping CompleteBlock) {
        let dic = ["ronin_address" : ronin_address,
                   "user_id": "123"] as [String : Any]
        self.POST(url: "game_accounts/delete_tracker", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //manager latest application
    func fetechManagerLatestApplication(pageIndex:Int,completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"user_id": "123"] as [String : Any]
        self.POST(url: "application/list_by_manager", param: dic as [String : Any]) { result, reponse in
            let path = Bundle.main.path(forResource: "managerApplicationList", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
                let managerApplicationListModel : ManagerApplicationListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ManagerApplicationListModel.self) as! ManagerApplicationListModel
                    completeBlock(result,managerApplicationListModel)
            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
            }
//            if result.success!{
//                let managerApplicationListModel = JsonUtil.jsonToModel(reponse as! String, ManagerApplicationListModel.self)
//                completeBlock(result,managerApplicationListModel)
//            }else{
//                completeBlock(result,reponse)
//            }
        }
    }
}
