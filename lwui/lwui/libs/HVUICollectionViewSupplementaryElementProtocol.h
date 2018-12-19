//
//  HVUICollectionViewSupplementaryElementProtocol.h
//  hvui
//	集合分组的补充视图要实现的协议
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DEF_HVCollectionViewSectionModel
#define DEF_HVCollectionViewSectionModel(clazz,property) \
- (HVUICollectionViewSectionModel *)sectionModel{\
	return self.property;\
}\
- (void)setCollectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind{\
	self.property = (clazz *)sectionModel;\
}
#endif

@class HVUICollectionViewSectionModel;
@protocol HVUICollectionViewSupplementaryElementProtocol <NSObject>
/**
 *  设置补充视图所在的分组以及类型
 *
 *  @param sectionModel 分组数据
 *  @param kind         类型
 */
- (void)setCollectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind;

@optional
/**
 *  返回视图的尺寸,UICollectionViewDelegateFlowLayout使用
 *
 *  @param collectionView 集合
 *  @param sectionModel   分组
 *  @param kind           类型
 *
 *  @return 尺寸值
 */
+ (CGSize)referenceSizeWithCollectionView:(UICollectionView *)collectionView collectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind;
@end
