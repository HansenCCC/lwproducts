//
//  SVLabel.h
//  LYGoddess
//  label基类
//  Created by 程恒盛 on 2018/8/10.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVLabel : UILabel

/**
 快速初始化

 @param text 内容
 @param font 字体尺寸
 @param textColor 字体颜色
 @return self
 */
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

@end
