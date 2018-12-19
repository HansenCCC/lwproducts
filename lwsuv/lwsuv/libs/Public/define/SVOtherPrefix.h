//
//  SVOtherPrefix.h
//  SVGoddess
//
//  Created by 程恒盛 on 2018/8/10.
//  Copyright © 2018年 Herson. All rights reserved.
//

#ifndef SVOtherPrefix_h
#define SVOtherPrefix_h

//全局屏幕尺寸
#define SVScreenW    [UIScreen mainScreen].bounds.size.width
#define SVScreenH    [UIScreen mainScreen].bounds.size.height
#define SVSizeRatio  [UIScreen mainScreen].bounds.size.width/375.0

//弱引用
#define WeakSelf     __weak typeof(self) weakSelf = self;

//设配判断
#define SV_IsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)//ipad
#define SV_IsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)//iphone
#define SV_IsiPhone5 ([UIScreen mainScreen].bounds.size.width == 320)
#define SV_IsiPhone4s ([UIScreen mainScreen].bounds.size.height == 480)
#define SV_IsiPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define SV_IsiPhoneX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f

//字体适配
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]
#define AdaptedBoldFontSize(R)  [UIFont boldSystemFontOfSize:AdaptedWidth(R)]

//布局适配
#define kScreenWidthRatio  (SVScreenW / 375.0)
#define kScreenHeightRatio (SVScreenH / 667.0)
#define AdaptedWidth(x)  ceilf((x) * (SV_IsiPad?1.5:kScreenWidthRatio))
#define AdaptedHeight(x) ceilf((x) * (SV_IsiPad?1.5:kScreenHeightRatio))

//默认大小
#define SVLineDefaultHight  1.f


#endif /* SVOtherPrefix_h */
