//
//  Singelton.h
//  NoWait
//
//  Created by liu nian on 15/3/30.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#ifndef NoWait_Singelton_h
#define NoWait_Singelton_h

//http://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/nsobject_Class/Reference/Reference.html#//apple_ref/occ/clm/NSObject/initialize

#define SingletonInterface(Class) \
+ (Class *)sharedInstance;


#define SingletonImplementation(Class) \
static Class *__ ## sharedSingleton; \
\
\
+ (void)initialize \
{ \
static BOOL initialized = NO; \
if(!initialized) \
{ \
initialized = YES; \
__ ## sharedSingleton = [[Class alloc] init]; \
} \
} \
\
\
+ (Class *)sharedInstance \
{ \
return __ ## sharedSingleton; \
} \
\

#endif

