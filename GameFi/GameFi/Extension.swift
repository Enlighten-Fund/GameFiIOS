//
//  Extension.swift
//  Toolbox
//
//  Created by gener on 17/10/26.
//  Copyright © 2017年 Light. All rights reserved.
//

import Foundation
import UIKit

extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}

extension UITextField {
    func setupShowPasswordButton() {
        let eyesButton = UIButton(type: .system)
        eyesButton.addTarget(self, action: #selector(eyesButton(btn:)), for: .touchUpInside)
        eyesButton.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        eyesButton.setImage(UIImage(named: "me_1"), for: .normal)
        eyesButton.setImage(UIImage(named: "me"), for: .selected)
        eyesButton.tintColor = .blue
        rightView = eyesButton
        rightViewMode = .always
    }
    
    @objc func eyesButton(btn:UIButton) {
        btn.isSelected = !btn.isSelected
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}

