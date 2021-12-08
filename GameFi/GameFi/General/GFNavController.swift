//
//  GFNavController.swift
//  GameFi
//
//  Created by harden on 2021/10/26.
//
import UIKit
class GFNavController: UINavigationController,UINavigationControllerDelegate {
    var popDelegate: UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont(name: "PingFang SC Semibold", size: 15) as Any]
      self.navigationBar.tintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
        
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
//            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont(name: "PingFang SC Semibold", size: 15) as Any]
//            navigationBar.standardAppearance = appearance
//            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
//        }
    }
    
    
    
    
    // MARK: - UINavigationControllerDelegate方法
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        if viewController == self.viewControllers[0] {
            
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        if viewController.isKind(of: ProfileController.self)
            ||  viewController.isKind(of: HomeController.self)
            ||  viewController.isKind(of: TrackController.self)
            ||  viewController.isKind(of: ProfileGuestController.self)
            ||  viewController.isKind(of: ManagerAccountsController.self)
            ||  viewController.isKind(of: ScholarAccountsController.self){
            viewController.hidesBottomBarWhenPushed = false
            super.pushViewController(viewController, animated: false)
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)

    }

}
