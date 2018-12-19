//
//  LWUITextField.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWUITextField.h"

@implementation LWUITextField
- (instancetype)init{
    if(self = [super init]){
        //默认不添加
//        self.inputAccessoryView = [self textFieldinputAccessoryView];
    }
    return self;
}
- (UIView *)textFieldinputAccessoryView{
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
- (void)updateTextField{
}
- (void)editCancel:(id)sender{
    [self resignFirstResponder];
    [self updateTextField];
    if (self.whenCancel) {
        self.whenCancel(self);
    }
}
- (void)editDone:(id)sender{
    [self resignFirstResponder];
    [self updateTextField];
    if (self.whenDone) {
        self.whenDone(self);
    }
}
@end
