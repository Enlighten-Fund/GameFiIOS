import Foundation
import Alamofire
import HandyJSON
import Amplify

typealias CompleteBlock = (GFResult,Any) -> Void
 
//let BaseUrl = "http://a2a7cb64ab5d94072bc625bdedd3f7ff-1103167960.ap-northeast-1.elb.amazonaws.com/v2/"
//let BaseUrl = "https://ykdrpt5lig.execute-api.ap-northeast-1.amazonaws.com/v2/"
let BaseUrl = "https://2njrgbv2l6.execute-api.ap-northeast-1.amazonaws.com/prod/v2/"
//let BaseUrl = "https://api.cyberninja.xyz/v2/"
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
//        dic["user_id"] = UserManager.sharedInstanece.userinfoModel?.user_id
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
            var headers:HTTPHeaders?
            if Usermodel.shared.token != nil && Usermodel.shared.token != ""{
                headers = ["Content-Type":"application/json;charset=UTF-8","token":Usermodel.shared.token!]
            }else{
                headers = ["Content-Type":"application/json;charset=UTF-8"]
            }
            let request = AF.request(urlPath,method: .post,parameters: tempDic,encoding: JSONEncoding.default, headers: headers)
            request.responseJSON { (response) in
                print("请求:\(BaseUrl + url)\nHeader:\(headers)\n入参:\(tempDic)\n返回:\(response.result)")
                switch response.result {
                case let .success(result):
                    do {
                        let resultDict:[String:Any] = result as! [String:Any]
                        let result = GFResult.init(reponse: resultDict)
                        completeBlock(result,resultDict["data"] as Any)
                        
                    }
                case let .failure(error):
                    debugPrint(error)
                    let result = GFResult.init(error: error)
                    completeBlock(result,error)
                }
            }
        }
    //无需鉴权
    func fetchMarketPlaceScholarShip(filter:String, pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"order_by_key" : filter] as [String : Any]
        self.POST(url: "scholarship/list_by_marketplace", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "list_by_marketplace", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ScholarshipListModel.self) as! ScholarshipListModel
