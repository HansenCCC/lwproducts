//
//  SVLabel.m
//  LYGoddess
//
//  Created by 程恒盛 on 2018/8/10.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "SVLabel.h"

@implementation SVLabel

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    SVLabel *label = [SVLabel new];
    [label qc_text:text textAlignment:0 font:font color:textColor];
    return  label;
}
- (void)qc_text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor *)color{
    if (text) { self.text = text;}
    if (font) {self.font = font;}
    if (color) {self.textColor = color;}
    if (textAlignment) {self.textAlignment = textAlignment;}
}

@end
