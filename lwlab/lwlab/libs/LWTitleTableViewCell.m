//
//  LWTitleTableViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWTitleTableViewCell.h"

@interface LWTitleTableViewCell ()
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UIView *separatorView;
@end

@implementation LWTitleTableViewCell
DEF_SINGLETON(LWTitleTableViewCell);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 8);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        //
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.separatorView];
    }
    return self;
}
#pragma mark- model
DEF_HVTableViewCellModel(LWTitleTableViewCellModel, customCellModel);
- (void)setCustomCellModel:(LWTitleTableViewCellModel *)customCellModel{
    _customCellModel = customCellModel;
    //
    self.titleLabel.text = customCellModel.title;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark- layout
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    
    CGRect f1 = bounds;
    f1.origin = CGPointLWMargin;
    CGFloat widthSpace = bounds.size.width - 2 * f1.origin.x;
    f1.size = [self.titleLabel sizeThatFits:CGSizeMake(widthSpace, 0)];
    self.titleLabel.frame = f1;
    //
    CGRect f2 = UIEdgeInsetsInsetRect(bounds, self.separatorInset);
    f2.size.height = 1.0f;
    f2.origin.y = CGRectGetMaxY(f1) + f1.origin.y - f2.size.height;
    self.separatorView.frame =f2;
}
+(CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
    CGFloat height = [LWTitleTableViewCell dynamicHeightWithTableView:tableView cellModel:cellModel cellShareInstance:[self.class sharedInstance] calBlock:^CGFloat(UITableView *tableView, HVTableViewCellModel *cellModel, id cell) {
        LWTitleTableViewCell *_cell = cell;
        CGFloat height = CGRectGetMaxY(_cell.separatorView.frame);
        height = MAX(height, 45.f);
        return height;
    }];
    return height;
}
@end
