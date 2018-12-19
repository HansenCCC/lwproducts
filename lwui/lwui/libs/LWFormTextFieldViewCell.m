//
//  LWFormTextFieldViewCell.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/19.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormTextFieldViewCell.h"
#import "LWFormTextFieldElement.h"

@interface LWFormTextFieldViewCell ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *textField;
@end

@implementation LWFormTextFieldViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textField];
    }
    return self;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.delegate = self;
    }
    return _textField;
}
- (void)setCustomCellModel:(LWFormElement *)customCellModel{
    [super setCustomCellModel:customCellModel];
    
    if ([customCellModel isKindOfClass:[LWFormTextFieldElement class]]) {
        LWFormTextFieldElement *tfModel = (LWFormTextFieldElement *)customCellModel;
        self.textField.placeholder = tfModel.placeholder;
    }
    self.textField.text = customCellModel.name;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = CGRectGetMaxX(self.commonButton.frame) + self.contentMarginInsets.left;
    f1.size.width = bounds.size.width - f1.origin.x - self.contentMarginInsets.right;
    self.textField.frame = f1;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//return隐藏键盘
    self.customCellModel.name = textField.text;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.customCellModel.name = textField.text;
}
@end
