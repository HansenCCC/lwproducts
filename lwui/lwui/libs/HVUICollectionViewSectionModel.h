//
//  HVUICollectionViewSectionModel.h
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollectionSectionModel.h"
#import "HVUICollectionViewSupplementaryElementProtocol.h"
@class HVUICollectionViewModel,HVUICollectionViewCellModel;

@interface HVUICollectionViewSectionModel : HVCollectionSectionModel{
	@protected
	NSMutableDictionary *_supplementaryElementCellClasses;
}
@property(nonatomic,readonly) __kindof UICollectionView *collectionView;//弱引用集合视图
- (__kindof HVUICollectionViewModel *)collectionModel;
- (__kindof HVUICollectionViewCellModel *)cellModelAtIndex:(NSInteger)index;

/**
 *  刷新分组视图
 */
- (void)refresh;

/**
 *  设置集合分组的补充元素显示视图
 *
 *  @param aClass 视图类,必须为UICollectionReusableView的子类
 *  @param kind   补充元素对应的类型,用于区分不同的补充元素
 */
- (void)setSupplementaryElementViewClass:(Class<HVUICollectionViewSupplementaryElementProtocol>)aClass forKind:(NSString *)kind;

/**
 *  移除指定类型的补充元素的显示视图类.被移走后,将不会显示视图
 *
 *  @param kind 补充元素对应的类型
 */
- (void)removeSupplementaryElementViewClassForKind:(NSString *)kind;

/**
 *  获取指定类型的补充元素的显示视图类
 *
 *  @param kind 补充元素对应的类型
 *
 *  @return UICollectionReusableView子类
 */
- (Class<HVUICollectionViewSupplementaryElementProtocol>)supplementaryElementViewClassForKind:(NSString *)kind;

/**
 *  显示分组的补充元素视图
 *
 *  @param view 补充元素视图
 *  @param kind 补充元素对应的类型
 */
- (void)displaySupplementaryElementView:(UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *)view forKind:(NSString *)kind;
@end
