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
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window?.rootViewController = self.tabbarVC
    IQKeyboardManager.shared().isEnabled = true
    IQKeyboardManager.shared().isEnableAutoToolbar = true
        do {
            Amplify.Logging.logLevel = .verbose
                try Amplify.add(plugin: AWSCognitoAuthPlugin())
                try Amplify.configure()
                print("Amplify configured with auth plugin")
//                signUp(username: "chenlu3", password: "java,6720", email: "lu.chen@enlighten3.finance")
//                  confirmSignUp(for: "chenlu3", with: "165332")
//                signIn(username: "chenlu3", password: "java,6720")
//            signOutLocally()
//            fetchAttributes()
//            Amplify.Auth.fetchAuthSession { result in
//                do {
//                    let session = try result.get()
//
//                    // Get user sub or identity id
//                    if let identityProvider = session as? AuthCognitoIdentityProvider {
//                        let usersub = try identityProvider.getUserSub().get()
//                        let identityId = try identityProvider.getIdentityId().get()
//                        print("User sub - \(usersub) and identity id \(identityId)")
//                    }
//
//                    // Get aws credentials
//                    if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider {
//                        let credentials = try awsCredentialsProvider.getAWSCredentials().get()
//                        print("Access key - \(credentials.accessKey) ")
//                    }
//
//                    // Get cognito user pool token
//                    if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
//                        let tokens = try cognitoTokenProvider.getCognitoTokens().get()
//                        print("Id token - \(tokens.idToken) ")
//                    }
//
//                } catch {
//                    print("Fetch auth session failed with error - \(error)")
//                }
//            }





            } catch {
                print("Failed to initialize Amplify with \(error)")
            }

            return true
    }

   

    func signUp(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
    
    func signIn(username: String, password: String) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
//    func fetchAttributes() {
//        Amplify.Auth.fetchUserAttributes() { result in
//            switch result {
//            case .success(let attributes):
//                print("User attributes - \(attributes)")
//            case .failure(let error):
//                print("Fetching user attributes failed with error \(error)")
//            }
//        }
//    }
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    lazy var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        return window
    }()
    
    lazy var tabbarVC: ESTabBarController? = {
        let tabBarController = ESTabBarController()
        let v1 = MarketPlaceController()
        let v2 = ViewController()
        let v3 = ViewController()
        let v4 = RegisterController()
        
        v1.tabBarItem = ESTabBarItem.init(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        v4.tabBarItem = ESTabBarItem.init(title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        
        let n1 = GFNavController.init(rootViewController: v1)
        let n2 = GFNavController.init(rootViewController: v2)
        let n3 = GFNavController.init(rootViewController: v3)
        let n4 = GFNavController.init(rootViewController: v4)
        
        v1.title = "Home"
        v2.title = "Find"
        v3.title = "Photo"
        v4.title = "List"
        tabBarController.viewControllers = [n1, n2, n3, n4]
        return tabBarController
    }()
}

