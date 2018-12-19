//
//  LWTextFieldAndImageView.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2018/8/19.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWTextFieldAndImageView.h"
#import "UIImage+LWUI.h"

@interface LWTextFieldAndImageView ()
@property (strong, nonatomic) HVUIFlowLayoutButton *leftBtn;
@property (strong, nonatomic) HVUIFlowLayoutButton *rightBtn;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation LWTextFieldAndImageView
- (instancetype)init{
    if (self = [super init]) {
        self.contentInsets = UIEdgeInsetsZero;
        //
        self.leftBtn = [[HVUIFlowLayoutButton alloc] init];
        self.leftBtn.userInteractionEnabled = NO;
        [self addSubview:self.leftBtn];
        //
        self.rightBtn = [[HVUIFlowLayoutButton alloc] init];
        self.rightBtn.userInteractionEnabled = NO;
        [self addSubview:self.rightBtn];
        //
        self.textField = [[UITextField alloc] init];
        [self addSubview:self.textField];
    }
    return self;
}
- (void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    [self.leftBtn setImage:leftImage forState:UIControlStateNormal];
}
- (void)setRightImage:(UIImage *)rightImage{
    _rightImage = rightImage;
    [self.rightBtn setImage:rightImage forState:UIControlStateNormal];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    //
    CGRect f1 = bounds;
    f1.size = CGSizeZero;
    if (self.leftImage) {
        f1.size = [self.leftImage sizeWithMaxRelativeSize:CGSizeMake(0, bounds.size.height - 10)];
    }
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    self.leftBtn.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeZero;
    if (self.rightBtn) {
        f2.size = [self.rightImage sizeWithMaxRelativeSize:CGSizeMake(0, bounds.size.height - 10)];
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
}
@end
