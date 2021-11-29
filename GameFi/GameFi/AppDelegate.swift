//
//  AppDelegate.swift
//  GameFi
//
//  Created by harden on 2021/10/25.
//

import UIKit
import Amplify
import AmplifyPlugins
import AWSPluginsCore
import ESTabBarController_swift
import IQKeyboardManager
import AWSCognitoIdentityProvider
import AWSMobileClient
import Bugly
@main
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate{
    var homeVC : HomeController? = nil
    var managerAccontVC : ManagerAccountsController? = nil
    var scholarAccontVC : ScholarAccountsController? = nil
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Bugly.start(withAppId: "95913c773a")
        self.window?.rootViewController = self.tabbarVC
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        configAWS()
        AbilityUtil.sharedInstance.config()
    
    /// 自定义通知
    NotificationCenter.default.addObserver(self, selector: #selector(changeRole), name: NSNotification.Name(rawValue: CHANGEROLE_NOFI), object: nil)
        return true
    }
    /// 接受到通知后的方法回调
    @objc private func changeRole(noti: Notification) {
        DispatchQueue.main.async {
            let str = noti.object as! String
            if str == "1" {
                let tabBarController = ESTabBarController()
                tabBarController.tabBar.barTintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
                tabBarController.delegate = self
                let v1 = HomeController()
                let v2 = ScholarAccountsController()
                let v3 = TrackController()
                let v4 = ProfileGuestController()
                self.homeVC = v1
                v1.tabBarItem = ESTabBarItem.init(title: "Tavern", image: UIImage(named: "explore"), selectedImage: UIImage(named: "explore_select"))
                v2.tabBarItem = ESTabBarItem.init(title: "Accounts", image: UIImage(named: "accounts"), selectedImage: UIImage(named: "accounts_select"))
                v3.tabBarItem = ESTabBarItem.init(title: "Tracker", image: UIImage(named: "tracker"), selectedImage: UIImage(named: "tracker_select"))
                v4.tabBarItem = ESTabBarItem.init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_select"))
                
                let n1 = GFNavController.init(rootViewController: v1)
                let n2 = GFNavController.init(rootViewController: v2)
                let n3 = GFNavController.init(rootViewController: v3)
                let n4 = GFNavController.init(rootViewController: v4)
                
                v1.title = "Tavern"
                v2.title = "Accounts"
                v3.title = "Tracker"
                v4.title = "Profile"
                tabBarController.viewControllers = [n1, n2, n3, n4]
                self.tabbarVC = tabBarController
                self.window?.rootViewController = self.tabbarVC
            }else if str == "2"{
                let tabBarController = ESTabBarController()
                tabBarController.tabBar.barTintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
                tabBarController.delegate = self
                let v1 = HomeController()
                let v2 = ManagerAccountsController()
                let v3 = TrackController()
                let v4 = ProfileGuestController()
                self.homeVC = v1
                v1.tabBarItem = ESTabBarItem.init(title: "Tavern", image: UIImage(named: "explore"), selectedImage: UIImage(named: "explore_select"))
                v2.tabBarItem = ESTabBarItem.init(title: "Accounts", image: UIImage(named: "accounts"), selectedImage: UIImage(named: "accounts_select"))
                v3.tabBarItem = ESTabBarItem.init(title: "Tracker", image: UIImage(named: "tracker"), selectedImage: UIImage(named: "tracker_select"))
                v4.tabBarItem = ESTabBarItem.init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_select"))
                
                let n1 = GFNavController.init(rootViewController: v1)
                let n2 = GFNavController.init(rootViewController: v2)
                let n3 = GFNavController.init(rootViewController: v3)
                let n4 = GFNavController.init(rootViewController: v4)
                
                v1.title = "Tavern"
                v2.title = "Accounts"
                v3.title = "Tracker"
                v4.title = "Profile"
                tabBarController.viewControllers = [n1, n2, n3, n4]
                self.tabbarVC = tabBarController
                self.window?.rootViewController = self.tabbarVC
            }
        }
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let nav : GFNavController = viewController as! GFNavController
        let vc = nav.viewControllers[0]
        if vc.isKind(of: ManagerAccountsController.classForCoder()) ||  vc.isKind(of: ScholarAccountsController.classForCoder()) || vc.isKind(of: TrackController.classForCoder()){
            if !UserManager.sharedInstance.isLogin() {
                let navVC = GFNavController.init(rootViewController: LoginController.init())
                navVC.modalPresentationStyle = .fullScreen
                self.tabbarVC?.present(navVC, animated: true, completion: {
                    
                })
                return false
            }
            return true
        }
        return true
    }
    
    //Mark 配置AWS
    func configAWS() {
        let previousBuild = UserDefaults.standard.string(forKey: "build")
            let currentBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
            if previousBuild == nil {
                //fresh install
                AWSMobileClient.default().signOut()
            } else if previousBuild != currentBuild {
                //application updated
            }
            UserDefaults.standard.set(currentBuild, forKey: "build")
        
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            UserManager.sharedInstance.fetchAndUpdateRole {
                
            }
            UserManager.sharedInstance.updateToken {
                DataManager.sharedInstance.fetchUserDetailinfo { result, reponse in
                    
                }
            }
            AWSMobileClient.default().addUserStateListener(self) { (userState, info) in
                switch (userState) {
                case .guest:
                    print("xxxxxxxLinsten--user is in guest mode.")
                case .signedOut:
                    print("xxxxxxxLinsten--user signed out")
                    Usermodel.shared.gfrole = nil
                    Usermodel.shared.token = nil
                   case .signedIn:
                    print("xxxxxxxLinsten--user is signed in.")
                    
                case .signedOutUserPoolsTokenInvalid:
                    print("xxxxxxxLinsten--need to login again.")
                    DispatchQueue.main.async { [self] in
                        let navVC = GFNavController.init(rootViewController: LoginController.init())
                        navVC.modalPresentationStyle = .fullScreen
                        self.tabbarVC?.present(navVC, animated: true, completion: {
                            
                        })
                    }
                   
                case .signedOutFederatedTokensInvalid:
                    let navVC = GFNavController.init(rootViewController: LoginController.init())
                    navVC.modalPresentationStyle = .fullScreen
                    self.tabbarVC?.present(navVC, animated: true, completion: {
                        
                    })
                    print("xxxxxxxLinsten--user logged in via federation, but currently needs new tokens")
                default:
                    print("xxxxxxxLinsten--unsupported")
                }
            }
        } catch {
                print("Failed to initialize Amplify with \(error)")
        }
    }
    
    
   //Mark getter
    lazy var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        return window
    }()
    
    lazy var tabbarVC: ESTabBarController? = {
        let tabBarController = ESTabBarController()
        tabBarController.tabBar.barTintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
        tabBarController.delegate = self
        let v1 = HomeController()
        var v2 : UIViewController?
        let currentRole = UserManager.sharedInstance.currentRole()
        if currentRole == 1 {
            v2 = ScholarAccountsController()
        }else{
            v2 = ManagerAccountsController()
        }
        let v3 = TrackController()
        let v4 = ProfileGuestController()
        self.homeVC = v1
        v1.tabBarItem = ESTabBarItem.init(title: "Tavern", image: UIImage(named: "explore"), selectedImage: UIImage(named: "explore_select"))
        v2!.tabBarItem = ESTabBarItem.init(title: "Accounts", image: UIImage(named: "accounts"), selectedImage: UIImage(named: "accounts_select"))
        v3.tabBarItem = ESTabBarItem.init(title: "Tracker", image: UIImage(named: "tracker"), selectedImage: UIImage(named: "tracker_select"))
        v4.tabBarItem = ESTabBarItem.init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_select"))
        
        let n1 = GFNavController.init(rootViewController: v1)
        let n2 = GFNavController.init(rootViewController: v2!)
        let n3 = GFNavController.init(rootViewController: v3)
        let n4 = GFNavController.init(rootViewController: v4)
        
        v1.title = "Tavern"
        v2!.title = "Accounts"
        v3.title = "Tracker"
        v4.title = "Profile"
        tabBarController.viewControllers = [n1, n2, n3, n4]
        return tabBarController
    }()
}

