//
//  Define.swift
//  GameFi
//
//  Created by harden on 2021/10/27.
//

import Foundation
import UIKit
//获取屏幕的高
let IPhone_SCREEN_HEIGHT = UIScreen.main.bounds.height
//获取屏幕宽
let IPhone_SCREEN_WIDTH = UIScreen.main.bounds.width
//iPhone X 宏定义
let iPhoneX = (IPhone_SCREEN_HEIGHT == 812 || IPhone_SCREEN_HEIGHT == 896.0 || IPhone_SCREEN_HEIGHT == 844.0 || IPhone_SCREEN_HEIGHT == 926.0 ? true : false)
//适配iPhone X 状态栏高度
let IPhone_StatusBarHeight = (iPhoneX ? 44 : 20)
// 适配iPhone X Tabbar高度
let IPhone_TabbarHeight = (iPhoneX ? (49+34) : 49)
// 适配iPhone X Tabbar距离底部的距离
let IPhone_TabbarSafeBottomMargin = (iPhoneX ? 34 : 0)
// 适配iPhone X 导航栏高度
let IPhone_NavHeight = (iPhoneX ? 88 : 64)

let kAppId = "1598869169"
let CHANGEROLE_NOFI = "CHANGEROLE"
let APPLYSUCCESS_NOFI = "APPLYSUCCESS"
let OFFERSUCCESS_NOFI = "OFFERSUCCESS"
