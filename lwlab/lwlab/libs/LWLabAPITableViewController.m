//
//  LWLabAPITableViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabAPITableViewController.h"
#import "LWLabGETApiMessage.h"
#import "LWLabPOSTApiMessage.h"
#import "LWLabDOWNApiMessage.h"
#import "LWLabUPApiMessage.h"

@interface LWLabAPITableViewController ()
@end

@implementation LWLabAPITableViewController
DEF_LWFastGetFormElement(getMethodElement, @"GET", ^(void){
    LWLabApiMessage *api = [[LWLabGETApiMessage alloc] init];
    [api send];
});
DEF_LWFastGetFormElement(postMethodElement, @"POST", ^(void){
    LWLabApiMessage *api = [[LWLabPOSTApiMessage alloc] init];
    [api send];
});
DEF_LWFastGetFormElement(downloadMethodElement, @"DOWNLOAD", ^(void){
    LWLabApiMessage *api = [[LWLabDOWNApiMessage alloc] init];
    [api send];
});
DEF_LWFastGetFormElement(uploadMethodElement, @"UPLOAD", ^(void){
    LWLabApiMessage *api = [[LWLabUPApiMessage alloc] init];
    [api send];
});
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"API网络层调试";
}
- (void)reloadDatas{
    [self.model removeAllSections];
    [self.model addCellModel:self.getMethodElement];
    [self.model addCellModel:self.postMethodElement];
    [self.model addCellModel:self.downloadMethodElement];
    [self.model addCellModel:self.uploadMethodElement];
    [self.model reloadTableViewData];
}
@end
