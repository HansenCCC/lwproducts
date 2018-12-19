//
//  HVTableViewSectionAdjustsView.h
//  hvui
//	高度会自动适应的分组视图
//  Created by moon on 15/3/20.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVTableViewSectionView.h"
#import "LWDefine.h"

@interface HVTableViewSectionAdjustsView : HVTableViewSectionView
AS_SINGLETON(HVTableViewSectionAdjustsView);//用于进行动态高度计算
+ (UIEdgeInsets)contentMargin;//返回UIEdgeInsetsMake(8, 16, 8, 16)
/**
 *  只显示头部,分组高度自适应
 *
 *  @param title 标题
 *
 *  @return 分组
 */
+ (HVTableViewSectionModel *)sectionModelWithHeadTitle:(NSString *)title;
/**
 *  只显示尾部,分组高度自适应
 *
 *  @param title 标题
 *
 *  @return 分组
 */
+ (HVTableViewSectionModel *)sectionModelWithFootTitle:(NSString *)title;

/**
 *  分组高度自适应
 *
 *  @param headTitle 头部标题
 *  @param footTitle 尾部标题
 *
 *  @return 分组
 */
+ (HVTableViewSectionModel *)sectionModelWithHeadTitle:(NSString *)headTitle footTitle:(NSString *)footTitle;
@end
