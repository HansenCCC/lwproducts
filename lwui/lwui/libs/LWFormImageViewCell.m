//
//  LWFormImageViewCell.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormImageViewCell.h"
#import "LWFormImageElement.h"
#import "UIView+LWUI.h"
@implementation LWFormImageViewCell
DEF_SINGLETON(LWFormImageViewCell);
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.elementImageView = [[UIImageView alloc] init];
        self.elementImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.elementImageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.commonButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    UIEdgeInsets insets = [self.class contentMarginInsets];
    //
    CGRect f1 = self.commonButton.frame;
    CGRect f2 = UIEdgeInsetsInsetRect(bounds, insets);
    f2.size = [self.elementImageView sizeThatFitsToMaxSize:CGSizeMake(f2.size.width - f1.size.width, 0)];
    f2.origin.x = bounds.size.width - f2.size.width - insets.right;
    f2.origin.y = (bounds.size.height - f2.size.height)/2;
    self.elementImageView.frame = f2;
}
-(void)setCustomCellModel:(LWFormElement *)customCellModel{
    [super setCustomCellModel:customCellModel];
    if ([customCellModel isKindOfClass:[LWFormImageElement class]]) {
        LWFormImageElement *element = (LWFormImageElement *)customCellModel;
        self.elementImageView.image = element.image;
    }
    //
    [self setNeedsLayout];
}
+ (CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
    CGFloat height = [self dynamicHeightWithTableView:tableView cellModel:cellModel cellShareInstance:[self sharedInstance] calBlock:^CGFloat(UITableView *tableView, HVTableViewCellModel *cellModel, id cell) {
        LWFormImageViewCell *_cell = cell;
        return  _cell.elementImageView.frame.size.height + self.contentMarginInsets.bottom + self.contentMarginInsets.top;
    }];
    return MAX(height, kLWFormViewCellDefaultHeight);
}
@end
