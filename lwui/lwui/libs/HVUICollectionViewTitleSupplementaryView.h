//
//  HVUICollectionViewTitleSupplementaryView.h
//  hvui
//	显示自适应高度的文本视图
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUICollectionViewSupplementaryView.h"
#import "HVUICollectionViewTitleSupplementarySectionModel.h"
#import "LWDefine.h"

@interface HVUICollectionViewTitleSupplementaryView : HVUICollectionViewSupplementaryView
AS_SINGLETON(HVUICollectionViewTitleSupplementaryView);//此单例用于动态高度的计算
@property(nonatomic,strong) HVUICollectionViewTitleSupplementarySectionModel *titleSectionModel;
@property(nonatomic,strong) UILabel *textLabel;
+ (UIEdgeInsets)contentInsets;
@end
