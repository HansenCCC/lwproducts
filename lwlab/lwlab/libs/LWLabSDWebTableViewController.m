//
//  LWLabSDWebTableViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSDWebTableViewController.h"
#import "LWLabSDWebTableViewCellModel.h"
#import "LWLabSDWebImageApiMessage.h"

@interface LWLabSDWebTableViewController ()
@property (strong, nonatomic) NSArray *datas;
@end

@implementation LWLabSDWebTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDWebImage(加载网络图片)";
    //
    [self requestDatas];
}
- (void)reloadDatas{
    [super reloadDatas];
    [self.model removeAllSections];
    for (LWLabSDWebImageModel *m in self.datas) {
        LWLabSDWebTableViewCellModel *cm = [[LWLabSDWebTableViewCellModel alloc] initWithTitle:m.title urlString:m.thumbnail];
        [self.model addCellModel:cm];
    }
    [self.model reloadTableViewData];
}
- (void)requestDatas{
    LWLabSDWebImageApiMessage *api = [[LWLabSDWebImageApiMessage alloc] init];
    @HV_WEAKIFY(self);
    api.whenSucceed = ^(__kindof LWLabSDWebImageApiMessage *msg) {
        @HV_NORMALIZEANDNOTNIL(self);
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in msg.result[@"body"][@"item"]) {
            LWLabSDWebImageModel *m = [[LWLabSDWebImageModel alloc] initWithDic:dic];
            [items addObject:m];
        }
        self.datas = [items copy];
        [self reloadDatas];
    };
    [api send];
}
@end
