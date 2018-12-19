//
//  LWFormButtonViewCell.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormButtonViewCell.h"

@implementation LWFormButtonViewCell
+ (UIEdgeInsets)contentInsets{
    return UIEdgeInsetsMake(5, 15, 5, 15);
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitleColor:[UIColor colorWithRed:0 green:0.5 blue:1 alpha:1] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(_buttonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
        self.textLabel.hidden = YES;
        self.imageView.hidden = YES;
        self.commonButton.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    UIEdgeInsets contentInsets= [self.class contentInsets];
    CGRect f1 = UIEdgeInsetsInsetRect(bounds, contentInsets);
    self.button.frame = f1;
}
-(void)setCustomCellModel:(LWFormElement *)customCellModel{
    [super setCustomCellModel:customCellModel];
    [self.button setTitle:self.customCellModel.title forState:UIControlStateNormal];
    [self setNeedsLayout];
}
- (void)_buttonDidTap:(id)sender{
    LWFormElement *el = self.customCellModel;
    if (el.whenClick) {
        el.whenClick(el);
    }
}
@end
