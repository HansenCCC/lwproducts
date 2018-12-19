//
//  LWFormDateElement.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormTextFieldElement.h"

@interface LWFormDateElement : LWFormTextFieldElement
@property(strong, nonatomic) NSDate *date;//选中的时间
@property(nonatomic, assign) UIDatePickerMode dateMode;//日期格式
@end
