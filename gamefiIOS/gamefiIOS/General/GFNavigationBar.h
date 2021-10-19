//
//  GFNavigationBar.h
//  gamefiIOS
//
//  Created by harden on 2021/10/19.
//

#import <UIKit/UIKit.h>
@interface GFNavigationBar : UINavigationBar
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign, setter=setHiddenLine:) BOOL hiddenLine;
@end
