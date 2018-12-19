//
//  LWLabUPApiMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabUPApiMessage.h"

@implementation LWLabUPApiMessage
- (void)routine{
    [super routine];
    if (self.sending) {
        //无服务器调试
        _error = [NSError errorWithMessageCode:400 errorMsg:@"无服务器调试"];
        self.failed = YES;
    }else if(self.succeed){
    }else if(self.failed){
    }else if(self.waiting){
    }
}
@end
