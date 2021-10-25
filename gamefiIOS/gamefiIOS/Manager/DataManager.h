//
//  DataManager.h
//  gamefiIOS
//
//  Created by harden on 2021/10/25.
//

#import "DataReqHelper.h"
#import "Singelton.h"
#import "APIConstants.h"

@interface DataManager : DataReqHelper
SingletonInterface(DataManager);
/**
 *  测试
 *
 *  @param completeBlock 回调
 */
- (void)fetchExampleCompleteBlock:(CompleteBlock)completeBlock;
@end

