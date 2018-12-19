//
//  LWFormDateElement.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormDateElement.h"
#import "LWFormDateViewCell.h"

@implementation LWFormDateElement
- (instancetype)init{
    if (self = [super init]) {
        self.cellClass = [LWFormDateViewCell class];
    }
    return self;
}

@end
