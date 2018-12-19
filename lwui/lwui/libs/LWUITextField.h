//
//  LWUITextField.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUITextField : UITextField
typedef void(^LWUITextFieldTF)(LWUITextField *textField);
@property(copy,   nonatomic) LWUITextFieldTF whenDone;//
@property(copy,   nonatomic) LWUITextFieldTF whenCancel;//取消

- (void)updateTextField;
- (UIView *)textFieldinputAccessoryView;//添加工具栏
@end
