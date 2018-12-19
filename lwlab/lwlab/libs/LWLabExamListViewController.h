//
//  LWLabExamListViewController.h
//  lwlab
//  专业考试列表
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabViewController_Basic.h"

@interface LWLabExamListViewController : LWUITableViewController

@end

@interface NSArray (Exam)

/**
 解析英语专业考试文档
        根据‘\n‘提取各个字符串
 @param fileName 放在目录下面的文件
 @return @[]
 */
+ (NSArray <NSString *>*)arrayWithStringByExamJson:(NSString *)fileName;
@end
