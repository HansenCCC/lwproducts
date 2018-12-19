//
//  LWUITextView.h
//  lwlab
//  具备换行和占位符的输入框
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUITextView : UITextView
typedef void(^LWUITextViewHC)(LWUITextView *textView,CGFloat newHeight);
@property(nonatomic,copy) LWUITextViewHC whenContentHeightChange;//高度改变时的通知
@property(nonatomic,strong) NSString *placeholder;//占位符
@property(nonatomic,assign) CGFloat preferredMaxHeight;//最大高度值,0代表没有限制,默认为0.主要用在 sizeThatFit:时
@end
