//
//  Config.h
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//





#ifndef NoWait_Config_h
#define NoWait_Config_h

// 版本升级定义
#define InHouse_bundleID                        @"com.Pusen.PusenApps"
#define AppStore_bundleID                       @"com.9now.PusenClient"
#define isInHouse                               [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:InHouse_bundleID]
#define isAppStore                              [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:AppStore_bundleID]

#define iAppStoreID                             979857479
#define kAppStoreLink                           @"https://itunes.apple.com/cn/app/id979857479?mt=8"
#define INHOUSE_remoteVersionsPlistURLHTTPS     @"https://ssl.mwee.cn/d/AppInhouse.plist" //inhouse 版本地址
//Widget
#define TodayWidgetBundleId                     @"com.9now.PusenClient.TodayWidget"
//信息获取
#define kUMENG_APPKEY                           @"520af6b556240bd1cf04f4b7"//友盟
#define kBUGLY_APP_ID                           @"900004241" //Bugly appkey
//微信
#define kWechat_AppId                           @"wx0ee6fc04e114791d"
#define kWechat_AppSecret                       @"c131cde4c68f71aa9ebe3fa7a00f7291"
//微博
#define kWeibo_AppKey                           @"2886724534"
#define kWeiboRedirectURI                       @"https://api.weibo.com/oauth2/default.html"
#define kWeibo_Scheme                           @"wb2886724534"
//URLScheme
#define kAppScheme                              @"wei91-meiweibuyongdeng123456"//支付宝支付跳转使用
#define kMweeProtocolScheme                     @"mweeclient"
#define kMweeH5ProtocolScheme                   @"meiweihybrid"

//APNS_Token
#define DICT_KEY_PUSH_DEVICE_TOKEN              @"DICT_KEY_PUSH_DEVICE_TOKEN"

#endif
