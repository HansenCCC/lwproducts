//
//  LWLabTransparentViewController.h
//  lwlab
//  中间镂空
//  Created by 程恒盛 on 2018/4/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabViewController_Basic.h"

typedef enum : NSUInteger {
    LWUIRectTransparentViewTypeRectangle,//矩形
    LWUIRectTransparentViewTypeCircular, //圆形
} LWUIRectTransparentViewType;//追踪模式

@interface LWLabTransparentViewController : LWLabViewController_Basic
@property (assign, nonatomic) LWUIRectTransparentViewType type;

@end
