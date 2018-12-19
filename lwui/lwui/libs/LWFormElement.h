//
//  LWFormElement.h
//  lwlab
//  普遍的cellmodel
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFormElement : HVTableViewCellModel
@property(strong, nonatomic) NSString       *title;//左边标题
@property(strong, nonatomic) NSString       *detail;//描述
@property(strong, nonatomic) UIImage        *icon;
@property(strong, nonatomic) NSString       *name;//右边标题
@property(nonatomic, strong) id             value;//值對象

typedef void(^LWFormElementFE)(__kindof LWFormElement *el);
typedef void(^LWFormElementFEV)(__kindof LWFormElement *el,id value);
@property(nonatomic,copy) LWFormElementFE whenDone;//
@property(nonatomic,copy) LWFormElementFE whenCancel;//
@property(nonatomic,copy) LWFormElementFEV whenChange;//value改變時執行的action

@property(nonatomic,readonly) NSString      *valueString;//返回value对应的字符串
- (instancetype)initWithTitle:(NSString *)title;
@end
