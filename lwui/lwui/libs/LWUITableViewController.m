//
//  LWUITableViewController.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/26.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWUITableViewController.h"
#import "LWFormElement.h"

@interface LWUITableViewController ()

@end

@implementation LWUITableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;//可修改tableview样式
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
    } else {
        // Fallback on earlier versions
        //iOS 11之前消除head多出空白
        self.tableView.tableHeaderView = UITableViewHeaderViewLWStuff;
    }
    [self reloadDatas];
}
- (HVTableViewModel *)model{
    if (!_model) {
        _model = [[HVTableViewModel alloc] initWithTableView:self.tableView];
    }
    return _model;
}
- (void)reloadDatas{
    
}
@end
