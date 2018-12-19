//
//  UICollectionViewCell+HVUICollectionViewCellProtocol.h
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVUICollectionViewCellProtocol.h"
@interface UICollectionViewCell (HVUICollectionViewCellProtocol)<HVUICollectionViewCellProtocol>
/**
 *  动态计算单元格的尺寸,一般是使用单例cell进行动态尺寸计算.block中只需要计算尺寸,不需要再配置单例cell的bounds,collectionCellModel等属性
 *
 *  @param collectionView      集合视图
 *  @param collectionCellModel 单元格数据
 *  @param cell                单例单元格
 *  @param block               计算block
 *
 *  @return 动态尺寸
 */
+ (CGSize)dynamicSizeWithCollectionView:(UICollectionView *)collectionView collectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel cellShareInstance:(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell calBlock:(CGSize(^)(UICollectionView *collectionView,HVUICollectionViewCellModel *cellModel,id cell))block;
@end
