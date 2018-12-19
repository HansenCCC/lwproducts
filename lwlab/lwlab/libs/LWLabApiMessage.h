//
//  LWLabApiMessage.h
//  lwlab
//  api状态机制lab基类
//  Created by 程恒盛 on 2018/4/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

//#import <lwapi/lwapi.h>

@interface LWLabApiMessage : LWApiMessage
@property (strong, readonly) UIWindow *window;
@property (nonatomic, strong) NSDictionary *result;//服务器返回数据
@property (nonatomic, copy) NSString *url;
@end
