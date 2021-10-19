//
//  DataReqHelper.h
//  NoWait
//
//  Created by liu nian on 2016/10/20.
//  Copyright © 2016年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "MWDataUnit.h"
#import "NWOperationManager.h"

typedef void (^RequestCompleteBlock)(NWResult *result);
typedef void (^CompleteBlock)(id reponse, NWResult *result);
@interface DataReqHelper : MWDataUnit


- (void )reponseURI:(NSString *)uri
operationCompleteBlock:(RequestCompleteBlock)requestCompleteBlock
             result:(NWResult *)result;
- (NSMutableDictionary *)commonArgumentWithUserParameters:(NSDictionary *)parameters;
- (NSMutableDictionary *)commonH5ArgumentWithUserParameters:(NSDictionary *)parameters;

- (void)postMultipartFormWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
             multipartFormModels:(NSArray<NLMultipartFormArgument *> *)formModels
            requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock;

- (void)requestWithUrl:(NSString *)url
                method:(HttpMethod)method
            parameters:(NSDictionary *)parameters
         completeBlock:(CompleteBlock)completeBlock;

- (void)httpRequestMethod:(HttpMethod)method
                      url:(NSString *)url
               parameters:(NSDictionary *)parameters
                 useCache:(BOOL)useCache
              expiredTime:(NSInteger)expiredTime
     requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock;

- (NSURLSessionDataTask *)httpRequestMethod:(HttpMethod)method
                                        url:(NSString *)url
                                 parameters:(NSDictionary *)parameters
                                   useCache:(BOOL)useCache
                                expiredTime:(NSInteger)expiredTime
                             supportOffLine:(BOOL)supportOffLine
                       requestCompleteBlock:(RequestCompleteBlock)requestCompleteBlock;
@end
