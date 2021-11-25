//
//  Extension.swift
//  Toolbox
//
//  Created by gener on 17/10/26.
//  Copyright © 2017年 Light. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    /// check string cellection is whiteSpace
    var isBlank : Bool{
        return allSatisfy({$0.isWhitespace})
    }
}


extension Optional where Wrapped == String{
    var isBlank : Bool{
        return self?.isBlank ?? true
    }
}

extension UITextField {
    func setupShowPasswordButton() {
        let eyesButton = UIButton()
        eyesButton.addTarget(self, action: #selector(eyesButton(btn:)), for: .touchUpInside)
        eyesButton.frame = CGRect(x: 0, y: 0, width: 21, height: 18)
        eyesButton.setImage(UIImage(named: "eye"), for: .normal)
        eyesButton.setImage(UIImage(named: "eye_look"), for: .selected)
        rightView = eyesButton
        rightViewMode = .always
    }
    
    @objc func eyesButton(btn:UIButton) {
        btn.isSelected = !btn.isSelected
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}

extension UITextField{
   
    func validate(value: String) -> Bool{
        let predicate = NSPredicate(format: " SELF MATCHES %@" , value)
        return predicate.evaluate(with: self.text)

    }


    func validateEmail() -> Bool{
      let temp = self.validate(value: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9,-]+\\.[A-Za-z]{2,20}")
      return temp

    }


    func validatePhoneNumer() -> Bool{
        let temp = self.validate(value: "^\\d{11}$")
        return temp

    }


    func validatePassword() -> Bool {
        let temp = self.validate(value: "(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{8,}$")
        return temp
    }
    
    func validateUsername() -> Bool {
        let temp = self.validate(value: "^[A-Za-z0-9_-]{5,16}$")
        return temp
    }
    func validateNumber() -> Bool {
        let temp = self.validate(value: "^[0-9]+$")
        return temp
    }
    
    
}
/// 抖动方向
///
/// - horizontal: 水平抖动
/// - vertical:   垂直抖动
public enum ZHYShakeDirection: Int {
    case horizontal
    case vertical
}

extension UIView {
    
    /// ZHY 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction:  抖动方向    默认水平方向
    ///   - times:      抖动次数    默认5次
    ///   - interval:   每次抖动时间 默认0.1秒
    ///   - offset:     抖动的偏移量 默认2个点
    ///   - completion: 抖动结束回调
    public func shake(direction: ZHYShakeDirection = .horizontal, times: Int = 5, interval: TimeInterval = 0.1, offset: CGFloat = 2, completion: (() -> Void)? = nil) {
        
        //移动视图动画（一次）
        UIView.animate(withDuration: interval, animations: {
            switch direction {
                case .horizontal:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: offset, y: 0))
                case .vertical:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: offset))
            }
            
        }) { (complete) in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) in
                    completion?()
                })
            }
            
            //如果当前不是最后一次，则继续动画，偏移位置相反
            else {
                self.shake(direction: direction, times: times - 1, interval: interval, offset: -offset, completion: completion)
            }
        }
    }
}

extension UIColor {
     
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
     
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
         
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}


extension NSDate{
    
}

extension UIImage{
    class func resetImgSize(sourceImage : UIImage,maxImageLenght : CGFloat,maxSizeKB : CGFloat) -> Data {

       var maxSize = maxSizeKB

       var maxImageSize = maxImageLenght

       

       if (maxSize <= 0.0) {

           maxSize = 1024.0;

       }

       if (maxImageSize <= 0.0)  {

           maxImageSize = 1024.0;

       }

       //先调整分辨率

       var newSize = CGSize.init(width: sourceImage.size.width, height: sourceImage.size.height)

       let tempHeight = newSize.height / maxImageSize;

       let tempWidth = newSize.width / maxImageSize;

       if (tempWidth > 1.0 && tempWidth > tempHeight) {

           newSize = CGSize.init(width: sourceImage.size.width / tempWidth, height: sourceImage.size.height / tempWidth)

       }

       else if (tempHeight > 1.0 && tempWidth < tempHeight){

           newSize = CGSize.init(width: sourceImage.size.width / tempHeight, height: sourceImage.size.height / tempHeight)

       }

       UIGraphicsBeginImageContext(newSize)

       sourceImage.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))

       let newImage = UIGraphicsGetImageFromCurrentImageContext()

       UIGraphicsEndImageContext()

        var imageData = newImage!.jpegData(compressionQuality: 1.0)

       var sizeOriginKB : CGFloat = CGFloat((imageData?.count)!) / 1024.0;

       //调整大小

       var resizeRate = 0.9;

       while (sizeOriginKB > maxSize && resizeRate > 0.1) {

        imageData = newImage!.jpegData(compressionQuality: CGFloat(resizeRate));

           sizeOriginKB = CGFloat((imageData?.count)!) / 1024.0;

           resizeRate -= 0.1;

       }

       return imageData!

      }

}
