//
//  LWExamTableViewCellModel.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWExamTableViewCellModel.h"

@implementation LWExamTableViewCellModel
- (instancetype)initWithExamStrings:(NSArray <NSString *>*) strings name:(NSString *)name{
    if (self = [super initWithTitle:name]) {
        self.examStrings = strings;
    }
    return self;
}

@end
