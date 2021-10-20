//
//  GFNavController.m
//  gamefiIOS
//
//  Created by harden on 2021/10/19.
//

#import "MWNavController.h"
#define kGKDefaultVisibility YES
#define IS_OS_OLDER_THAN_IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] <= 8.f
@interface MWNavController ()
@property (nonatomic,readonly) BOOL canPushOrPop;
@property (nonatomic,readonly) id navLock;
@property (nonatomic, assign) BOOL isMoving;
@end

@implementation MWNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak id weakSelf = self;
    self.interactivePopGestureRecognizer.delegate = weakSelf;
    self.delegate = weakSelf;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}
- (BOOL)prefersStatusBarHidden{

    UIViewController* topVC = self.topViewController;
    return [topVC prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}
// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

#pragma mark UINavigationController Overrides
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( self.canPushOrPop ) {
        [super pushViewController:viewController animated:animated];
    }
}

- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated {
    if ( self.canPushOrPop ) {
        return [super popToRootViewControllerAnimated:animated];
    }else {
        return @[];
    }
}

- (NSArray*)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( self.canPushOrPop ) {
        return [super popToViewController:viewController animated:animated];
    }else {
        return @[];
    }
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
}
#pragma mark getter
- (BOOL)canPushOrPop {
    id navLock = self.navLock;
    id topVC = self.topViewController;
    
    return ( (! navLock) || (navLock == topVC) );
}

- (id)navLock {
    return self.topViewController;
}

@end
