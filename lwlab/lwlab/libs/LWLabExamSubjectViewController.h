//
//  LWLabExamSubjectViewController.h
//  lwlab
//  专业考试题目列表
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabViewController_Basic.h"

@interface LWLabExamSubjectViewController : LWUITableViewController
@property(strong, nonatomic) NSArray <NSString *>* examStrings;

- (void)reloadDatas;
@end
