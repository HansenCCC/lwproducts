//
//  LWTitleTableViewCellModel.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWTitleTableViewCellModel.h"
#import "LWTitleTableViewCell.h"

@implementation LWTitleTableViewCellModel
- (instancetype)init{
    if(self = [super init]){
        self.cellClass = [LWTitleTableViewCell class];
    }
    return self;
}
@end
