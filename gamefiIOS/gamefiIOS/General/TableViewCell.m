//
//  TableViewCell.m
//  gamefiIOS
//
//  Created by harden on 2021/10/20.
//

#import "TableViewCell.h"
@interface TableViewCell ()

@end

@implementation TableViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self mwBackgroundView];
        [self mwSelectedBackgroundView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self mwBackgroundView];
        [self mwSelectedBackgroundView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark overide
- (void)makeConstraints{
    //overide
}

- (void)updateCellWithModel:(id)model{}


#pragma mark - getter
- (UIView *)mwBackgroundView{
    if (!_mwBackgroundView) {
        _mwBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _mwBackgroundView.backgroundColor = [UIColor whiteColor];
        _mwBackgroundView.clipsToBounds = YES;
        self.backgroundView = _mwBackgroundView;
    }
    return _mwBackgroundView;
}

- (UIView *)mwSelectedBackgroundView{
    if (!_mwSelectedBackgroundView) {
        _mwSelectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _mwSelectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.973f green:0.973f blue:0.973f alpha:1.00f];
        _mwSelectedBackgroundView.clipsToBounds = YES;
        
        self.selectedBackgroundView = _mwSelectedBackgroundView;
    }
    return _mwSelectedBackgroundView;
}
@end
