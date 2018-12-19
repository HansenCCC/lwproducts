//
//  LWLabSegmentedCollectionViewCellModel.m
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSegmentedCollectionViewCellModel.h"
#import "LWLabSegmentedCollectionViewCell.h"

@implementation LWLabSegmentedCollectionViewCellModel
- (instancetype)init{
    if (self = [super init]) {
        self.cellClass = [LWLabSegmentedCollectionViewCell class];
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
