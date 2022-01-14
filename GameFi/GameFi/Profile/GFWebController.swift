//
//  GFWebController.swift
//  GameFi
//
//  Created by harden on 2021/12/1.
//

import Foundation
import UIKit
import SnapKit
import JXWebViewController
import WebKit
import UIKit

class GFWebController: JXWebViewController {
    var isFormAccount : Bool?//从Account页面跳转过来
    var agreeDiscordBlock : CommonEmptyBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.24, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftBtn!)
        self.leftBtn?.isHidden = false
    }

    open override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if !WKWebView.handlesURLScheme(url.scheme ?? "") && UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            if url.absoluteString.contains("/bindDiscord?code="){//绑定discord
                let aurl : URL = navigationAction.request.url!
                let params = aurl.parametersFromQueryString
                self.mc_loading(text: "Loading")
                DataManager.sharedInstance.bindDiscord(discordid: params!["id"]!,username: params!["username"]!,discriminator: params!["discriminator"]!){ result, reponse in
                    DispatchQueue.main.async { [self] in
                        self.mc_remove()
                        if result.success!{
                            self.mc_text("Success!Getting back to NinjaDAOs…")
                            if isFormAccount == true{
                                self.navigationController?.popToRootViewController(animated: true)
                                if agreeDiscordBlock != nil{
                                    agreeDiscordBlock!()
                                }
                            }else{
                                let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
                                appdelegate.tabbarVC?.selectedIndex = 0
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }else{
                            if  result.msg != nil && !result.msg!.isBlank {
                                self.mc_text(result.msg!)
                            }
                        }
                    }
                }
            }else if url.absoluteString.contains("discord/redirect?error=access_denied"){
                self.mc_text("Later.Getting back to NinjaDAOs…")
                if isFormAccount == true{
                    self.navigationController?.popToRootViewController(animated: true)
                }else{
                    let appdelegate : AppDelegate = UIApplication.shared.delegate! as! AppDelegate
                    appdelegate.tabbarVC?.selectedIndex = 0
                    self.navigationController?.popToRootViewController(animated: true)
                }
               
            }
        }
        decisionHandler(.allow)
    }
    
    @objc func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var leftBtn : UIButton? = {
        let tempBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        tempBtn.setImage(UIImage.init(named: "arrow_left"), for: .normal)
        tempBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
       return tempBtn
    }()
}
