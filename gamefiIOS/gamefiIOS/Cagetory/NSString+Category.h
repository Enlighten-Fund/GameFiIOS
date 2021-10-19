//
//  NSString+Category.h
//  NoWait
//
//  Created by liu nian on 15/4/10.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
@interface NSString (Category)
- (NSString *)MD5Hash;
- (NSString*)SHA1;
- (BOOL)isExist;
- (CGFloat)heightWithMaxWidth:(CGFloat)maxWidth andTextFont:(UIFont *)textFont;
- (BOOL)isBetweenFromString:(NSString*)fromString toString:(NSString*)toString;
@end
