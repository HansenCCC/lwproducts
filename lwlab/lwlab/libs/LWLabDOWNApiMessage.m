//
//  LWLabDOWNApiMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabDOWNApiMessage.h"

@implementation LWLabDOWNApiMessage
- (void)routine{
    [super routine];
    if (self.sending) {
        NSString *url = @"https://github.com/HersonIQ/AFNetworking/archive/master.zip";
        self.url = url;
        [self.window showProgressWithTitle:url animated:YES];
        @HV_WEAKIFY(self);
        self.whenProgressed = ^(__kindof LWMessage *msg) {
            @HV_NORMALIZEANDNOTNIL(self);
            self.window.progressHUD.progress = self.progress;
            LWLog(@"%f",self.progress);
        };
        self.HTTP_DOWNLOAD(url);
    }else if(self.succeed){
        [self.window showSuccessWithTitle:@"下载完成" detail:self.url];
    }else if(self.failed){
    }else if(self.waiting){
    }
}
@end
