//
//  GFAlert.swift
//  GameFi
//
//  Created by harden on 2021/11/16.
//

import UIKit

class GFAlert { // 处理 取消按钮 + N个按钮 的点击事件
    static func showAlert(titleStr: String?, msgStr: String?, style: UIAlertController.Style = .alert, currentVC: UIViewController, cancelBtn: String = "Cancel", cancelHandler:((UIAlertAction) -> Void)?, otherBtns:Array<String>?, otherHandler:((Int) -> ())?) {
        //DispatchQueue.global().async{}//子线程
        DispatchQueue.main.async { // 主线程执行
            let alertController = UIAlertController(title: titleStr, message: msgStr,preferredStyle: style)
            //取消按钮
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:{ (action) -> Void in
                cancelHandler?(action)
            })
            alertController.addAction(cancelAction)
            //其他按钮
            if otherBtns != nil {
                for (index, value) in (otherBtns?.enumerated())! {
                    let otherAction = UIAlertAction(title: value, style: .default, handler: { (action) in
                        otherHandler!(index)
                    })
                    alertController.addAction(otherAction)
                }
            }
             currentVC.present(alertController, animated: true, completion: nil)
        }
    }
}
