//
//  MWDataUnit.h
//  NoWait
//
//  Created by liu nian on 3/14/16.
//  Copyright © 2016 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**********************    接口版本    **********************/
extern NSString * const kJKVersion; // 接口版本
@interface MWDataUnit : NSObject
+ (instancetype)sharedInstance;
/**
 *  获取加密的参数
 *
 *  @return 参数构成的字典
 */
- (NSMutableDictionary *)getSignArgument;

/**
 *  h5获取加密的参数
 *
 *  @return 参数构成的字典
 */
- (NSMutableDictionary *)getH5SignArgument;

@end
