//
//  ViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/14.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabRootViewController.h"
#import "LWTitleTableViewCellModel.h"

#import "LWLabStudioViewController.h"//工作台
#import "LWLabAppIconViewController.h"//图标制作
#import "LWLabExamListViewController.h"//英语考试
#import "LWLabCreateTableViewController.h"//自定制UIView
#import "LWLabAPITableViewController.h"//api网络层
#import "LWLabSDWebTableViewController.h"//SDWebImage网络图片

@interface LWLabRootViewController ()
@property(strong, nonatomic) LWFormElement *studioTableViewCellModel;
@property(strong, nonatomic) LWFormElement *appIconTableViewCellModel;
@property(strong, nonatomic) LWFormElement *examListTableViewCellModel;
@property(strong, nonatomic) LWFormElement *createTableViewCellModel;
@property(strong, nonatomic) LWFormElement *apiTableViewCellModel;
@property(strong, nonatomic) LWFormElement *imageTableViewCellModel;
@end

@implementation LWLabRootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LWLab";
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
    //
    [self.model addCellModel:self.studioTableViewCellModel];
    [self.model addCellModel:self.examListTableViewCellModel];
    [self.model addCellModel:self.appIconTableViewCellModel];
    [self.model addCellModel:self.imageTableViewCellModel];
    [self.model addCellModel:self.apiTableViewCellModel];
    [self.model addCellModel:self.createTableViewCellModel];
    //
    [self.model reloadTableViewData];
    
}
#pragma mark - cell
-(LWFormElement *)studioTableViewCellModel{
    if (!_studioTableViewCellModel) {
        @HV_WEAKIFY(self);
        _studioTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"工作台"];
        _studioTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabStudioViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _studioTableViewCellModel;
}
-(LWFormElement *)appIconTableViewCellModel{
    if (!_appIconTableViewCellModel) {
        @HV_WEAKIFY(self);
        _appIconTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"图标制作"];
        _appIconTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabAppIconViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _appIconTableViewCellModel;
}
-(LWFormElement *)examListTableViewCellModel{
    if (!_examListTableViewCellModel) {
        @HV_WEAKIFY(self);
        _examListTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"英语专业考试"];
        _examListTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabExamListViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _examListTableViewCellModel;
}
-(LWFormElement *)createTableViewCellModel{
    if (!_createTableViewCellModel) {
        @HV_WEAKIFY(self);
        _createTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"快速开发自定制试图"];
        _createTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabCreateTableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _createTableViewCellModel;
}
-(LWFormElement *)apiTableViewCellModel{
    if (!_apiTableViewCellModel) {
        @HV_WEAKIFY(self);
        _apiTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"API网络层"];
        _apiTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabAPITableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _apiTableViewCellModel;
}
-(LWFormElement *)imageTableViewCellModel{
    if (!_imageTableViewCellModel) {
        @HV_WEAKIFY(self);
        _imageTableViewCellModel = [[LWFormElement alloc] initWithTitle:@"SDWebImage网络图片"];
        _imageTableViewCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIViewController *controller = [[LWLabSDWebTableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        };
    }
    return _imageTableViewCellModel;
}
@end
