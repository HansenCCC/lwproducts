//
//  LWLabGETApiMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/29.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabGETApiMessage.h"

@implementation LWLabGETApiMessage
- (void)routine{
    [super routine];
    if (self.sending) {
        NSString *url = @"http://api.3g.ifeng.com/get_pic_list?channel=news&pageindex=1&pagesize=5&pageindex=1";
        self.url = url;
        self.HTTP_GET(url);
    }else if(self.succeed){
        NSString *jsonString = [self.result jsonStringWithCompacted:YES];
        [self.window showTipWithTitle:@"展示一条文本提示框,点击隐藏" detail:jsonString animated:YES];
        [self.window.progressHUD addHideGesture];
    }else if(self.failed){
    }else if(self.waiting){
    }
}
@end
