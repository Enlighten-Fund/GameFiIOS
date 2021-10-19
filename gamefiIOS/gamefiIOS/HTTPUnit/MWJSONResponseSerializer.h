//
//  MWJSONResponseSerializer.h
//  NoWait
//
//  Created by liu nian on 3/23/16.
//  Copyright © 2016 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MWJSONResponseSerializer : AFHTTPResponseSerializer

- (instancetype)init;

/**
 Options for reading the response JSON data and creating the Foundation objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONReadingOptions". `0` by default.
 */
@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

/**
 Whether to remove keys with `NSNull` values from response JSON. Defaults to `NO`.
 */
@property (nonatomic, assign) BOOL removesKeysWithNullValues;

/**
 Creates and returns a JSON serializer with specified reading and writing options.
 
 @param readingOptions The specified JSON reading options.
 */
+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions;
@end
