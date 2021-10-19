//
//  NWOperationManager.h
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//


#import "MWHTTPUnit.h"
#import "NWResult.h"

@interface NWOperationManager : NLHttpSessionCacheUnit
+ (instancetype)sharedClient;
@end
