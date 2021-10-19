//
//  NWResult.m
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "NWResult.h"

@interface NWResult ()
@property (nonatomic, readwrite, strong) NSDictionary *response;
@property (nonatomic, readwrite) BOOL dataFromDB;
@end

@implementation NWResult

+ (instancetype)resultWithAttributes:(NSDictionary *)attributes{
    return [[NWResult alloc] initWithDict:attributes];
}

+ (instancetype)resultSuccessFromDB{
    NSDictionary *attributes = @{@"errno":@(HttpResponseCodeSuccess),@"errmsg":@"请求成功"};
    NWResult *result = [[NWResult alloc] initWithDict:attributes];
    [result setDataFromDB:YES];
    return result;
}
+ (instancetype)resultWithCode:(enum HttpResponseCode)code message:(NSString *)message{
    message                  = message == nil? @"":message;
    NSDictionary *attributes = @{@"errno":@(code),@"errmsg":message};
    
    return [[NWResult alloc] initWithDict:attributes];
}

+ (instancetype)resultWithNSError:(NSError *)error{
    return [NWResult resultWithCode:error.code message:error.localizedDescription];
}
- (id)initWithDict:(NSDictionary *)dict{
    if (self                 = [super init]) {
        self.response = dict;
        if ([[dict allKeys] containsObject:@"errno"]) {
            self.errorCode                = (HttpResponseCode )[dict[@"errno"] integerValue];
        }else{
            self.errorCode = HttpResponseCodeUnkonwError;
        }
        
        if ([[dict allKeys] containsObject:@"errmsg"]) {
            if (dict[@"errmsg"]) {
                self.message             = dict[@"errmsg"];
            }
        }
    }
    return self;
}

- (BOOL)sessionTimeOut{
    if (self.errorCode == HttpResponseCodeSessionTimeOut) {
        return YES;
    }
    return NO;
}
#pragma mark getter
- (BOOL)ableCache{
    return [self success];
}

- (BOOL)success{
    if (self.errorCode == HttpResponseCodeSuccess) {
        return YES;
    }
    return NO;
}
- (BOOL)noResult{
    if (self.errorCode == HttpResponseCodeNoData) {
        return YES;
    }
    return NO;
}

- (NSString *)message{
    if (self.errorCode == NSURLErrorNotConnectedToInternet) {
        return @"当前服务器无法连接，请稍后再试";
    }
    return _message;
}
#pragma mark setter

@end
