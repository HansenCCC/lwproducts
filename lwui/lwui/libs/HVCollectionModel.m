//
//  HVCollectionModel.m
//  hvui
//
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollectionModel.h"
#import "HVCollectionSectionModel.h"
#import "HVCollectionCellModel.h"

@interface HVCollectionModel(){
	NSMutableArray<HVCollectionSectionModel *> *_sectionModels;
}
@end

@implementation HVCollectionModel
- (id)init{
	if (self=[super init]) {
		_sectionModels = [[NSMutableArray alloc] init];
		self.allowsSelection = YES;
	}
	return self;
}
- (NSMutableArray<__kindof HVCollectionSectionModel *> *)mutableSectionModels{
	return _sectionModels;
}
- (NSIndexPath *)indexPathOfLastCellModel{
	NSIndexPath *indexpath;
	NSInteger sections = self.numberOfSections;
	for (NSInteger i=sections-1;i>=0;i--) {
		HVCollectionSectionModel *sm = [self sectionModelAtIndex:i];
		NSInteger cells = sm.numberOfCells;
		if(cells>0){
			indexpath = [NSIndexPath indexPathForItem:cells-1 inSection:i];
			break;
		}
	}
	return indexpath;
}
- (NSArray<__kindof HVCollectionSectionModel *> *)sectionModels{
	return [self mutableSectionModels];
}
- (void)setSectionModels:(NSArray<HVCollectionSectionModel *> *)sectionModels{
	[[self mutableSectionModels] removeAllObjects];
	[[self mutableSectionModels] addObjectsFromArray:sectionModels];
}
- (NSInteger)numberOfSections{
	NSInteger number = [self sectionModels].count;
	return number;
}
- (NSInteger)numberOfCells{
	NSInteger numberOfCells = 0;
	for (HVCollectionSectionModel *section in [self sectionModels]) {
		numberOfCells += [section numberOfCells];
	}
	return numberOfCells;
}
- (NSArray<__kindof HVCollectionCellModel *> *)allCellModels{
	NSMutableArray<HVCollectionCellModel *> *cells = [[NSMutableArray alloc] init];
	for (HVCollectionSectionModel *section in [self sectionModels]) {
		[cells addObjectsFromArray:[section cellModels]];
	}
	return cells;
}
- (__kindof HVCollectionSectionModel *)createEmptySectionModel{
	HVCollectionSectionModel *section = [[HVCollectionSectionModel alloc] init];
	return section;
}
- (void)addCellModel:(HVCollectionCellModel *)cellModel{
	if(!cellModel)return;
	HVCollectionSectionModel *section = [[self sectionModels] lastObject];
	if(!section){
		section = [self createEmptySectionModel];
		[self addSectionModel:section];
	}
	[section addCellModel:cellModel];
}
- (void)addCellModelToFirst:(HVCollectionCellModel *)cellModel{
	if(!cellModel)return;
	HVCollectionSectionModel *section = [[self sectionModels] firstObject];
	if(!section){
		section = [self createEmptySectionModel];
		[self addSectionModel:section];
	}
	[section insertCellModel:cellModel atIndex:0];
}
- (void)addCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	for (HVCollectionCellModel *cellModel in cellModels) {
		[self addCellModel:cellModel];
	}
}
- (void)insertCellModel:(HVCollectionCellModel *)cellModel atIndexPath:(NSIndexPath *)indexPath{
	if(!cellModel)return;
	HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
	if(sectionModel){
		[sectionModel insertCellModel:cellModel atIndex:indexPath.row];
	}
}
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels afterIndexPath:(NSIndexPath *)indexPath{
	if(cellModels.count==0||!indexPath)return;
	HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
	if(sectionModel){
		[sectionModel insertCellModels:cellModels afterIndex:indexPath.row];
	}
}
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels beforeIndexPath:(NSIndexPath *)indexPath{
	if(cellModels.count==0||!indexPath)return;
	HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
	if(sectionModel){
		[sectionModel insertCellModels:cellModels beforeIndex:indexPath.row];
	}
}
- (void)insertCellModelsToBottom:(NSArray<HVCollectionCellModel *> *)cellModels{
	if(cellModels.count==0)return;
	HVCollectionSectionModel *sectionModel = [[self sectionModels] lastObject];
	if(sectionModel){
		[sectionModel insertCellModelsToBottom:cellModels];
	}
}
- (void)insertCellModelsToTop:(NSArray<HVCollectionCellModel *> *)cellModels{
	if(cellModels.count==0)return;
	HVCollectionSectionModel *sectionModel = [[self sectionModels] firstObject];
	if(sectionModel){
		[sectionModel insertCellModelsToTop:cellModels];
	}
}
- (void)removeCellModel:(HVCollectionCellModel *)cellModel{
	for (HVCollectionSectionModel *section in [self sectionModels]) {
		[section removeCellModel:cellModel];
	}
}
- (void)removeCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	for (HVCollectionCellModel *cellModel in cellModels) {
		[self removeCellModel:cellModel];
	}
}
- (void)removeCellModelAtIndexPath:(NSIndexPath *)indexPath{
	HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
	[sectionModel removeCellModelAtIndex:indexPath.row];
}
- (void)removeCellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
	if(indexPaths.count==0)return;
    //构建一个NSDictionary,key=数组中元素的keypath值,value=@[数组元素]可用于对数组中的元素进行分组,分组的key值为keypath的值
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (id obj in indexPaths) {
        id key = [obj valueForKeyPath:NSStringFromSelector(@selector(section))];
        if (key) {
            NSMutableArray *list = dict[key];
            if(!list){
                list = [[NSMutableArray alloc] init];
                dict[key] = list;
            }
            [list addObject:obj];
        }
    }
    NSDictionary *sectionMap = dict;
	for (NSNumber *sectionNum in sectionMap) {
		NSArray<NSIndexPath *> *subIndexPaths = sectionMap[sectionNum];
		NSMutableIndexSet *indexset = [[NSMutableIndexSet alloc] init];
		for (NSIndexPath *indexpath in subIndexPaths) {
			[indexset addIndex:indexpath.row];
		}
		HVCollectionSectionModel *sectionModel = [self sectionModelAtIndex:[sectionNum integerValue]];
		[sectionModel removeCellModelsAtIndexes:indexset];
	}
}
- (void)addSectionModel:(HVCollectionSectionModel *)sectionModel{
	if(!sectionModel)return;
	sectionModel.collectionModel = self;
	[[self mutableSectionModels] addObject:sectionModel];
}
- (void)insertSectionModel:(HVCollectionSectionModel *)sectionModel atIndex:(NSInteger)index{
	if(!sectionModel)return;
	sectionModel.collectionModel = self;
	[[self mutableSectionModels] insertObject:sectionModel atIndex:index];
}
- (void)addSectionModels:(NSArray<HVCollectionSectionModel *> *)sectionModels{
	for (HVCollectionSectionModel *sectionModel in sectionModels) {
		[self addSectionModel:sectionModel];
	}
}
- (void)removeSectionModel:(HVCollectionSectionModel *)sectionModel{
	sectionModel.collectionModel = nil;
	[[self mutableSectionModels] removeObject:sectionModel];
}
- (void)removeSectionModelAtIndex:(NSInteger)index{
	if(index>=0&&index<[self mutableSectionModels].count){
		[[self mutableSectionModels] removeObjectAtIndex:index];
	}
}
- (void)removeSectionModelsInRange:(NSRange)range{
	[[self mutableSectionModels] removeObjectsInRange:range];
}
- (void)removeAllSectionModels{
	[[self mutableSectionModels] removeAllObjects];
}
- (NSIndexPath *)indexPathOfCellModel:(HVCollectionCellModel *)cellModel{
	__block NSIndexPath *indexpath = nil;
	[[self sectionModels] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		HVCollectionSectionModel *section = obj;
		NSInteger row = [section indexOfCellModel:cellModel];
		if(row!=NSNotFound){
			indexpath = [NSIndexPath indexPathForRow:row inSection:idx];
			*stop = YES;
		}
	}];
	return indexpath;
}
- (void)enumerateCellModelsUsingBlock:(void(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block{
	if(!block)return;
	NSInteger sectionIndex = 0;
	BOOL stop = NO;
	for (HVCollectionSectionModel *sm in self.sectionModels) {
		NSInteger itemIndex = 0;
		for (HVCollectionCellModel *cellModel in sm.cellModels) {
			NSIndexPath *indexpath = [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];
			block(cellModel,indexpath,&stop);
			if(stop){
				return;
			}
			itemIndex++;
		}
		sectionIndex++;
	}
}
- (NSIndexPath *)indexPathOfCellModelPassingTest:(BOOL(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block{
	if(!block)return nil;
	__block NSIndexPath *result;
	[self enumerateCellModelsUsingBlock:^(id cellModel, NSIndexPath *indexpath, BOOL *stop) {
		BOOL s = block(cellModel,indexpath,stop);
		if(s){
			result = indexpath;
			*stop = YES;
		}
	}];
	return result;
}
- (NSArray<NSIndexPath *> *)indexPathsOfCellModelPassingTest:(BOOL(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block{
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] init];
	[self enumerateCellModelsUsingBlock:^(id cellModel, NSIndexPath *indexpath, BOOL *stop) {
		BOOL s = block(cellModel,indexpath,stop);
		if(s){
			[indexpaths addObject:indexpath];
		}
	}];
	return indexpaths;
}
- (NSArray<NSIndexPath *> *)indexPathsOfCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	NSMutableArray<NSIndexPath *> *indexPaths = [[NSMutableArray alloc] initWithCapacity:cellModels.count];
	for (HVCollectionCellModel *cellModel in cellModels) {
		NSIndexPath *indexPath = [self indexPathOfCellModel:cellModel];
		if(indexPath){
			[indexPaths addObject:indexPath];
		}
	}
	return indexPaths;
}
- (NSInteger)indexOfSectionModel:(HVCollectionSectionModel *)sectionModel{
	NSInteger index = [[self sectionModels] indexOfObject:sectionModel];
	return index;
}
- (NSIndexSet *)indexSetOfSectionModel:(HVCollectionSectionModel *)sectionModel{
	NSInteger index = [[self sectionModels] indexOfObject:sectionModel];
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
	return indexSet;
}
- (HVCollectionCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath{
	if(!indexpath)return nil;
	HVCollectionSectionModel *section = [self sectionModelAtIndex:indexpath.section];
	HVCollectionCellModel *cell = [section cellModelAtIndex:indexpath.row];
	return cell;
}
- (NSArray<__kindof HVCollectionCellModel *> *)cellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexpaths{
	NSMutableArray<HVCollectionCellModel *> *cellModels = [[NSMutableArray alloc] init];
	for (NSIndexPath *indexpath in indexpaths) {
		id cm = [self cellModelAtIndexPath:indexpath];
		if(cm){
			[cellModels addObject:cm];
		}
	}
	return cellModels;
}
- (HVCollectionSectionModel *)sectionModelAtIndex:(NSInteger)index{
	HVCollectionSectionModel *sectionModel;
	if(index>=0&&index<[self sectionModels].count){
		sectionModel = [[self sectionModels] objectAtIndex:index];
	}
	return sectionModel;
}
- (void)removeEmptySectionModels{
	NSArray<HVCollectionSectionModel *> *sectionModels = [self emptySectionModels];
	[[self mutableSectionModels] removeObjectsInArray:sectionModels];
}
- (NSArray<__kindof HVCollectionSectionModel *> *)emptySectionModels{
	NSMutableArray<HVCollectionSectionModel *> *sectionModels = [[NSMutableArray alloc] init];
	for (HVCollectionSectionModel *sm in [self sectionModels]) {
		if(sm.numberOfCells==0){
			[sectionModels addObject:sm];
		}
	}
	return sectionModels;
}
- (void)moveCellModelAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
	if(sourceIndexPath==nil||destinationIndexPath==nil)return;
	HVCollectionCellModel *sourceCellModel = [self cellModelAtIndexPath:sourceIndexPath];
	[self removeCellModelAtIndexPath:sourceIndexPath];
	[self insertCellModel:sourceCellModel atIndexPath:destinationIndexPath];
}

- (void)selectCellModelAtIndexPath:(NSIndexPath *)indexPath{
	HVCollectionCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	[self selectCellModel:cellModel];
}
- (void)selectCellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
	NSArray<HVCollectionCellModel *> *cellModels = [self cellModelsAtIndexPaths:indexPaths];
	[self selectCellModels:cellModels];
}
- (void)selectCellModel:(HVCollectionCellModel *)cellModel{
	if(self.allowsSelection){
		if(!self.allowsMultipleSelection){
			NSArray<HVCollectionCellModel *> *allCells = [self allCellModels];
			for (HVCollectionCellModel *cm in allCells) {
				if(![cm isEqual:cellModel]){
					cm.selected = NO;
				}
			}
		}
		cellModel.selected = YES;
	}
}
- (void)selectCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	if(self.allowsSelection){
		if(self.allowsMultipleSelection){
			for (HVCollectionCellModel *cellModel in cellModels) {
				cellModel.selected = YES;
			}
		}
	}
}
- (void)selectAllCellModels{
	[self selectCellModels:[self allCellModels]];
}
- (void)deselectCellModelAtIndexPath:(NSIndexPath *)indexPath{
	HVCollectionCellModel *cellModel = [self cellModelAtIndexPath:indexPath];
	[self deselectCellModel:cellModel];
}
- (void)deselectCellModel:(HVCollectionCellModel *)cellModel{
	cellModel.selected = NO;
}
- (void)deselectCellModels:(NSArray<HVCollectionCellModel *> *)cellModels{
	for (HVCollectionCellModel *cellModel in cellModels) {
		[self deselectCellModel:cellModel];
	}
}
- (void)deselectAllCellModels{
	[self deselectCellModels:[self allCellModels]];
}
- (NSIndexPath *)indexPathForSelectedCellModel{
	for (int i=0;i<[self sectionModels].count;i++) {
		HVCollectionSectionModel *sm = [self sectionModels][i];
		NSArray<HVCollectionCellModel *> *cellModels = sm.cellModels;
		for (int j=0; j<cellModels.count; j++) {
			HVCollectionCellModel *cm = cellModels[j];
			if(cm.selected){
				NSIndexPath *indexpath = [NSIndexPath indexPathForItem:j inSection:i];
				return indexpath;
			}
		}
	}
	return nil;
}
- (__kindof HVCollectionCellModel *)cellModelForSelectedCellModel{
	for (HVCollectionSectionModel *sm in [self sectionModels]) {
		NSArray<HVCollectionCellModel *> *cellModels = sm.cellModels;
		for (HVCollectionCellModel *cm in cellModels) {
			if(cm.selected){
				return cm;
			}
		}
	}
	return nil;
}
- (NSArray<NSIndexPath *> *)indexPathsForSelectedCellModels{
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] init];
	for (int i=0;i<[self sectionModels].count;i++) {
		HVCollectionSectionModel *sm = [self sectionModels][i];
		NSArray<HVCollectionCellModel *> *cellModels = sm.cellModels;
		for (int j=0; j<cellModels.count; j++) {
			HVCollectionCellModel *cm = cellModels[j];
			if(cm.selected){
				NSIndexPath *indexpath = [NSIndexPath indexPathForItem:j inSection:i];
				[indexpaths addObject:indexpath];
			}
		}
	}
	return indexpaths;
}
- (NSArray<__kindof HVCollectionCellModel *> *)cellModelsForSelectedCellModels{
	NSMutableArray<HVCollectionCellModel *> *cellModels = [[NSMutableArray alloc] init];
	for (HVCollectionSectionModel *sm in [self sectionModels]) {
		NSArray<HVCollectionCellModel *> *cms = sm.cellModels;
		for (HVCollectionCellModel *cm in cms) {
			if(cm.selected){
				[cellModels addObject:cm];
			}
		}
	}
	return cellModels;
}
@end

@implementation HVCollectionModel(NS_DEPRECATED_IOS)
- (NSMutableArray *)sections{
	return [self mutableSectionModels];
}
- (void)setSections:(NSMutableArray *)sections{
	_sectionModels = sections;
}
- (NSArray *)allCells{
	return [self allCellModels];
}
- (void)addCell:(HVCollectionCellModel *)cell{
	[self addCellModel:cell];
}
- (void)removeCell:(HVCollectionCellModel *)cell{
	[self removeCellModel:cell];
}
- (void)removeAllSections{
	[self removeAllSectionModels];
}
- (HVCollectionCellModel *)cellWithIndexPath:(NSIndexPath *)indexpath{
	return [self cellModelAtIndexPath:indexpath];
}
- (HVCollectionSectionModel *)sectionWithIndex:(NSInteger)index{
	return [self sectionModelAtIndex:index];
}
@end
