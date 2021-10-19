//
//  GFNavigationBar.m
//  gamefiIOS
//
//  Created by harden on 2021/10/19.
//

#import "GFNavigationBar.h"
@interface GFNavigationBar ()
@property (nonatomic, strong) UIView *overlay;

@end
@implementation GFNavigationBar

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.bgColor = [UIColor colorWithRed:0.980f green:0.980f blue:0.980f alpha:0.5f];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - setter
- (void)setHiddenLine:(BOOL)hiddenLine{
    NSArray *list= self.subviews;
    if (hiddenLine) {
        
        self.shadowImage = [UIImage new];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
        imageView.image = [UIImage imageNamed:@"bg_able"];
        imageView.tag = 11120;
        [self addSubview:imageView];
        [self sendSubviewToBack:imageView];
    }else{
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                imageView.hidden = NO;
            }
        }
        UIImageView *imageView = [self viewWithTag:11120];
        [imageView removeFromSuperview];
        imageView = nil;
    }
}

#pragma mark - getter
- (UIView *)overlay{
    if (!_overlay) {
        _overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 64)];
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:_overlay atIndex:0];
    }
    return _overlay;
}

#pragma mark - setter
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.overlay.backgroundColor = bgColor;
}
@end
