//
//  LWFormSelectOneViewCell.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormSelectOneViewCell.h"
#import "LWFormSelectOneElement.h"
#import "LWUISelectOneTextField.h"

@interface LWFormSelectOneViewCell ()<UITextFieldDelegate>
@property (strong, nonatomic) LWUISelectOneTextField *selectOneTextField;
@property(nonatomic,readonly) LWFormSelectOneElement *selectOneElement;
@end

@implementation LWFormSelectOneViewCell{
//    LWFormSelectOption *__selectOption;
}
-(UITextField *)textField{
    return self.selectOneTextField;
}
- (LWUISelectOneTextField *)selectOneTextField{
    if (!_selectOneTextField) {
        _selectOneTextField = [[LWUISelectOneTextField alloc] init];
        _selectOneTextField.textAlignment = NSTextAlignmentRight;
        _selectOneTextField.elementPickerView.delegate =self;
        _selectOneTextField.elementPickerView.dataSource = self;
        _selectOneTextField.delegate = self;
    }
    return _selectOneTextField;
}
- (void)_updateElementTextField{
    LWFormSelectOneElement *el = self.selectOneElement;
    self.textField.text = el.selectedOption?el.selectedOption.value:nil;
}
-(void)setCustomCellModel:(LWFormElement *)customCellModel{
    [super setCustomCellModel:customCellModel];
    self.selectOneTextField.textColor = [UIColor lightGrayColor];
    LWFormSelectOneElement *selectOneElement = (LWFormSelectOneElement *)customCellModel;
    @HV_WEAKIFY(self);
    self.selectOneTextField.whenCancel = ^(LWUISelectOneTextField *textField) {
        @HV_NORMALIZEANDNOTNIL(self);
        [self _updateElementTextField];
        [self _selectelementPickerViewRow];
        if (selectOneElement.whenCancel) {
            selectOneElement.whenCancel(selectOneElement);
        }
    };
    self.selectOneTextField.whenDone = ^(LWUISelectOneTextField *textField) {
        @HV_NORMALIZEANDNOTNIL(self);
        LWFormSelectOneElement *el = self.selectOneElement;
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[self.selectOneTextField.elementPickerView selectedRowInComponent:0] inSection:0];
        LWFormSelectOption *option = (LWFormSelectOption *)[el.optionModel cellModelAtIndexPath:indexpath];
        el.selectedOption = option;
        [self _updateElementTextField];
        [self endEditing:YES];
        if (el.whenDone) {
            el.whenDone(el);
        }
    };
    [self _updateElementTextField];
    [self _selectelementPickerViewRow];
}
- (void)_selectelementPickerViewRow{
    LWFormSelectOneElement *el = self.selectOneElement;
    LWFormSelectOption *option = el.selectedOption;
    if(el){
        NSIndexPath *indexpath = [el.optionModel indexPathOfCellModel:option];
        [self.selectOneTextField.elementPickerView selectRow:indexpath.row inComponent:indexpath.section animated:NO];
    }
}
- (LWFormSelectOneElement *)selectOneElement{
    if([self.customCellModel isKindOfClass:[LWFormSelectOneElement class]]){
        return (LWFormSelectOneElement *)self.customCellModel;
    }
    return nil;
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    HVCollectionSectionModel *section = [self.selectOneElement.optionModel sectionModelAtIndex:0];
    NSInteger row = [section numberOfCells];
    return row;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    HVCollectionSectionModel *section = [self.selectOneElement.optionModel sectionModelAtIndex:0];
    LWFormSelectOption *option = (LWFormSelectOption *)[section cellModelAtIndex:row];
    NSString *title = option.value;
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    HVCollectionSectionModel *section = [self.selectOneElement.optionModel sectionModelAtIndex:0];
    LWFormSelectOption *option = (LWFormSelectOption *)[section cellModelAtIndex:row];
    LWFormSelectOneElement *el = self.selectOneElement;
    if(el.whenChange){
        el.whenChange(el,option.key);
    }
}
@end
