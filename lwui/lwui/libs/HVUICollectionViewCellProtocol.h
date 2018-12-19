//
//  HVUICollectionViewCellProtocol.h
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DEF_HVCollectionViewCellModel
#define DEF_HVCollectionViewCellModel(clazz,property) \
- (HVUICollectionViewCellModel *)collectionCellModel{\
	return self.property;\
}\
- (void)setCollectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel{\
	self.property = (clazz *)collectionCellModel;\
}
#endif

@class HVUICollectionViewCellModel;

@protocol HVUICollectionViewCellProtocol <NSObject>
@property(nonatomic,strong) HVUICollectionViewCellModel *collectionCellModel;//数据模型
@optional
/**
 *  返回单元格的尺寸信息
 *
 *  @param collectionView      集合视图
 *  @param collectionCellModel 数据对象
 *
 *  @return 尺寸信息
 */
+ (CGSize)sizeWithCollectionView:(UICollectionView *)collectionView collectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel;
//选中/取消选中单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectCell:(BOOL)selected;
@end
