//
//  LWFormDateViewCell.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormDateViewCell.h"
#import "LWUIDateTextField.h"
#import "LWFormDateElement.h"

@interface LWFormDateViewCell ()<UITextFieldDelegate>
@property (strong, nonatomic) LWUIDateTextField *dateTextField;
@end

@implementation LWFormDateViewCell
- (LWUIDateTextField *)dateTextField{
    if (!_dateTextField) {
        _dateTextField = [[LWUIDateTextField alloc] init];
        _dateTextField.textAlignment = NSTextAlignmentRight;
        _dateTextField.delegate = self;
    }
    return _dateTextField;
}
- (LWUIDateTextField *)textField{
    return self.dateTextField;
}
-(void)setCustomCellModel:(LWFormElement *)customCellModel{
    [super setCustomCellModel:customCellModel];
    LWFormDateElement *dateElement = (LWFormDateElement *)customCellModel;
    //
    self.dateTextField.date = dateElement.date;
    self.dateTextField.datePickerMode = dateElement.dateMode;
}
@end
