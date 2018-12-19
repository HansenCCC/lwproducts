//
//  LWLabSDWebTableViewCellModel.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSDWebTableViewCellModel.h"
#import "LWLabSDWebTableViewCell.h"

@implementation LWLabSDWebTableViewCellModel
- (instancetype)init{
    if(self = [super init]){
        self.cellClass = [LWLabSDWebTableViewCell class];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title urlString:(NSString *)urlString{
    if (self = [self init]) {
        self.title = title;
        self.urlString = urlString;
    }
    return self;
}
@end
