//
//  DataManager.m
//  gamefiIOS
//
//  Created by harden on 2021/10/25.
//

#import "DataManager.h"

@implementation DataManager
SingletonImplementation(DataManager);
- (void)fetchExampleCompleteBlock:(CompleteBlock)completeBlock{
    NSMutableDictionary *params = @{}.mutableCopy;
    
    [self requestWithUrl:kexample method:HttpMethodPost parameters:params completeBlock:^(id reponse, NWResult *result) {
        
        NSDictionary *data = result.response[@"data"];
        if (result.success ) {
            NSError *error = nil;
           
        }
        
        if (completeBlock) {
            
        }
    }];
    
}
@end
