//
//  LWUISegmentedView.h
//  LWcheng
//  仿凤凰新闻频道列表
//  Created by 程恒盛 on 17/1/23.
//  Copyright © 2017年 力王. All rights reserved.
//  需注意automaticallyAdjustsScrollViewInsets;


#import <UIKit/UIKit.h>
#import "HVUICollectionView_Header.h"

@interface LWUISegmentedView : UIView
//@property(nonatomic, assign) BOOL resizeItems;//启用最合适的尺寸
@property(nonatomic, readonly) HVUICollectionViewModel *model;//用于添加item
@property(nonatomic, readonly) UICollectionView *collectionView;
@property(nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, readonly) UIView *markView;
+(CGFloat)controlHeight;//默认高度
- (void)addSegmentedModel:(HVCollectionCellModel *)cellModel;//添加item
- (void)reloadSegmentedViewData;//刷新
-(void)removeAllSections;//删除所有
- (void)didSelectItemAtCellModel:(HVUICollectionViewCellModel *)cellModel;//选中某一个cell，刷新其状态
@end

