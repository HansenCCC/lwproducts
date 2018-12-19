//
//  LWUISelectOneTextField.h
//  lwui
//  单项选择textfield
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUISelectOneTextField : UITextField
@property(nonatomic,strong) UIPickerView *elementPickerView;//选择视图

typedef void(^LWUISelectOneTextFieldTP)(LWUISelectOneTextField *textField);
@property(copy,   nonatomic) LWUISelectOneTextFieldTP whenDone;//
@property(copy,   nonatomic) LWUISelectOneTextFieldTP whenCancel;//取消
@end
