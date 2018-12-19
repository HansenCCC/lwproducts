//
//  SVUser.h
//  CHHomeDec
//  user管理者单例
//  Created by 程恒盛 on 2018/8/28.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVUserModel.h"
#import <lwui/lwui.h>

@interface SVUser : NSObject
@property (strong, nonatomic) SVUserModel *userModel;

AS_SINGLETON(SVUser);
@end
