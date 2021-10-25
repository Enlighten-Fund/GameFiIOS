//
//  DataReqHelper.m
//  NoWait
//
//  Created by liu nian on 2016/10/20.
//  Copyright © 2016年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "DataReqHelper.h"
#import "MWKeychain.h"
#import <AdSupport/AdSupport.h>

@interface DataReqHelper ()
@property (nonatomic, strong) dispatch_group_t httpRequest_group_t;
@property (nonatomic, strong) dispatch_queue_t httpRequest_queue_t;
@end

@implementation DataReqHelper

#pragma mark - Base Function
- (void )reponseURI:(NSString *)uri operationCompleteBlock:(RequestCompleteBlock)requestCompleteBlock
             result:(NWResult *)result{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (requestCompleteBlock) {
            requestCompleteBlock(result);
        }

    });
}
#pragma 标识
- (NSString *)idfaString{
    ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
    if(asIM.advertisingTrackingEnabled){
        return [asIM.advertisingIdentifier UUIDString];
    }
    return nil;
}
- (NSString *)idfvString{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
/**
 *  组合公共参数
 *
 *  @param parameters 业务自定义参数
 *
 *  @return 包含公共参数的请求参数
 */
- (NSMutableDictionary *)commonArgumentWithUserParameters:(NSDictionary *)parameters{
    NSMutableDictionary *argument = nil;
    if (parameters) {
        argument = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }else{
        argument = @{}.mutableCopy;
    }
    argument[@"deviceid"] = [[MWKeychain sharedInstance] uuid];
    argument[@"appver"] = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion = [[NSBundle mainBundle]
                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    argument[@"buildver"] = appVersion;
    argument[@"apiver"] = appVersion;
    NSString *os = [NSString stringWithFormat:@"iOS%.1f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    argument[@"os"] = os;
    
    NSString *idfa = [self idfaString];
    NSString *idfv = [self idfvString];
    
    argument[@"idfa"] = idfa;
    argument[@"idfv"] = idfv;
    
    NSDictionary *signDic = [self getSignArgument];
    [argument addEntriesFromDictionary:signDic];
    
    return argument;
}

- (NSMutableDictionary *)commonH5ArgumentWithUserParameters:(NSDictionary *)parameters{
    NSMutableDictionary *argument = nil;
    if (parameters) {
        argument = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }else{
        argument = @{}.mutableCopy;
    }
    argument[@"app_appver"] = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion = [[NSBundle mainBundle]
                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    argument[@"app_buildver"] = appVersion;
    NSDictionary *signDic = [self getH5SignArgument];
    [argument addEntriesFromDictionary:signDic];
    
    return argument;
}

#pragma mark - override
- (void)postMultipartFormWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
             multipartFormModels:(NSArray<NLMultipartFormArgument *> *)formModels
            requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock{
    
    NSURLSessionDataTask *sessionDataTask = nil;
    NSMutableDictionary *param = [self commonArgumentWithUserParameters:parameters];
    
    sessionDataTask = [[NWOperationManager sharedClient] requestURL:url parameters:param multipartFormConfigs:formModels progress:nil completeBlock:^(NSURLSessionTask *sessionTask, NLResultUnit *resultUnit) {
        NWResult *result = (NWResult *)resultUnit;
        [self reponseURI:url operationCompleteBlock:requestCompleteBlock result:result];
    }];
}

#pragma mark - override
- (void)requestWithUrl:(NSString *)url method:(HttpMethod)method parameters:(NSDictionary *)parameters completeBlock:(CompleteBlock)completeBlock{
    [self httpRequestMethod:method url:url parameters:parameters useCache:NO expiredTime:0 requestCompleteBlock:^(NWResult *result) {
        if (completeBlock) {
            completeBlock(result.response,result);
        }
    }];
}

- (void)httpRequestMethod:(HttpMethod)method
                      url:(NSString *)url
               parameters:(NSDictionary *)parameters
                 useCache:(BOOL)useCache
              expiredTime:(NSInteger)expiredTime
     requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock{
    [self httpRequestMethod:method url:url parameters:parameters useCache:useCache expiredTime:expiredTime supportOffLine:YES requestCompleteBlock:requestCompleteBlock];
}

/*!
 @brief 请求组合方法
 
 @param method               GET/POST/...
 @param url                  URL
 @param parameters           业务参数
 @param useCache             该接口是否使用接口限制请求缓存
 @param expiredTime          接口限制请求的时间，也是接口返回数据的缓存时间
 @param supportOffLine       该接口返回的数据是否支持离线缓存，如果支持离线缓存则在useCache接口限制请求缓存时间外(>expiredTime)，在无网络时依然可以返回上次请求成功的数据。
 @param requestCompleteBlock 数据返回的BLOCK
 
 @return 请求体NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)httpRequestMethod:(HttpMethod)method
                                        url:(NSString *)url
                                 parameters:(NSDictionary *)parameters
                                   useCache:(BOOL)useCache
                                expiredTime:(NSInteger)expiredTime
                             supportOffLine:(BOOL)supportOffLine
                       requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock{
    NSMutableDictionary *param = [self commonArgumentWithUserParameters:parameters];
    NSURLSessionDataTask *sessionDataTask = [[NWOperationManager sharedClient] requestURL:url inQueue:self.httpRequest_queue_t inGroup:self.httpRequest_group_t HttpMethod:method parameters:param cacheBodyWithBlock:^(id<NLCacheArgumentProtocol> cacheArgumentProtocol) {
        NLCacheArgumentOptions cacheArg = NLCacheArgumentIgnoreCache;
        if (useCache) {
            cacheArg = NLCacheArgumentRestrictedFrequentRequests;
        }
        if (supportOffLine) {
            cacheArg = cacheArg | NLCacheArgumentResponseAtErrorRequest;
        }
        [cacheArgumentProtocol cacheResponseWithCacheOptions:cacheArg cacheTimeInSeconds:expiredTime offlineTimeInSeconds:5*60*60];
    } completeBlock:^(NSURLSessionTask *sessionTask, NLResultUnit *resultUnit) {
        NWResult *result = (NWResult *)resultUnit;
        [self reponseURI:url operationCompleteBlock:requestCompleteBlock result:result];
//        DDLogInfo(@"%@:\n:%@\n:%@",url,param,result.response);
        NSLog(@"%@:\n:%@\n:%@",url,param,result.response);
    }];
    return sessionDataTask;
}

@end
