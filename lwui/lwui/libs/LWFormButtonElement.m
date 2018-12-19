//
//  LWFormButtonElement.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormButtonElement.h"
#import "LWFormButtonViewCell.h"
@implementation LWFormButtonElement
- (id)init{
    if (self=[super init]) {
        self.cellClass = [LWFormButtonViewCell class];
    }
    return self;
}
- (id)initWithTitle:(NSString *)title whenClick:(void(^)(LWFormButtonElement *element))whenClick{
    if (self=[self initWithTitle:title]) {
        if (whenClick) {
            self.whenClick = ^(HVTableViewCellModel *cellModel){
                whenClick((LWFormButtonElement *)cellModel);
            };
        }
    }
    return self;
}
@end
