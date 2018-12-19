//
//  LWLabExamSubjectViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabExamSubjectViewController.h"
#import "LWLabExamSearchViewController.h"

@interface LWLabExamSubjectViewController ()<UISearchBarDelegate>
@end

@implementation LWLabExamSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    @HV_WEAKIFY(self);
    for (NSString *title in self.examStrings) {
        LWFormElement *cm = [[LWFormElement alloc] initWithTitle:title];
        cm.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            LWFormElement *_cellModel = (LWFormElement *)cellModel;
            [self showTipWithTitle:nil detail:_cellModel.title animated:YES];
            [self.view.progressHUD addHideGesture];
        };
        [self.model addCellModel:cm];
    }
    [self.model reloadTableViewData];
}
@end
