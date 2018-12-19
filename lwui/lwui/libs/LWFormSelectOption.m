//
//  LWFormSelectOption.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormSelectOption.h"

@implementation LWFormSelectOption
- (id)initWithKey:(NSObject *)key value:(NSString *)value userInfo:(id)userInfo{
    if(self=[super init]){
        self.key = key;
        self.value = value;
        self.userInfo = userInfo;
    }
    return self;
}
@end
