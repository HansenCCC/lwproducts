//
//  LWLabMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/24.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabMessage.h"

@implementation LWLabMessage
-(void)routine{
    if (self.sending) {
        NSLog(@"********sending********");
    }else if(self.succeed){
        NSLog(@"********succeed********");
    }else if(self.failed){
        NSLog(@"********failed********");
    }else if(self.waiting){
        NSLog(@"********waiting********");
    }
}
@end
