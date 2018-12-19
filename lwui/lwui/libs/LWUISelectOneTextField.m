//
//  LWUISelectOneTextField.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWUISelectOneTextField.h"

@interface LWUISelectOneTextField ()

@end

@implementation LWUISelectOneTextField
- (instancetype)init{
    if (self = [super init]) {
        UIScreen *mainSreen = [UIScreen mainScreen];
        CGSize screenSize = mainSreen.bounds.size;
        self.elementPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 216)];
        self.elementPickerView.showsSelectionIndicator = YES;
        
        self.inputView = self.elementPickerView;
        self.inputAccessoryView = [self textFieldinputAccessoryView];
    }
    return self;
}
- (UIView *)textFieldinputAccessoryView {
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
- (void)__updateSelectOneTextFieldText{
    
}
- (void)editCancel:(id)sender{
    [self endEditing:YES];
    [self __updateSelectOneTextFieldText];
    if (self.whenCancel) {
        self.whenCancel(self);
    }
}
- (void)editDone:(id)sender{
    [self endEditing:YES];
    [self __updateSelectOneTextFieldText];
    if (self.whenDone) {
        self.whenDone(self);
    }
}
@end
