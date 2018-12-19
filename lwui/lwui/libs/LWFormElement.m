//
//  LWFormElement.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWFormElement.h"
#import "LWFormViewCell.h"

@implementation LWFormElement
- (instancetype)init{
    if(self = [super init]){
        self.cellClass = [LWFormViewCell class];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title{
    if (self = [self init]) {
        self.title = title;
    }
    return self;
}
@end
