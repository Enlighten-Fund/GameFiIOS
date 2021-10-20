//
//  BaseUIViewController.h
//  gamefiIOS
//
//  Created by harden on 2021/10/20.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MWNavigationBar.h"
#import "NWUtility.h"
#import "Define.h"
@interface BaseUIViewController : UIViewController
@property (nonatomic, strong) MWNavigationBar *navigationBarView;
@property (nonatomic, strong) UINavigationItem *mwNavigationItem;
@property (nonatomic, strong) UIView *controllerView;

@property (nonatomic, strong) UIButton *btnLeftItem;
@property (nonatomic, assign) BOOL hiddenNavBar;
@property (nonatomic, assign) BOOL hideBackItem;

- (void)setDefaultBackItem;
- (void)leftButtonAction:(id)sender; // 左侧按钮（如返回）事件
@end

