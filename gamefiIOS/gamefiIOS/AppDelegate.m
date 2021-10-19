//
//  AppDelegate.m
//  gamefiIOS
//
//  Created by harden on 2021/10/19.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}




- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}
@end
