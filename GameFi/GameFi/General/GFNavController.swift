//
//  GFNavController.swift
//  GameFi
//
//  Created by harden on 2021/10/26.
//
import UIKit
class GFNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont(name: "PingFang SC Semibold", size: 15) as Any]
      self.navigationBar.tintColor = UIColor(red: 0.13, green: 0.14, blue: 0.2, alpha: 1)
    }
    
}
