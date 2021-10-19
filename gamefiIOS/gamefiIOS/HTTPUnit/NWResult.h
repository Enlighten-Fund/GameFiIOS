//
//  NWResult.h
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "NLResultUnit.h"
#import "MWENum.h"

@interface NWResult : NLResultUnit
@property (nonatomic, assign) enum HttpResponseCode errorCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, readonly) BOOL  success;
@property (nonatomic, readonly) BOOL  noResult;
@property (nonatomic, readonly, strong) NSDictionary *response;
@property (nonatomic, readonly, assign, getter = isDataFromDB) BOOL dataFromDB;

+ (instancetype)resultWithAttributes:(NSDictionary *)attributes;
/** 从数据库中获取数据的结果集*/
+ (instancetype)resultSuccessFromDB;
+ (instancetype)resultWithCode:(enum HttpResponseCode)code message:(NSString *)message;
+ (instancetype)resultWithNSError:(NSError *)error;
- (void)setDataFromDB:(BOOL)dataFromDB;
/**
 *  判断该result是否session过期
 *
 *  @return 是否过期
 */
- (BOOL)sessionTimeOut;
@end
