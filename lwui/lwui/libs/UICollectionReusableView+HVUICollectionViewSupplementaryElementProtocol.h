//
//  UICollectionReusableView+HVUICollectionViewSupplementaryElementProtocol.h
//  hvui
//
//  Created by moon on 16/4/8.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVUICollectionViewSupplementaryElementProtocol.h"

@interface UICollectionReusableView (HVUICollectionViewSupplementaryElementProtocol)
/**
 *  动态计算sectionview的尺寸,一般是使用单例进行动态尺寸计算.block中只需要计算尺寸,不需要再配置单例view的bounds,sectionModel,kind等属性
 *
 *  @param collectionView      集合视图
 *  @param sectionModel		   分组数据
 *  @param kind				   分组数据类别
 *  @param view                单例视图
 *  @param block               计算block
 *
 *  @return 动态尺寸
 */
+ (CGSize)dynamicReferenceSizeWithCollectionView:(UICollectionView *)collectionView collectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind viewShareInstance:(UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *)view calBlock:(CGSize(^)(UICollectionView *collectionView,HVUICollectionViewSectionModel *sectionModel,NSString *kind,id view))block;
@end
