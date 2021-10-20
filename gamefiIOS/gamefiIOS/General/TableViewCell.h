//
//  TableViewCell.h
//  gamefiIOS
//
//  Created by harden on 2021/10/20.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
static NSString *const kTableViewCell = @"kTableViewCell";

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *mwBackgroundView;
@property (nonatomic, strong) UIView *mwSelectedBackgroundView;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)makeConstraints;
- (void)updateCellWithModel:(id)model;

@end
