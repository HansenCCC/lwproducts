//
//  HVUICollectionViewSectionModel.m
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVUICollectionViewSectionModel.h"
#import "HVUICollectionViewCellModel.h"
#import "HVUICollectionViewModel.h"
@implementation HVUICollectionViewSectionModel
- (id)init{
	if (self=[super init]) {
		_supplementaryElementCellClasses = [[NSMutableDictionary alloc] init];
	}
	return self;
}
- (__kindof HVUICollectionViewModel *)collectionModel{
	return (HVUICollectionViewModel *)[super collectionModel];
}
- (__kindof HVUICollectionViewCellModel *)cellModelAtIndex:(NSInteger)index{
 	return (HVUICollectionViewCellModel *)[super cellModelAtIndex:index];
}
- (UICollectionView *)collectionView{
	return ((HVUICollectionViewModel *)[self collectionModel]).collectionView;
}
- (void)refresh{
	NSIndexSet *set = [[self collectionModel] indexSetOfSectionModel:self];
	if(set){
		[self.collectionView reloadSections:set];
	}
}
- (void)setSupplementaryElementViewClass:(Class<HVUICollectionViewSupplementaryElementProtocol>)aClass forKind:(NSString *)kind{
	if(![(Class)aClass isSubclassOfClass:[UICollectionReusableView class]])return;
	[_supplementaryElementCellClasses setObject:aClass forKey:kind];
}
- (void)removeSupplementaryElementViewClassForKind:(NSString *)kind{
	[_supplementaryElementCellClasses removeObjectForKey:kind];
}
- (Class<HVUICollectionViewSupplementaryElementProtocol>)supplementaryElementViewClassForKind:(NSString *)kind{
	Class<HVUICollectionViewSupplementaryElementProtocol> aClass = _supplementaryElementCellClasses[kind];
	return aClass;
}
- (void)displaySupplementaryElementView:(UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *)view forKind:(NSString *)kind{
	[view setCollectionSectionModel:self forKind:kind];
	[view setNeedsLayout];
}
@end
