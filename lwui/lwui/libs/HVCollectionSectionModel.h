//
//  HVCollectionSectionModel.h
//  hvui
//	集合模型中的分组数据模型
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HVCollectionModel,HVCollectionCellModel;
@interface HVCollectionSectionModel : NSObject
@property(nonatomic,strong) NSArray<__kindof HVCollectionCellModel *> *cellModels;//含有的單元格
@property(nonatomic,strong) id userInfo;//自定義的擴展對象
@property(nonatomic,readonly) NSInteger numberOfCells;//单元格数量
@property(nonatomic,readonly) NSInteger indexInModel;
@property(nonatomic,readonly) NSMutableArray<__kindof HVCollectionCellModel *> * mutableCellModels;
//弱引用外層的數據
- (void)setCollectionModel:(HVCollectionModel *)collectionModel;
- (__kindof HVCollectionModel *)collectionModel;

/**
 *  加到單元格到分組中
 *
 *  @param cellModel 單元格數據
 */
- (void)addCellModel:(HVCollectionCellModel *)cellModel;
- (void)addCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;
- (void)insertCellModel:(HVCollectionCellModel *)cellModel atIndex:(NSInteger)index;
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels afterIndex:(NSInteger)index;
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels beforeIndex:(NSInteger)index;
/**
 *  单元格添加后的配置,@overrdie
 *
 *  @param cellModel 单元格
 */
- (void)configCellModelAfterAdding:(HVCollectionCellModel *)cellModel;
- (void)configCellModelAfterRemoving:(HVCollectionCellModel *)cellModel;

- (void)insertCellModelsToTop:(NSArray<HVCollectionCellModel *> *)cellModels;//添加到顶部
- (void)insertCellModelsToBottom:(NSArray<HVCollectionCellModel *> *)cellModels;//添加到底部

/**
 *  將cell從所有的分組中移除
 *
 *  @param cellModel 單元格對象
 */
- (void)removeCellModel:(HVCollectionCellModel *)cellModel;

/**
 *  移除index位置的单元格
 *
 *  @param index 索引位置
 */
- (void)removeCellModelAtIndex:(NSInteger)index;

/**
 *  移除多个单元格
 *
 *  @param indexes 索引位置集合
 */
- (void)removeCellModelsAtIndexes:(NSIndexSet *)indexes;

/**
 *	清空所有數據
 */
- (void)removeAllCellModels;

/**
 *  返回指定索引下的单元格数据
 *
 *  @param index 索引
 *
 *  @return 单元格数据
 */
- (__kindof HVCollectionCellModel *)cellModelAtIndex:(NSInteger)index;

/**
 *  返回指定单元格数据对应的索引
 *
 *  @param cellModel 单元格数据
 *
 *  @return 索引号
 */
- (NSInteger)indexOfCellModel:(HVCollectionCellModel *)cellModel;

- (NSIndexPath *)indexPathForSelectedCellModel;
- (__kindof HVCollectionCellModel *)cellModelForSelectedCellModel;
- (NSArray<NSIndexPath *> *)indexPathsForSelectedCellModels;
- (NSArray<__kindof HVCollectionCellModel *> *)cellModelsForSelectedCellModels;

- (NSComparisonResult)compare:(HVCollectionSectionModel *)otherObject;
@end

@interface HVCollectionSectionModel(NS_DEPRECATED_IOS)//将要被废弃的接口
@property(nonatomic,strong) NSMutableArray    *cells;//含有的單元格
@end
