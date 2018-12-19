//
//  SVButton.m
//  LYGoddess
//
//  Created by 程恒盛 on 2018/8/10.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "SVButton.h"

@implementation SVButton

+ (instancetype)buttonWithType:(UIButtonType)type
                         title:(NSString *)title
                     titleFont:(UIFont *)titleFont
                    titleColor:(UIColor *)titleColor
                         state:(UIControlState)state {
    SVButton *btn = [SVButton buttonWithType:type];
    btn.titleLabel.font = titleFont;
    [btn setTitle:title forState:state];
    [btn setTitleColor:titleColor forState:state];
    return btn;
}
@end
