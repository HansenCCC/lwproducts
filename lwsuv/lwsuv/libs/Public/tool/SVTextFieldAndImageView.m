//
//  SVTextFieldAndImageView.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2018/8/19.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "SVTextFieldAndImageView.h"

@interface SVTextFieldAndImageView ()
@property (strong, nonatomic) UIView *markView;

@end

@implementation SVTextFieldAndImageView
- (instancetype)init{
    if (self = [super init]) {
        self.markView = [[UIView alloc] init];
        self.markView.backgroundColor = SVColor_DDE7F0;
        [self addSubview:self.markView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    //
    CGRect f1 = bounds;
    f1.size = CGSizeZero;
    if (self.leftImage) {
        f1.size = [self.leftImage sizeWithMaxRelativeSize:CGSizeMake(0, AdaptedWidth(25.f))];
    }
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    self.leftBtn.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeZero;
    if (self.rightBtn) {
        f2.size = [self.rightImage sizeWithMaxRelativeSize:CGSizeMake(0, AdaptedWidth(25.f))];
    }
    f2.origin.y = (bounds.size.height - f2.size.height)/2;
    f2.origin.x = bounds.size.width - f2.size.width;
    self.rightBtn.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.x = CGRectGetMaxX(f1);
    f3.size.width = f2.origin.x - f3.origin.x;
    f3 = UIEdgeInsetsInsetRect(f3, self.contentInsets);
    self.textField.frame = f3;
    //
    CGRect f4 = bounds;
    f4.size.height = SVLineDefaultHight;
    f4.origin.y = bounds.size.height - f4.size.height;
    self.markView.frame = f4;
}
@end
