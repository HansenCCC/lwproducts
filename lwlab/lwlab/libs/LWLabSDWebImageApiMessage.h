//
//  LWLabSDWebImageApiMessage.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabApiMessage.h"


@interface LWLabSDWebImageModel : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *thumbnail;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end

@interface LWLabSDWebImageApiMessage : LWLabApiMessage

@end
