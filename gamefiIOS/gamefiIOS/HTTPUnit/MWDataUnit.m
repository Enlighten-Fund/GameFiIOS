//
//  MWDataUnit.m
//  NoWait
//
//  Created by liu nian on 3/14/16.
//  Copyright © 2016 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "MWDataUnit.h"
#import "NSString+Category.h"

/**********************    接口版本    **********************/
//签名密钥
static NSString *secret_key = @"x2LCe2tq@dM5=T5!8pmoAwf5k0v";

//接口版本
NSString * const kJKVersion = @"V10" ;

@interface MWDataUnit ()

@end
@implementation MWDataUnit
+ (instancetype)sharedInstance {
    static MWDataUnit *sharedInstance = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedInstance = [[MWDataUnit alloc] init];
    });
    
    return sharedInstance;
    
}
//签名算法
- (NSString *)signWithDate:(NSInteger)time nonce:(NSInteger)nonce{
    NSString *timeStr = [@(time) stringValue];
    NSString *nonceStr = [@(nonce) stringValue];
    NSArray *querystring_array = @[secret_key,timeStr,nonceStr];
    NSArray *sortedArray= [querystring_array sortedArrayUsingSelector:@selector(compare:)];
    NSString *quereString = [NSString stringWithFormat:@"%@%@%@",sortedArray[0],sortedArray[1],sortedArray[2]];
    NSString *sign = [quereString SHA1];
    return sign;
}

- (NSMutableDictionary *)getSignArgument{
    NSMutableDictionary *argument = @{}.mutableCopy;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = (NSInteger)timeInterval;
    NSInteger nonce = (arc4random() % 501) + 500;
    argument[@"time"] = @(time);
    argument[@"nonce"] = @(nonce);
    argument[@"sign"] = [self signWithDate:time nonce:nonce];
    argument[@"jkversion"] = [self jkVersion];
    return argument;
}

- (NSMutableDictionary *)getH5SignArgument{
    NSMutableDictionary *argument = @{}.mutableCopy;
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSInteger time = (NSInteger)timeInterval;
    NSInteger nonce = (arc4random() % 501) + 500;
    argument[@"app_time"] = @(time);
    argument[@"app_nonce"] = @(nonce);
    argument[@"app_sign"] = [self signWithDate:time nonce:nonce];
    argument[@"app_jkversion"] = [self jkVersion];
    return argument;
}

#pragma mark getter
- (NSString *)jkVersion{
    return kJKVersion;
}

@end
