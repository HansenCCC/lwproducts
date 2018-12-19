//
//  LWLabApiMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabApiMessage.h"

@implementation LWLabApiMessage
-(void)routine{
    if (self.sending) {
    }else if(self.succeed){
        if ([self.responseObject isKindOfClass:[NSDictionary class]]) {
            self.result = [NSDictionary dictionaryWithDictionary:self.responseObject];
        }
    }else if(self.failed){
        [self.window showFailWithTitle:self.error.localizedFailureReason?:self.error.localizedDescription detail:nil];
    }else if(self.waiting){
    }
}
-(UIWindow *)window{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    return window;
}
@end
