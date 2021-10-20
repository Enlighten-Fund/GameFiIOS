//
//  Define.h
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#ifndef NoWait_Define_h
#define NoWait_Define_h

//#import "APIConstants.h"
#import "AppDelegate.h"

#if DEBUG
#define NWLog(xx, ...)  NSLog(@"[NoWaitClient][%s][Line %d]: " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NWLog(xx, ...)  ((void)0)
#endif

/*
 *  APP信息
 */
#define APPDELEGATE (AppDelegate*)[[UIApplication sharedApplication]  delegate]

//----------------------系统设备相关----------------------------
//获取设备屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//应用尺寸
#define APP_WIDTH [[UIScreen mainScreen]applicationFrame].size.width
#define APP_HEIGHT [[UIScreen mainScreen]applicationFrame].size.height
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define isAfterIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]>=8)
#define isAfterIOS9 ([[[UIDevice currentDevice] systemVersion] intValue]>=9)
#define isAfterIOS10 ([[[UIDevice currentDevice] systemVersion] intValue]>=10)
//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif
//----------------------系统设备相关----------------------------

//----------------------内存相关----------------------------
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//----------------------图片----------------------------
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define ImageNamed(A) [UIImage imageNamed:A]
//去除遮光效果
#define ImageRenderingMode(A)   [[UIImage imageNamed:A] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------


//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0    \
                                             blue:((float)(rgbValue & 0xFF))/255.0             \
                                            alpha:1.0]
// 随机颜色
#define COLOR_RANDOM = [UIColor colorWithRed:(arc4random() % 255)/255.0 \
                                       green:(arc4random() % 255)/255.0 \
                                        blue:(arc4random() % 255)/255.0 \
                                       alpha:(arc4random() % 255)/255.0]
//带有RGBA的颜色设置
#define COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//清除背景色
#define COLOR_CLEAR [UIColor clearColor]

//----------------------其他----------------------------
//方正黑体简体字体定义
//#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
#define kFontSystem(X)  [UIFont systemFontOfSize:X]
#define kFontSystemBold(X) [UIFont boldSystemFontOfSize:X]
#define kFontMedium(X) [UIFont fontWithName:@"STHeitiSC-Medium" size:X]
#define kFontLight(X) [UIFont fontWithName:@"STHeitiSC-Light" size:X]
#define kFontArialMT(X) [UIFont fontWithName:@"ArialMT" size:X]
//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

/**
 * # 将宏的参数字符串化，C 函数 strchr 返回字符串中第一个 '.' 字符的位置
 */
#define Keypath(keypath) (strchr(#keypath, '.') + 1)
// 有代码提示，可以被重构扫描到
//[objA addObserver: objB forKeyPath: @Keypath(ObjA.property1.property2) options: nil context: nil];

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//由角度获取弧度 由弧度获取角度
#define degreesToRadian(degrees) (M_PI * (degrees) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//Alert
#define SHOWALERT(title, msg, cancel) do{ \
UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil]; \
[alertview show]; }while(0)

#endif

#ifndef isDictWithCountMoreThan0

#define isDictWithCountMoreThan0(__dict__) \
(__dict__!=nil && \
[__dict__ isKindOfClass:[NSDictionary class] ] && \
__dict__.count>0)

#endif

#ifndef isArrayWithCountMoreThan0

#define isArrayWithCountMoreThan0(__array__) \
(__array__!=nil && \
[__array__ isKindOfClass:[NSArray class] ] && \
__array__.count>0)

#endif
