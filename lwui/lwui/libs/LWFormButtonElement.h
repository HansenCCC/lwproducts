//
//  LWFormButtonElement.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormElement.h"

@interface LWFormButtonElement : LWFormElement

/**
 button单元格

 @param title 标题
 @param whenClick 点击动作
 @return cell
 */
- (id)initWithTitle:(NSString *)title whenClick:(void(^)(LWFormButtonElement *element))whenClick;
@end
