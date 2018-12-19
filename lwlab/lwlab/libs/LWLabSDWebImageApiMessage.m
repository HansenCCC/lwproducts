//
//  LWLabSDWebImageApiMessage.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSDWebImageApiMessage.h"

@implementation LWLabSDWebImageModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [self init]) {
        self.title = [dic objectForKey:@"title"];
        self.thumbnail = [dic objectForKey:@"thumbnail"];
    }
    return self;
}
@end

@implementation LWLabSDWebImageApiMessage
- (void)routine{
    [super routine];
    if (self.sending) {
        NSString *url = @"http://api.3g.ifeng.com/get_pic_list?channel=news&pageindex=1&pagesize=5&pageindex=1";
        self.url = url;
        self.HTTP_GET(url);
    }else if(self.succeed){
    }else if(self.failed){
    }else if(self.waiting){
    }
}
@end
