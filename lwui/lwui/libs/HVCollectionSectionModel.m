//
//  HVCollectionSectionModel.m
//  hvui
//
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollectionSectionModel.h"
#import "HVCollectionModel.h"
#import "HVCollectionCellModel.h"

@interface HVCollectionSectionModel(){
	NSMutableArray<HVCollectionCellModel *> *_cellModels;
	__weak HVCollectionModel *_collectionModel;
}
@end

@implementation HVCollectionSectionModel
- (id)init{
	if (self=[super init]) {
		_cellModels = [[NSMutableArray alloc] init];
	}
	return self;
}
- (NSMutableArray<HVCollectionCellModel *> *)mutableCellModels{
	return _cellModels;
}
- (void)setCollectionModel:(HVCollectionModel *)collectionModel{
	_collectionModel = collectionModel;
}
- (HVCollectionModel *)collectionModel{
	return _collectionModel;
}
- (NSInteger)numberOfCells{
	NSInteger number = self.cellModels.count;
	return number;
}
- (NSInteger)indexInModel{
	NSInteger index = [self.collectionModel indexOfSectionModel:self];
	return index;
}
- (NSArray<HVCollectionCellModel *> *)cellModels{
	return self.mutableCellModels;
}
- (void)setCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	[[self mutableCellModels] removeAllObjects];
	[[self mutableCellModels] addObjectsFromArray:cellModels];
}
- (void)addCellModel:(HVCollectionCellModel *)cellModel{
	if(!cellModel)return;
	[[self mutableCellModels] addObject:cellModel];
	[self configCellModelAfterAdding:cellModel];
}
- (void)addCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	if(cellModels.count==0)return;
	for (HVCollectionCellModel *cellModel in cellModels) {
		[self addCellModel:cellModel];
	}
}
- (void)insertCellModel:(HVCollectionCellModel *)cellModel atIndex:(NSInteger)index{
	if(!cellModel)return;
	[[self mutableCellModels] insertObject:cellModel atIndex:index];
	[self configCellModelAfterAdding:cellModel];
}
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels afterIndex:(NSInteger)index{
	if(cellModels.count==0)return;
	NSMutableIndexSet *indexset = [[NSMutableIndexSet alloc] init];
	for (int i=0;i<cellModels.count;i++) {
		[indexset addIndex:index+1+i];
	}
	[[self mutableCellModels] insertObjects:cellModels atIndexes:indexset];
	for (HVCollectionCellModel *cellModel in cellModels) {
		[self configCellModelAfterAdding:cellModel];
	}
}
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels beforeIndex:(NSInteger)index{
	[self insertCellModels:cellModels afterIndex:index-1];
}
- (void)insertCellModelsToTop:(NSArray<HVCollectionCellModel *> *)cellModels{
	[self insertCellModels:cellModels beforeIndex:0];
}
- (void)insertCellModelsToBottom:(NSArray<HVCollectionCellModel *> *)cellModels{
	NSInteger count = self.numberOfCells;
	[self insertCellModels:cellModels afterIndex:count-1];
}
- (void)configCellModelAfterAdding:(HVCollectionCellModel *)cellModel{
	cellModel.sectionModel = self;
}
- (void)configCellModelAfterRemoving:(HVCollectionCellModel *)cellModel{
	cellModel.sectionModel = nil;
}
- (void)removeCellModel:(HVCollectionCellModel *)cellModel{
	[self configCellModelAfterRemoving:cellModel];
	[[self mutableCellModels] removeObject:cellModel];
}
- (void)removeCellModelAtIndex:(NSInteger)index{
	NSMutableArray<HVCollectionCellModel *> *cellModels = [self mutableCellModels];
	if(index>=0&&index<cellModels.count){
		HVCollectionCellModel *cellModel = [cellModels objectAtIndex:index];
		[self configCellModelAfterRemoving:cellModel];
		[cellModels removeObjectAtIndex:index];
	}
}
- (void)removeCellModelsAtIndexes:(NSIndexSet *)indexes{
	if(indexes.count){
		NSArray<HVCollectionCellModel *> *cellModels = [[self mutableCellModels] objectsAtIndexes:indexes];
		for (HVCollectionCellModel *cellModel in cellModels) {
			[self configCellModelAfterRemoving:cellModel];
		}
		[[self mutableCellModels] removeObjectsAtIndexes:indexes];
	}
}
- (void)removeAllCellModels{
	for (HVCollectionCellModel *cellModel in [self mutableCellModels]) {
		[self configCellModelAfterRemoving:cellModel];
	}
	[[self mutableCellModels] removeAllObjects];
}
- (HVCollectionCellModel *)cellModelAtIndex:(NSInteger)index{
	HVCollectionCellModel *cellModel;
	if(index>=0&&index<[self cellModels].count){
		cellModel = [self cellModels][index];
	}
	return cellModel;
}
- (NSInteger)indexOfCellModel:(HVCollectionCellModel *)cellModel{
	NSInteger index = [[self cellModels] indexOfObject:cellModel];
	return index;
}

- (NSIndexPath *)indexPathForSelectedCellModel{
	NSIndexPath *indexpath;
	for (int i=0; i<[self cellModels].count; i++) {
		HVCollectionCellModel *cm = [self cellModels][i];
		if(cm.selected){
			indexpath = [NSIndexPath indexPathForRow:i inSection:[self.collectionModel indexOfSectionModel:self]];
			break;
		}
	}
	return indexpath;
}
- (HVCollectionCellModel *)cellModelForSelectedCellModel{
	HVCollectionCellModel *cellModel;
	for (int i=0; i<[self cellModels].count; i++) {
		HVCollectionCellModel *cm = [self cellModels][i];
		if(cm.selected){
			cellModel = cm;
			break;
		}
	}
	return cellModel;
}
- (NSArray<NSIndexPath *> *)indexPathsForSelectedCellModels{
	NSMutableArray<NSIndexPath *> *indexPaths = [[NSMutableArray alloc] init];
	NSInteger index = [self.collectionModel indexOfSectionModel:self];
	for (int i=0; i<[self cellModels].count; i++) {
		HVCollectionCellModel *cm = [self cellModels][i];
		if(cm.selected){
			NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:index];
			[indexPaths addObject:indexpath];
		}
	}
	return indexPaths;
}
- (NSArray<HVCollectionCellModel *> *)cellModelsForSelectedCellModels{
	NSMutableArray<HVCollectionCellModel *> *cellModels = [[NSMutableArray alloc] init];
	for (HVCollectionCellModel *cm in [self cellModels]) {
		if(cm.selected){
			[cellModels addObject:cm];
		}
	}
	return cellModels;
}

- (NSComparisonResult)compare:(HVCollectionSectionModel *)otherObject{
	NSInteger section1 = [self.collectionModel indexOfSectionModel:self];
	NSInteger section2 = [otherObject.collectionModel indexOfSectionModel:otherObject];
	NSComparisonResult r = NSOrderedSame;
	if(section1<section2){
		r = NSOrderedAscending;
	}else if(section1>section2){
		r = NSOrderedDescending;
	}
	return r;
}
@end

@implementation HVCollectionSectionModel(NS_DEPRECATED_IOS)
- (void)setCells:(NSMutableArray *)cells{
	_cellModels = cells;
}
- (NSMutableArray *)cells{
	return _cellModels;
}
@end
