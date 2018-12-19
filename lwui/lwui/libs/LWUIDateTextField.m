//
//  LWUIDateTextField.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/19.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWUIDateTextField.h"

@interface LWUIDateTextField (){
    NSDate *__falseDate;
}
@property(nonatomic, strong) UIDatePicker *elementDatePicker;

@end
@implementation LWUIDateTextField
- (instancetype)init{
    if (self = [super init]) {
        self.inputView = self.elementDatePicker;
//        self.textColor = [UIColor lightGrayColor];
//        self.textAlignment = NSTextAlignmentRight;
        self.inputAccessoryView = [self datePickerInputAccessoryView];
        self.datePickerMode = UIDatePickerModeDate;
    }
    return self;
}
- (void)setDate:(NSDate *)date{
    _date = date;
    __falseDate = date;
    [self __updateDateTextFieldText];
}
- (void)__updateDateTextFieldText{
    if (!self.date) return;
    self.text = [self.date stringWithDateFormat:self.dateFormat];
}
- (void)__onDateChange:(UIDatePicker *)datePicker{
    self.text = [datePicker.date stringWithDateFormat:self.dateFormat];
    __falseDate = datePicker.date;
    if (self.whenValueChanged) {
        self.whenValueChanged(self.elementDatePicker, self.elementDatePicker.date);
    }
}
- (void)editCancel:(id)sender{
    [self resignFirstResponder];
    if (self.date) {
        self.elementDatePicker.date = self.date;
    }
    [self __updateDateTextFieldText];
    if (self.whenCancel) {
        self.whenCancel(self);
    }
}
- (void)editDone:(id)sender{
    [self resignFirstResponder];
    if (!__falseDate) {
        __falseDate = self.elementDatePicker.date;
    }
    self.date = __falseDate;
    if (self.whenDone) {
        self.whenDone(self);
    }
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode{
    _datePickerMode = datePickerMode;
    self.elementDatePicker.datePickerMode = datePickerMode;
    [self __updateDateTextFieldText];
}
#pragma mark - accessory
- (NSString *)dateFormat{
    NSString *dateFormat;
    switch (self.datePickerMode) {
        case UIDatePickerModeTime:
            dateFormat = @"HH:mm";
            break;
        case UIDatePickerModeDate:
            dateFormat = @"YYYY-MM-dd";
            break;
        case UIDatePickerModeDateAndTime:
            dateFormat = @"YYYY-MM-dd HH:mm";
            break;
        case UIDatePickerModeCountDownTimer:
            dateFormat = @"HH:mm";
            break;
        default:
            break;
    }
    return dateFormat;
}
- (UIDatePicker *)elementDatePicker{
    if (!_elementDatePicker) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _elementDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, size.width, 216.f)];
        _elementDatePicker.date = [NSDate date];
        //        UIDatePickerModeTime="上/下午 HH:mm"
        //        UIDatePickerModeDate="YYYY-MM-dd"
        //        UIDatePickerModeDateAndTime="MM-dd 上/下午 HH:mm"
        //        UIDatePickerModeCountDownTimer="HH:mm"
        [_elementDatePicker addTarget:self action:@selector(__onDateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _elementDatePicker;
}
- (UIView *)datePickerInputAccessoryView {
    UIToolbar *inputAccessoryView = [[UIToolbar alloc] init];
    inputAccessoryView.barStyle = UIBarStyleDefault;
    inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [inputAccessoryView sizeToFit];
    CGRect frame = inputAccessoryView.frame;
    frame.size.height = 44.0f;
    inputAccessoryView.frame = frame;
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(editCancel:)];
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editDone:)];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [NSArray arrayWithObjects:cancelBtn,flexibleSpaceLeft, doneBtn, nil];
    [inputAccessoryView setItems:array];
    return inputAccessoryView;
}
@end
