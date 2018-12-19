//
//  LWFormTextFieldElement.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/19.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormTextFieldElement.h"
#import "LWFormTextFieldViewCell.h"

@implementation LWFormTextFieldElement
- (instancetype)init{
    if (self = [super init]) {
        self.cellClass = [LWFormTextFieldViewCell class];
    }
    return self;
}
-(NSString *)text{
    return self.name;
}
- (void)setText:(NSString *)text{
    self.name = text;
}
@end
