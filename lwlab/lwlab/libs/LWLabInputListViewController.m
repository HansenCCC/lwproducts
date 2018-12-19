//
//  LWLabInputListViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/19.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabInputListViewController.h"

@interface LWLabInputListViewController ()

@property(strong, nonatomic) LWFormTextFieldElement *textFieldElement;
@property(strong, nonatomic) LWFormDateElement *dateTimeElement;
@property(strong, nonatomic) LWFormDateElement *dateDateElement;
@property(strong, nonatomic) LWFormDateElement *dateDateAndTimeElement;
@property(strong, nonatomic) LWFormDateElement *dateCountDownTimerElement;
@property(strong, nonatomic) LWFormSelectOneElement *selectOneElement;
@property(strong, nonatomic) LWFormSelectOneElement *selectColorElement;
@property(strong, nonatomic) LWFormSelectOneElement *sexSelectionColorElement;

@end

@implementation LWLabInputListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"输入选择框";
    //
    if (@available(iOS 11.0, *)) {
    } else {
        // Fallback on earlier versions
        //iOS 11之前消除head多出空白
        self.tableView.tableHeaderView = UITableViewHeaderViewLWStuff;
    }
}
- (void)reloadDatas{
    [self.model removeAllSections];
    //code
//    [self.model addCellModel:self.textFieldElement];
    [self.model addCellModel:self.dateTimeElement];
    [self.model addCellModel:self.dateDateElement];
    [self.model addCellModel:self.dateDateAndTimeElement];
    [self.model addCellModel:self.dateCountDownTimerElement];
    [self.model addCellModel:self.selectOneElement];
    [self.model addCellModel:self.selectColorElement];
    [self.model addCellModel:self.sexSelectionColorElement];

    [self.model reloadTableViewData];
}
#pragma mark - cell
-(LWFormTextFieldElement *)textFieldElement{
    if (!_textFieldElement) {
        @HV_WEAKIFY(self);
        _textFieldElement = [[LWFormTextFieldElement alloc] initWithTitle:@"姓名"];
        _textFieldElement.placeholder = @"名称";
        _textFieldElement.text = @"程恒盛";
        _textFieldElement.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
        };
    }
    return _textFieldElement;
}
-(LWFormDateElement *)dateTimeElement{
    if (!_dateTimeElement) {
        _dateTimeElement = [[LWFormDateElement alloc] initWithTitle:@"Time"];
        _dateTimeElement.placeholder = @"HH:mm";
        _dateTimeElement.dateMode = UIDatePickerModeTime;
    }
    return _dateTimeElement;
}
-(LWFormDateElement *)dateDateElement{
    if (!_dateDateElement) {
        _dateDateElement = [[LWFormDateElement alloc] initWithTitle:@"Date"];
        _dateDateElement.placeholder = @"YYYY-MM-dd";
        _dateDateElement.dateMode = UIDatePickerModeDate;
    }
    return _dateDateElement;
}
-(LWFormDateElement *)dateDateAndTimeElement{
    if (!_dateDateAndTimeElement) {
        _dateDateAndTimeElement = [[LWFormDateElement alloc] initWithTitle:@"DateAndTime"];
        _dateDateAndTimeElement.placeholder = @"YYYY-MM-dd HH:mm";
        _dateDateAndTimeElement.dateMode = UIDatePickerModeDateAndTime;
    }
    return _dateDateAndTimeElement;
}
-(LWFormDateElement *)dateCountDownTimerElement{
    if (!_dateCountDownTimerElement) {
        _dateCountDownTimerElement = [[LWFormDateElement alloc] initWithTitle:@"CountDownTimer"];
        _dateCountDownTimerElement.placeholder = @"HH:mm";
        _dateCountDownTimerElement.dateMode = UIDatePickerModeCountDownTimer;
    }
    return _dateCountDownTimerElement;
}
-(LWFormSelectOneElement *)selectOneElement{
    if (!_selectOneElement) {
        _selectOneElement = [[LWFormSelectOneElement alloc] initWithTitle:@"单项选择"];
        for (NSString *fontName in [UIFont familyNames]) {
            [_selectOneElement addOption:fontName desc:fontName selected:NO];
        }
        _selectOneElement.placeholder = @"Font";
    }
    return _selectOneElement;
}
-(LWFormSelectOneElement *)selectColorElement{
    if (!_selectColorElement) {
        _selectColorElement = [[LWFormSelectOneElement alloc] initWithTitle:@"选择颜色"];
        _selectColorElement.cellClass = [LWFormSelectColorViewCell class];
        NSDictionary *colors = [UIColor commonColors];
        for (NSString *colorName in colors.allKeys) {
            [_selectColorElement addOption:colors[colorName] desc:colorName selected:NO];
        }
        _selectColorElement.placeholder = @"color";
    }
    return _selectColorElement;
}
-(LWFormSelectOneElement *)sexSelectionColorElement{
    if (!_sexSelectionColorElement) {
        _sexSelectionColorElement = [[LWFormSelectOneElement alloc] initWithTitle:@"性别选择"];
        for (NSString *name in @[@"男",@"女"]) {
            [_sexSelectionColorElement addOption:name desc:name selected:NO];
        }
        _sexSelectionColorElement.placeholder = @"性别";
    }
    return _sexSelectionColorElement;
}
@end
