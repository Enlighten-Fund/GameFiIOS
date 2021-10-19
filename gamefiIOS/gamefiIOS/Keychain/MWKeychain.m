//
//  MWKeychain.m
//  NoWait
//
//  Created by liu nian on 15/6/23.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "MWKeychain.h"
#import <UIKit/UIDevice.h>
#import <JNKeychain/JNKeychain.h>
#import "Config.h"

#define kUUID   @"UUID"

@interface MWKeychain ()
@property (nonatomic, strong) NSString *uuid;
@end
@implementation MWKeychain

SingletonImplementation(MWKeychain);

+ (BOOL)keychainUUID:(NSString *)uuid{
    return [JNKeychain saveValue:uuid forKey:kUUID];
}

- (void)resetKeychainItem{
    @synchronized(self) {
        [JNKeychain deleteValueForKey:kUUID];
        _uuid = nil;
    }
}

#pragma mark - getter
- (NSString *)uuid{
    if (!_uuid) {
        _uuid = [JNKeychain loadValueForKey:kUUID];
        if (_uuid == nil || _uuid.length <= 0) {
            NSString *UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            UUIDString = [UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [[self class] keychainUUID:UUIDString];
            _uuid = UUIDString;
        }
    }
    return _uuid;
}

@end