//                        completeBlock(result,scholarshipListModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
            
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func fetchScholarShipDetail(scholarshipId:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Int(scholarshipId)]
        self.POST(url: "scholarship/get_by_id", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                let scholarshipModel : ScholarshipModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipModel.self) as! ScholarshipModel
                completeBlock(result,scholarshipModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func applyScholarShipDetail(scholarshipId:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["scholarship_id" : Int(scholarshipId)]
        self.POST(url: "application/create", param: dic as [String : Any]) { result, reponse in
            completeBlock(result,reponse)
        }
    }
    
    func fetchAxieDetail(axieId:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Float(axieId)]
        self.POST(url: "axie/get_by_id", param: dic as [String : Any]) { result, reponse in
//            let path = Bundle.main.path(forResource: "axieinfo", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let axieinfoModel : AxieinfoModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, AxieinfoModel.self) as! AxieinfoModel
//                        completeBlock(result,axieinfoModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
            if result.success!{
                let axieinfoModel : AxieinfoModel = JsonUtil.jsonToModel(reponse as! String, AxieinfoModel.self) as! AxieinfoModel
                completeBlock(result,axieinfoModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func fetchScholar(filter:String, pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20,"order_by_key" : filter] as [String : Any]
        self.POST(url: "user/list_scholar", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "list_scholar", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//            do {
//                    let data = try Data(contentsOf: url)
//                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                let scholarListModel : ScholarListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ScholarListModel.self) as! ScholarListModel
//                    completeBlock(result,scholarListModel)
//            } catch let error as Error? {
//                    print("读取本地数据出现错误!",error)
//            }
            
            if result.success!{
                let scholarListModel : ScholarListModel = JsonUtil.jsonToModel(reponse as! String, ScholarListModel.self) as! ScholarListModel
                completeBlock(result,scholarListModel)
            }else{
                completeBlock(result,reponse)
            }
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
//        let dic = ["user_id" : "201"]
        self.POST(url: "game_accounts/get_summary_by_user", param: [:]) { result, reponse in
//            let path = Bundle.main.path(forResource: "tracksum", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//            do {
//                    let data = try Data(contentsOf: url)
//                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                let trackSumModel : TrackSumModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, TrackSumModel.self) as! TrackSumModel
//                    completeBlock(result,trackSumModel)
//            } catch let error as Error? {
//                    print("读取本地数据出现错误!",error)
//            }
            
            if result.success!{
                let trackSumModel : TrackSumModel = JsonUtil.jsonToModel(reponse as! String, TrackSumModel.self) as! TrackSumModel
                completeBlock(result,trackSumModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //获取Tracker 列表
    func fetchTrackerList(pageIndex:Int,completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "game_accounts/list_all_by_user", param: dic as [String : Any]) { result, reponse in
//            let path = Bundle.main.path(forResource: "tracklist", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//            do {
//                    let data = try Data(contentsOf: url)
//                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                let trackListModel : TrackListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, TrackListModel.self) as! TrackListModel
//                    completeBlock(result,trackListModel)
//            } catch let error as Error? {
//                    print("读取本地数据出现错误!",error)
//            }
            if result.success!{
                let trackListModel = JsonUtil.jsonToModel(reponse as! String, TrackListModel.self)
                completeBlock(result,trackListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //Create Tracker
    func createTracker(accountName:String,ronin_address:String,manager_percentage:Float,completeBlock: @escaping CompleteBlock) {
        let dealronin = ronin_address.replacingOccurrences(of: "ronin:", with: "0x")
        let dic = ["name" : accountName,
                   "ronin_address" : dealronin,
                   "manager_percentage" : Float(manager_percentage),
                   "scholar_percentage": Float(100 - manager_percentage)
                  ] as [String : Any]
        self.POST(url: "game_accounts/create_tracker", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                let trackListModel = JsonUtil.jsonToModel(reponse as! String, TrackListModel.self)
                completeBlock(result,trackListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //Edit Tracker
    func editTracker(accountName:String,ronin_address:String,manager_percentage:Float,completeBlock: @escaping CompleteBlock) {
        let dealronin = ronin_address.replacingOccurrences(of: "ronin:", with: "0x")
        let dic = ["name" : accountName,
                   "ronin_address" : dealronin,
                   "manager_percentage" : Float(manager_percentage),
                   "scholar_percentage": Float(100 - manager_percentage)
        ] as [String : Any]
        self.POST(url: "game_accounts/update_tracker", param: dic as [String : Any]) { result, reponse in
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
        let dealronin = ronin_address.replacingOccurrences(of: "ronin:", with: "0x")
        let dic = ["ronin_address" : dealronin
        ] as [String : Any]
        self.POST(url: "game_accounts/delete_tracker", param: dic as [String : Any]) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //manager latest application
    func fetechScholarApplyListModel(pageIndex:Int,completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "application/list_by_manager", param: dic as [String : Any]) { result, reponse in
//            let path = Bundle.main.path(forResource: "managerApplicationList", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//            do {
//                    let data = try Data(contentsOf: url)
//                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                let ApplicationListModel : ApplicationListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, ApplicationListModel.self) as! ApplicationListModel
//                    completeBlock(result,ApplicationListModel)
//            } catch let error as Error? {
//                    print("读取本地数据出现错误!",error)
//            }
            if result.success!{
                let applicationListModel = JsonUtil.jsonToModel(reponse as! String, ApplicationListModel.self)
                completeBlock(result,applicationListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //manager offering scholarships
    func fetchManagerOfferingScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "scholarship/list_by_manager_offering", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "managerscholarshiplist", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let scholarshipListModel : scholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, scholarshipListModel.self) as! scholarshipListModel
//                        completeBlock(result,scholarshipListModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
            
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //manager nooffer scholarships
    func fetchManagerNoOfferScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "scholarship/list_by_manager_not_offered", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "managerscholarshiplist", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let scholarshipListModel : scholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, scholarshipListModel.self) as! scholarshipListModel
//                        completeBlock(result,scholarshipListModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
//
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //manager history scholarships
    func fetchManagerHistoryScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "scholarship/list_by_manager_historical", param: dic) { result, reponse in
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //schorlar history scholarships
    func fetchScholarHistoryScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "scholarship/list_by_scholar_historical", param: dic) { result, reponse in
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //scholar renting
    func fetchScholarRentScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "scholarship/list_by_scholar", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "managerscholarshiplist", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let scholarshipListModel : scholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, scholarshipListModel.self) as! scholarshipListModel
//                        completeBlock(result,scholarshipListModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
            
            if result.success!{
                let scholarshipListModel : ScholarshipListModel = JsonUtil.jsonToModel(reponse as! String, ScholarshipListModel.self) as! ScholarshipListModel
                completeBlock(result,scholarshipListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //scholar apping
    func fetchScholarApplyingScholarShip(pageIndex:Int, completeBlock: @escaping CompleteBlock) {
        let dic = ["page_index" : pageIndex,"page_size" : 20] as [String : Any]
        self.POST(url: "application/list_by_scholar", param: dic) { result, reponse in
//            let path = Bundle.main.path(forResource: "managerscholarshiplist", ofType: "json")
//            let url = URL(fileURLWithPath: path!)
//                do {
//                        let data = try Data(contentsOf: url)
//                        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonDic : Dictionary = jsonData as! Dictionary<String, Any>
//                    let scholarshipListModel : scholarshipListModel = JsonUtil.jsonToModel(jsonDic["data"] as! String, scholarshipListModel.self) as! scholarshipListModel
//                        completeBlock(result,scholarshipListModel)
//                } catch let error as Error? {
//                        print("读取本地数据出现错误!",error)
//                }
            if result.success!{
                let applicationListModel : ApplicationListModel = JsonUtil.jsonToModel(reponse as! String, ApplicationListModel.self) as! ApplicationListModel
                completeBlock(result,applicationListModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //create scholarship
    func createScholarShip(dic:[String: Any], completeBlock: @escaping CompleteBlock) {
        let dicParam = NSMutableDictionary.init()
        dicParam.addEntries(from: dic)
        self.POST(url: "scholarship/create", param: dicParam as! [String : Any]) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    
    //edit scholarship
    func editScholarShip(dic:[String: Any], completeBlock: @escaping CompleteBlock) {
        let dicParam = NSMutableDictionary.init()
        dicParam.addEntries(from: dic)
        self.POST(url: "scholarship/update_info_by_id", param: dicParam as! [String : Any]) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //create staking scholarship
    func createStakingScholarShip(dic:[String: Any], completeBlock: @escaping CompleteBlock) {
        let dicParam = NSMutableDictionary.init()
        dicParam.addEntries(from: dic)
        self.POST(url: "scholarship/staking/create", param: dicParam as! [String : Any]) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //update scholarship status
    func updateScholarshipStatus(scholarshipid:String, status: String , completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Int(scholarshipid)!,"status" : status] as [String : Any]
        self.POST(url: "scholarship/update_status_by_id", param: dic ) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //fetch payment status
    func fetchPaymentStatus(scholarshipid:String, completeBlock: @escaping CompleteBlock) {
        let dic = ["scholarship_id" : Int(scholarshipid)!] as [String : Any]
        self.POST(url: "payment/get_by_scholarship", param: dic ) { result, reponse in
            if result.success!{
                let paymentModel : PaymentModel = JsonUtil.jsonToModel(reponse as! String, PaymentModel.self) as! PaymentModel
                completeBlock(result,paymentModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    //
    func fetchUserinfo(completeBlock: @escaping CompleteBlock) {
        let dic = [:] as [String : Any]
        self.POST(url: "user/get_by_id", param: dic ) { result, reponse in
            if result.success!{
                let userInfoModel : UserInfoModel = JsonUtil.jsonToModel(reponse as! String, UserInfoModel.self) as! UserInfoModel
                completeBlock(result,userInfoModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func fetchUserDetailinfo(completeBlock: @escaping CompleteBlock) {
        self.POST(url: "user/get_all_by_id", param: [:] ) { result, reponse in
            if result.success!{
                let userInfoModel : UserInfoModel = JsonUtil.jsonToModel(reponse as! String, UserInfoModel.self) as! UserInfoModel
                UserManager.sharedInstance.userinfoModel = userInfoModel
                completeBlock(result,userInfoModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func fetchUpdateUrl(resource : String,completeBlock: @escaping CompleteBlock) {
        let dic = ["resource" : resource] as [String : Any]
        self.POST(url: "user/get_presigned_url_for_put", param: dic ) { result, reponse in
            if result.success!{
                if let data = (reponse as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    do {
                      let dic = try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [String:AnyObject]
                        completeBlock(result,dic as Any)
                    } catch let error as NSError {
                      print(error)
                    }
                  }
               
            }else{
                completeBlock(result,reponse)
            }
        }
    }

    func uploadImage(url: String,image: UIImage,completeBlock: @escaping CompleteBlock){
        let imageData : Data  = UIImage.resetImgSize(sourceImage: image, maxImageLenght: IPhone_SCREEN_HEIGHT, maxSizeKB: 1024)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("image/png", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append(imageData)
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if(error != nil){
                print("\(error!.localizedDescription)")
                let result = GFResult.init(error: error!)
                completeBlock(result,error as Any)
            }else{
                let result = GFResult.init(reponse: [:])
                result.code = 1
                completeBlock(result,response as Any)
            }
            
        }).resume()
    }
    
    func updateUserinfo(userinfoModel:UserInfoModel, completeBlock: @escaping CompleteBlock) {
        let json = JsonUtil.modelToJson(userinfoModel)
        let dic = ["scholar_info_dict": json] as [String : Any]
        self.POST(url: "user/update_by_id", param: dic ) { result, reponse in
            if result.success!{
                let userInfoModel : UserInfoModel = JsonUtil.jsonToModel(reponse as! String, UserInfoModel.self) as! UserInfoModel
                completeBlock(result,userInfoModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    func updateUserScholarStatus(userinfoModel:UserInfoModel,submit:Int, completeBlock: @escaping CompleteBlock) {
        let json = JsonUtil.modelToJson(userinfoModel)
//        let dic = ["scholar_info_dict": json] as [String : Any]
        let dic = ["submit": submit,"scholar_info_dict":json] as [String : Any]
        self.POST(url: "user/update_by_id", param: dic ) { result, reponse in
            if result.success!{
                let userInfoModel : UserInfoModel = JsonUtil.jsonToModel(reponse as! String, UserInfoModel.self) as! UserInfoModel
                completeBlock(result,userInfoModel)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    
    
    //update Application status
    func updateApplicationStatus(applicationId:String, status: String , completeBlock: @escaping CompleteBlock) {
        let dic = ["id" : Int(applicationId)! as Any,"status" : status] as [String : Any]
        self.POST(url: "application/update_by_id", param: dic ) { result, reponse in
            if result.success!{
                completeBlock(result,reponse)
            }else{
                completeBlock(result,reponse)
            }
        }
    }
    //app version
    func fetchAppVersion(completeBlock: @escaping CompleteBlock) {
        let dic = [:] as [String : Any]
        self.POST(url: "common/get_version", param: dic ) { result, reponse in
            if result.success!{
                completeBlock(result,result.data)
            }else{
                completeBlock(result,result.data)
            }
        }
    }
    
    func updateRenewState(id : Int,is_evergreen : Int,completeBlock: @escaping CompleteBlock) {
        let dic = ["is_evergreen":is_evergreen,"id":id] as [String : Any]
        self.POST(url: "scholarship/update_evergreen_by_id", param: dic ) { result, reponse in
            completeBlock(result,reponse)
        }
    }
    
    func fetchInviatateCode(completeBlock: @escaping CompleteBlock) {
        let dic = [:] as [String : Any]
        self.POST(url: "user/get_invite_code", param: dic ) { result, reponse in
            if result.success!{
                let jsonstr : String = result.data!["data"] as! String
                let jsonData:Data = jsonstr.data(using: .utf8)!
                   let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                completeBlock(result,dict as Any)
            }else{
                completeBlock(result,result.data)
            }
        }
    }
}

