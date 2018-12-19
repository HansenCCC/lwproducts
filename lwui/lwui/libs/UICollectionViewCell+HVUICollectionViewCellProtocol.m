//
//  UICollectionViewCell+HVUICollectionViewCellProtocol.m
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "UICollectionViewCell+HVUICollectionViewCellProtocol.h"
#import <objc/runtime.h>

@implementation UICollectionViewCell (HVUICollectionViewCellProtocol)
#pragma mark - deleagte:HVUICollectionViewCellProtocol
- (HVUICollectionViewCellModel *)collectionCellModel{
	HVUICollectionViewCellModel *cellModel = objc_getAssociatedObject( self, "UICollectionViewCell.HVUICollectionViewCellModel.collectionCellModel");
	return cellModel;
}
- (void)setCollectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel{
	objc_setAssociatedObject( self, "UICollectionViewCell.HVUICollectionViewCellModel.collectionCellModel", collectionCellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}
+ (CGSize)dynamicSizeWithCollectionView:(UICollectionView *)collectionView collectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel cellShareInstance:(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell calBlock:(CGSize(^)(UICollectionView *collectionView,HVUICollectionViewCellModel *cellModel,id cell))block{
	CGSize size = CGSizeZero;
	CGRect bounds = collectionView.bounds;
	if(!CGRectIsEmpty(bounds)){
		cell.bounds = bounds;
		cell.collectionCellModel = collectionCellModel;
		[cell setNeedsLayout];
		[cell layoutIfNeeded];
		if(block){
			size = block(collectionView,collectionCellModel,cell);
		}
		cell.collectionCellModel = nil;
	}
	return size;
}
@end
