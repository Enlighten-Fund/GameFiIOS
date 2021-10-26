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
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = ViewController.init()
//        do {
            
            
//            Amplify.Logging.logLevel = .verbose
//                try Amplify.add(plugin: AWSCognitoAuthPlugin())
//                try Amplify.configure()
//                print("Amplify configured with auth plugin")
//                signUp(username: "chenlu", password: "java,6720", email: "lu.chen@enlighten.finance")
//                  confirmSignUp(for: "chenlu", with: "185847")
//                signIn(username: "chenlu", password: "java,6720")
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
//
//
//
//
//
//            } catch {
//                print("Failed to initialize Amplify with \(error)")
//            }

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
    lazy var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        return window
    }()
}

