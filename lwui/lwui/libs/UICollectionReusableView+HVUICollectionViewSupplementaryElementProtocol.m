//
//  UICollectionReusableView+HVUICollectionViewSupplementaryElementProtocol.m
//  hvui
//
//  Created by moon on 16/4/8.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "UICollectionReusableView+HVUICollectionViewSupplementaryElementProtocol.h"

@implementation UICollectionReusableView (HVUICollectionViewSupplementaryElementProtocol)
+ (CGSize)dynamicReferenceSizeWithCollectionView:(UICollectionView *)collectionView collectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind viewShareInstance:(UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *)view calBlock:(CGSize(^)(UICollectionView *collectionView,HVUICollectionViewSectionModel *sectionModel,NSString *kind,id view))block{
	CGSize size = CGSizeZero;
	CGRect bounds = collectionView.bounds;
	if(!CGRectIsEmpty(bounds)){
		view.bounds = bounds;
		[view setCollectionSectionModel:sectionModel forKind:kind];
		[view setNeedsLayout];
		[view layoutIfNeeded];
		if(block){
			size = block(collectionView,sectionModel,kind,view);
		}
		[view setCollectionSectionModel:nil forKind:kind];
	}
	return size;
}
@end
