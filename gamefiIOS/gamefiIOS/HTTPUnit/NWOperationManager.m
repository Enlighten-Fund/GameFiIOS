//
//  NWOperationManager.m
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "NWOperationManager.h"
#import "MWJSONResponseSerializer.h"
#import <sys/utsname.h>
//#import "APIConstants.h"
#import "JSONKit.h"

#define kCustomErrorDomain @"cn.9now.api"

/**
 *  SSL 证书名称，仅支持cer格式.
 */
#define certificate @"https"

NSTimeInterval tenTimeoutInterval = 10;

@interface NWOperationManager ()
@property (nonatomic, strong) OperationCompleteBlock completeBlock;
@property (nonatomic, strong) dispatch_queue_t httpRequest_queue_t;
@property (nonatomic, strong) dispatch_group_t httpRequest_group_t;
@property (nonatomic, strong) NSCachedURLResponse *cacheResponse;

@end

@implementation NWOperationManager

+ (instancetype)sharedClient {
    static NWOperationManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *host = @"http://a2a7cb64ab5d94072bc625bdedd3f7ff-1574935958.ap-northeast-1.elb.amazonaws.com/v2/";
        _sharedClient = [[NWOperationManager alloc] initWithBaseURL:[NSURL URLWithString:host]];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:[NSString stringWithFormat:@"%@", [[NSLocale preferredLanguages] componentsJoinedByString:@", "]]
                 forHTTPHeaderField:@"Accept-Language"];
        [requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [requestSerializer setTimeoutInterval:tenTimeoutInterval];
        MWJSONResponseSerializer *responseSerializer = [MWJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        _sharedClient.requestSerializer = requestSerializer;
        _sharedClient.responseSerializer = responseSerializer;
        
#pragma mark - SSL
//        if (openHttpsSSL && !isTestState) {
//            //https ssl 验证。
//            [_sharedClient setSecurityPolicy:[_sharedClient customSecurityPolicy]];
//        }
        //设定自定义userAgent
        NSString *userAgent = [_sharedClient customUserAgent];
        if (userAgent && ![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
            [_sharedClient.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        }
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - override
- (NLResultUnit *)resultUnitOperationCallbackWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[NSError class]]) {
        NSError *error = (NSError*)responseObject;
        return [NWResult resultWithNSError:error];
    }else if ([responseObject isKindOfClass:[NSDictionary class]]){
        NSDictionary *jsonDict = (NSDictionary *)responseObject;
        if (jsonDict != nil && [jsonDict isKindOfClass:[NSDictionary class]] && jsonDict.count > 0 ) {
            return [NWResult resultWithAttributes:jsonDict];
        }
    }
    return [NWResult resultWithCode:HttpResponseCodeUnkonwError message:@"请求错误"];
}
- (NSArray *)parametersToBeFiltered{
    return @[@"nonce", @"sign", @"time", @"Lat", @"Lng",@"latitude",@"longitude"];
}

#pragma mark - getter

//- (AFSecurityPolicy*)customSecurityPolicy{
//    
//    AFSecurityPolicy *securityPolicy = nil;
//    //线上环境使用HTTPS证书
//    if (!isTestState){
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
//        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//        // AFSSLPinningModeCertificate 使用证书验证模式
//        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//        NSSet *certSet = [[NSSet alloc] initWithObjects:certData, nil];
//        securityPolicy.pinnedCertificates = certSet;
//        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//        securityPolicy.allowInvalidCertificates = YES;
//        //validatesDomainName 是否需要验证域名，默认为YES；
//        securityPolicy.validatesDomainName = NO;
//    }
//    return securityPolicy;
//}

+ (NSString*)getCurrentDeviceModel{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3G WIFI (A1599)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

- (NSString *)customUserAgent{
    NSString *userAgent = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
#if TARGET_OS_IOS
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey] ,[[self class] getCurrentDeviceModel], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
#elif TARGET_OS_WATCH
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; watchOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[WKInterfaceDevice currentDevice] model], [[WKInterfaceDevice currentDevice] systemVersion], [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
#pragma clang diagnostic pop
    return userAgent;
}
@end
