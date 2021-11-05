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

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate{
    var homeVC : HomeController? = nil
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = self.tabbarVC
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        configAWS()
            return true
    }
   
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 2 {
            let navVC = GFNavController.init(rootViewController: LoginController.init())
            navVC.modalPresentationStyle = .fullScreen
            tabBarController.present(navVC, animated: true) {
                
            }
        }
    }
    
    
    //Mark 配置AWS
    func configAWS() {
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
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
            }
            
            AWSMobileClient.default().addUserStateListener(self) { (userState, info) in
                switch (userState) {
                case .guest:
                    print("xxxxxxxLinsten--user is in guest mode.")
                case .signedOut:
                    print("xxxxxxxLinsten--user signed out")
                    Usermodel.shared.gfrole = nil
                case .signedIn:
                    print("xxxxxxxLinsten--user is signed in.")
                    self.tabbarVC?.selectedIndex  = 0
                case .signedOutUserPoolsTokenInvalid:
                    print("xxxxxxxLinsten--need to login again.")
                    self.tabbarVC?.present(LoginController.init(), animated: true, completion: {
                        
                    })
                case .signedOutFederatedTokensInvalid:
                    self.tabbarVC?.present(LoginController.init(), animated: true, completion: {
                        
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
        let v2 = ViewController()
        let v3 = ViewController()
        let v4 = LoginController()
        self.homeVC = v1
        v1.tabBarItem = ESTabBarItem.init(title: "Explore", image: UIImage(named: "explore"), selectedImage: UIImage(named: "explore_select"))
        v2.tabBarItem = ESTabBarItem.init(title: "Accounts", image: UIImage(named: "accounts"), selectedImage: UIImage(named: "accounts_select"))
        v3.tabBarItem = ESTabBarItem.init(title: "Tracker", image: UIImage(named: "tracker"), selectedImage: UIImage(named: "tracker_select"))
        v4.tabBarItem = ESTabBarItem.init(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile_select"))
        
        let n1 = GFNavController.init(rootViewController: v1)
        let n2 = GFNavController.init(rootViewController: v2)
        let n3 = GFNavController.init(rootViewController: v3)
        let n4 = GFNavController.init(rootViewController: v4)
        
        v1.title = "Explore"
        v2.title = "Accounts"
        v3.title = "Tracker"
        v4.title = "Profile"
        tabBarController.viewControllers = [n1, n2, n3, n4]
        return tabBarController
    }()
}

