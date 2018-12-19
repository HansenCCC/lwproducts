//
//  LWFormImageElement.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormImageElement.h"
#import "LWFormImageViewCell.h"

@implementation LWFormImageElement
- (id)init{
    if (self=[super init]) {
        self.cellClass = [LWFormImageViewCell class];
    }
    return self;
}
- (id)initWithTitle:(NSString *)title image:(UIImage *)image{
    if (self = [self initWithTitle:title]) {
        self.image = image;
    }
    return self;
}
@end
