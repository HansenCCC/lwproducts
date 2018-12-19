//
//  LWLabCreateTableViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/26.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabCreateTableViewController.h"
#import "LWLabInputListViewController.h"//输入框
#import "LWLabTransparentViewController.h"//transparent(中间镂空)
#import "LWLabExpressionViewController.h"//发射表情
#import "LWLabProgressHUDTableViewController.h"//提示框
#import "LWLabCarouselTableViewController.h"//轮播图
#import "LWLabSegmentedViewController.h"//仿凤凰新闻列表

@interface LWLabCreateTableViewController ()
@property(strong, nonatomic) LWFormElement *inputListTableViewCellModel;
@property (strong, nonatomic) LWFormElement *transparentTableViewCellModel;
@property (strong, nonatomic) LWFormElement *expressionTableViewCellModel;
@property (strong, nonatomic) LWFormElement *progressHUDTableViewCellModel;
@property (strong, nonatomic) LWFormElement *carouseTableViewCellModel;
@property (strong, nonatomic) LWFormElement *segmentedViewTableViewCellModel;
@end

@implementation LWLabCreateTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制试图";
}
- (void)reloadDatas{
    [self.model removeAllSections];
    [self.model addCellModel:self.inputListTableViewCellModel];
    [self.model addCellModel:self.transparentTableViewCellModel];
    [self.model addCellModel:self.expressionTableViewCellModel];
    [self.model addCellModel:self.progressHUDTableViewCellModel];
    [self.model addCellModel:self.carouseTableViewCellModel];
    [self.model addCellModel:self.segmentedViewTableViewCellModel];
    [self.model reloadTableViewData];
}
- (LWFormElement *)transparentTableViewCellModel{
    if (!_transparentTableViewCellModel) {
        @HV_WEAKIFY(self);
        _transparentTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"中间镂空"];
        _transparentTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabTransparentViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _transparentTableViewCellModel;
}
- (LWFormElement *)expressionTableViewCellModel{
    if (!_expressionTableViewCellModel) {
        @HV_WEAKIFY(self);
        _expressionTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"发射表情"];
        _expressionTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabExpressionViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _expressionTableViewCellModel;
}
- (LWFormElement *)progressHUDTableViewCellModel{
    if (!_progressHUDTableViewCellModel) {
        @HV_WEAKIFY(self);
        _progressHUDTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"提示框"];
        _progressHUDTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabProgressHUDTableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _progressHUDTableViewCellModel;
}
-(LWFormElement *)inputListTableViewCellModel{
    if (!_inputListTableViewCellModel) {
        @HV_WEAKIFY(self);
        _inputListTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"输入选择框"];
        _inputListTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabInputListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _inputListTableViewCellModel;
}
-(LWFormElement *)carouseTableViewCellModel{
    if (!_carouseTableViewCellModel) {
        @HV_WEAKIFY(self);
        _carouseTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"轮播图"];
        _carouseTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabCarouselTableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _carouseTableViewCellModel;
}
-(LWFormElement *)segmentedViewTableViewCellModel{
    if (!_segmentedViewTableViewCellModel) {
        @HV_WEAKIFY(self);
        _segmentedViewTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"仿凤凰新闻列表"];
        _segmentedViewTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabSegmentedViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _segmentedViewTableViewCellModel;
}
@end
