//
//  SVButton.h
//  LYGoddess
//  button基类
//  Created by 程恒盛 on 2018/8/10.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <lwui/lwui.h>

@interface SVButton : HVUIFlowLayoutButton

/**
 快速初始化

 @param type 类型
 @param title 标题
 @param titleFont 字体大小
 @param titleColor 字体颜色
 @param state 状态
 @return self
 */
+ (instancetype)buttonWithType:(UIButtonType)type
                       title:(NSString *)title
                   titleFont:(UIFont *)titleFont
                  titleColor:(UIColor *)titleColor
                       state:(UIControlState)state;
@end
