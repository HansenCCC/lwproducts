//
//  LWUIDateTextField.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/19.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUIDateTextField : UITextField
//UIDatePickerModeTime="HH:mm"
//UIDatePickerModeDate="YYYY-MM-dd"
//UIDatePickerModeDateAndTime="YYYY-MM-dd HH:mm:ss"
//UIDatePickerModeCountDownTimer="HH:mm"
@property(readonly, nonatomic) NSString *dateFormat;
@property(readonly, nonatomic) UIDatePicker *elementDatePicker;//DatePicker
@property(readonly, nonatomic) UIView *datePickerInputAccessoryView;//datePicker输入附件

@property(nonatomic, strong) NSDate *date;
@property(nonatomic, assign) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

typedef void(^LWUIDateTextFieldTB)(LWUIDateTextField *textField);
typedef void(^LWUIDateTextFieldVC)(UIDatePicker *elementDatePicker, NSDate *date);
@property(copy,   nonatomic) LWUIDateTextFieldTB whenDone;//
@property(copy,   nonatomic) LWUIDateTextFieldTB whenCancel;//取消
@property(copy,   nonatomic) LWUIDateTextFieldVC whenValueChanged;//dateText值改变

@end
