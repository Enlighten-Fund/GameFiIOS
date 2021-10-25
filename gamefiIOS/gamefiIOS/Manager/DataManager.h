//
//  DataManager.h
//  gamefiIOS
//
//  Created by harden on 2021/10/25.
//

#import "DataReqHelper.h"
#import "Singelton.h"


@interface DataManager : DataReqHelper
SingletonInterface(DataManager);
@end

