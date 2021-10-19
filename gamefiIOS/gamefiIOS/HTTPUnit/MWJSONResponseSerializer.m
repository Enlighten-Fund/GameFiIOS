//
//  MWJSONResponseSerializer.m
//  NoWait
//
//  Created by liu nian on 3/23/16.
//  Copyright © 2016 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "MWJSONResponseSerializer.h"

NSString * const MWAFURLResponseSerializationErrorDomain = @"com.alamofire.error.serialization.response";
NSString * const MWAFNetworkingOperationFailingURLResponseErrorKey = @"com.alamofire.serialization.response.error.response";
NSString * const MWAFNetworkingOperationFailingURLResponseDataErrorKey = @"com.alamofire.serialization.response.error.data";

static NSError * MWAFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL MWAFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return MWAFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    
    return NO;
}

static id MWAFJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:MWAFJSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = MWAFJSONObjectByRemovingKeysWithNullValues(value, readingOptions);
            }
        }
        
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    
    return JSONObject;
}


@implementation MWJSONResponseSerializer
+ (instancetype)serializer {
    return [self serializerWithReadingOptions:(NSJSONReadingOptions)0];
}

+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions {
    MWJSONResponseSerializer *serializer = [[self alloc] init];
    serializer.readingOptions = readingOptions;
    
    return serializer;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    return self;
}

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    BOOL responseIsValid = YES;
    NSError *validationError = nil;
    
    if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
        if (self.acceptableContentTypes && ![self.acceptableContentTypes containsObject:[response MIMEType]]) {
            if ([data length] > 0 && [response URL]) {
                NSMutableDictionary *mutableUserInfo = [@{
                                                          NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: unacceptable content-type: %@", @"AFNetworking", nil), [response MIMEType]],
                                                          NSURLErrorFailingURLErrorKey:[response URL],
                                                          AFNetworkingOperationFailingURLResponseErrorKey: response,
                                                          } mutableCopy];
                if (data) {
                    mutableUserInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] = data;
                }
                
                validationError = MWAFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:mutableUserInfo], validationError);
            }
            
            responseIsValid = NO;
        }
        
        if (self.acceptableStatusCodes && ![self.acceptableStatusCodes containsIndex:(NSUInteger)response.statusCode] && [response URL]) {
            NSMutableDictionary *mutableUserInfo = [@{
                                                      NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: %@ (%ld)", @"AFNetworking", nil), [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode], (long)response.statusCode],
                                                      NSURLErrorFailingURLErrorKey:[response URL],
                                                      AFNetworkingOperationFailingURLResponseErrorKey: response,
                                                      } mutableCopy];
            
            if (data) {
                mutableUserInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] = data;
            }
            
            validationError = MWAFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorBadServerResponse userInfo:mutableUserInfo], validationError);
            
            responseIsValid = NO;
        }
    }
    
    if (error && !responseIsValid) {
        *error = validationError;
    }
    
    return responseIsValid;
}


#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || MWAFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    
    // Workaround for behavior of Rails to return a single space for `head :ok` (a workaround for a bug in Safari), which is not interpreted as valid input by NSJSONSerialization.
    // See https://github.com/rails/rails/issues/1742
//    NSStringEncoding stringEncoding = self.stringEncoding;
    NSStringEncoding stringEncoding = @"";
    if (response.textEncodingName) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    
    id responseObject = nil;
    NSError *serializationError = nil;
    @autoreleasepool {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:stringEncoding];
        if (responseString == nil) {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            responseString = [[NSString alloc] initWithData:data encoding:enc];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        }
        if (responseString && ![responseString isEqualToString:@" "]) {
            // Workaround for a bug in NSJSONSerialization when Unicode character escape codes are used instead of the actual character
            // See http://stackoverflow.com/a/12843465/157142
            data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            if (data) {
                if ([data length] > 0) {
//                    DDLogVerbose(@"%@",responseString);
//                    DDLogVerbose(@"%@",response.URL);
                    responseObject = [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:&serializationError];
                } else {
                    return nil;
                }
            } else {
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: NSLocalizedStringFromTable(@"Data failed decoding as a UTF-8 string", @"AFNetworking", nil),
                                           NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Could not decode string: %@", @"AFNetworking", nil), responseString]
                                           };
                
                serializationError = [NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
            }
        }
    }
    
    if (self.removesKeysWithNullValues && responseObject) {
        responseObject = MWAFJSONObjectByRemovingKeysWithNullValues(responseObject, self.readingOptions);
    }
    
    if (error) {
        *error = MWAFErrorWithUnderlyingError(serializationError, *error);
    }
    
    return responseObject;
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    
    self.readingOptions = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(readingOptions))] unsignedIntegerValue];
    self.removesKeysWithNullValues = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))] boolValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeObject:@(self.readingOptions) forKey:NSStringFromSelector(@selector(readingOptions))];
    [coder encodeObject:@(self.removesKeysWithNullValues) forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    MWJSONResponseSerializer *serializer = [[[self class] allocWithZone:zone] init];
    serializer.readingOptions = self.readingOptions;
    serializer.removesKeysWithNullValues = self.removesKeysWithNullValues;
    
    return serializer;
}

@end
