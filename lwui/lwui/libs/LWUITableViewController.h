//
//  LWUITableViewController.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/26.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUITableViewController : UITableViewController
@property(nonatomic, strong) HVTableViewModel *model;

- (void)reloadDatas;
@end
