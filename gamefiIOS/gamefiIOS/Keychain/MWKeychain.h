//
//  MWKeychain.h
//  NoWait
//
//  Created by liu nian on 15/6/23.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "Singelton.h"

@interface MWKeychain : NSObject
SingletonInterface(MWKeychain);
- (NSString *)uuid;
- (void)resetKeychainItem;
@end
