//
//  ViewController.swift
//  GameFi
//
//  Created by harden on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        DataManager.sharedInstance.POST(url: "example", param: ["abc" : "d"]) { result,response in
            
        }
    }


}

