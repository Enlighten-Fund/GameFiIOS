//
//  BaseUIViewController.m
//  gamefiIOS
//
//  Created by harden on 2021/10/20.
//

#import "BaseUIViewController.h"

@interface BaseUIViewController ()

@end

@implementation BaseUIViewController

- (void)dealloc{
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [NWUtility colorWithHex:0xf0f0f0];
    [self controllerView];
    [self.view bringSubviewToFront:self.navigationBarView];
    [self configureTabBar];
    NSArray* tmp = self.navigationController.viewControllers;
    [self setHideBackItem:tmp.count > 1 ? NO : YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIRectEdge)edgesForExtendedLayout{
    return UIRectEdgeNone;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationFade;
}
#pragma mark - configure
- (void)configureTabBar{
    UIColor *tabRedColor = [UIColor colorWithRed:0.929f green:0.243f blue:0.259f alpha:1.00f];
    self.tabBarController.tabBar.tintColor = tabRedColor;
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)updateViewConstraints{

    CGFloat height = _hiddenNavBar ? 0 : 64;
    [self.navigationBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    [self.controllerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}
#pragma mark - private
- (void)setDefaultBackItem{
    [self setNavigationLeftItemWithTitle:@"" andImage:@"nav_back"];
}

- (void)setNavigationLeftItemWithTitle:(NSString*)title andImage:(NSString*)imageName{
    [self.btnLeftItem setTitle:title forState:UIControlStateNormal];
    [self.btnLeftItem setImage:ImageNamed(imageName) forState:UIControlStateNormal];
}

- (void)leftButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getter
- (UINavigationBar *)navigationBarView{
    if (!_navigationBarView) {
        MWNavigationBar *navigationBar = [[MWNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
        [navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor darkTextColor],  NSForegroundColorAttributeName,
                                               [UIFont  systemFontOfSize:18], NSFontAttributeName,
                                               nil]];
        UIColor *tabRedColor = [UIColor colorWithRed:0.929f green:0.243f blue:0.259f alpha:1.00f];
        navigationBar.tintColor = tabRedColor;
        [navigationBar pushNavigationItem:self.mwNavigationItem animated:NO];
        [self.view addSubview:navigationBar];
        navigationBar.bgColor = [UIColor colorWithRed:0.980f green:0.980f blue:0.980f alpha:1.0f];
        _navigationBarView = navigationBar;
        [_navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.height.equalTo(@64);
        }];
    }
    return _navigationBarView;
}

- (UINavigationItem *)mwNavigationItem{
    if (!_mwNavigationItem) {
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.title];
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnLeftItem];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = -10;
        _mwNavigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
        _mwNavigationItem = navigationItem;
    }
    return _mwNavigationItem;
}

- (UIView *)controllerView{
    if (!_controllerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationBarView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.navigationBarView.frame))];
        view.backgroundColor = [NWUtility colorWithHex:0xf0f0f0];
        [self.view addSubview:view];
        _controllerView = view;
        
        [_controllerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationBarView.mas_bottom).offset(0);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    return _controllerView;
}

- (UIButton*)btnLeftItem{
    if(!_btnLeftItem){
        _btnLeftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeftItem.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnLeftItem setTitleColor:[UIColor colorWithRed:0.867f green:0.110f blue:0.169f alpha:1.00f] forState:UIControlStateNormal];
        _btnLeftItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnLeftItem.frame = CGRectMake(0, 0, 60, 44);
        [_btnLeftItem setImage:ImageNamed(@"nav_back") forState:UIControlStateNormal];
        [_btnLeftItem addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.mwNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnLeftItem];
    }
    return _btnLeftItem;
}

//- (MWTabbarController *)tabbarController{
//    AppDelegate *appdelegate = APPDELEGATE;
//    return appdelegate.tabbarController;
//}
#pragma mark setter
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    self.mwNavigationItem.title = title;
}

- (void)setHiddenNavBar:(BOOL)hiddenNavBar{
    _hiddenNavBar = hiddenNavBar;
    self.navigationBarView.hidden = _hiddenNavBar;
    [self updateViewConstraints];
}

- (void)setHideBackItem:(BOOL)hideBackItem{
    _hideBackItem = hideBackItem;
    if(!hideBackItem){
        self.mwNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnLeftItem];
    }else{
        self.mwNavigationItem.leftBarButtonItem = nil;
    }
}
@end
