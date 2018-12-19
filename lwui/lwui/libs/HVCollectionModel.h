//
//  HVCollectionModel.h
//  hvui
//	集合型控件的数据模型抽象
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HVCollectionCellModel,HVCollectionSectionModel;
@interface HVCollectionModel : NSObject
@property(nonatomic,strong) NSArray<__kindof HVCollectionSectionModel *> *sectionModels;//分組
@property(nonatomic,readonly) NSArray<__kindof HVCollectionCellModel *> *allCellModels;//返回所有的單元格數據
@property(nonatomic,strong) id userInfo;//自定義的擴展對象
@property(nonatomic,readonly) NSInteger numberOfSections;//分组数量
@property(nonatomic,readonly) NSInteger numberOfCells;//所有单元格的数量

@property(nonatomic,assign) BOOL allowsSelection;//default YES
@property(nonatomic,assign) BOOL allowsMultipleSelection;//default NO

@property(nonatomic,readonly) NSIndexPath *indexPathOfLastCellModel;//返回最后一个单元格数据的位置
@property(nonatomic,readonly) NSMutableArray<__kindof HVCollectionSectionModel *> *mutableSectionModels;//可编辑的分组列表数据
/**
 *  产生一个空的分组
 *
 *  @return 分组对象
 */
- (__kindof HVCollectionSectionModel *)createEmptySectionModel;

/**
 *  快速加到單元格到最後一個分組中
 *
 *  @param cellModel 單元格數據
 */
- (void)addCellModel:(HVCollectionCellModel *)cellModel;

/**
 *  快速加到單元格到第一個分組的第一个位置上
 *
 *  @param cellModel 單元格數據
 */
- (void)addCellModelToFirst:(HVCollectionCellModel *)cellModel;

/**
 *  快速添加多个单元格到最后一个分组中,如果分组不存在,会创建分组
 *
 *  @param cellModels @[HVCollectionCellModel]
 */
- (void)addCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;

/**
 *  插入某个单元格到指定的位置
 *
 *  @param cellModel 单元格
 *  @param indexPath 指定的位置
 */
- (void)insertCellModel:(HVCollectionCellModel *)cellModel atIndexPath:(NSIndexPath *)indexPath;
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels afterIndexPath:(NSIndexPath *)indexPath;
- (void)insertCellModels:(NSArray<HVCollectionCellModel *> *)cellModels beforeIndexPath:(NSIndexPath *)indexPath;

- (void)insertCellModelsToBottom:(NSArray<HVCollectionCellModel *> *)cellModels;//添加单元格到底部
- (void)insertCellModelsToTop:(NSArray<HVCollectionCellModel *> *)cellModels;//添加单元格到顶部

/**
 *  將cell從所有的分組中移除
 *
 *  @param cellModel 單元格對象
 */
- (void)removeCellModel:(HVCollectionCellModel *)cellModel;

/**
 *  将多个cell从所有的分组中移除
 *
 *  @param cellModels @[HVCollectionCellModel]
 */
- (void)removeCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;

/**
 *	将多个cell从所有的分组中移除
 *
 *  @param indexPaths @[NSIndexPath]
 */
- (void)removeCellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  移除指定位置上的单元格
 *
 *  @param indexPath 单元格位置
 */
- (void)removeCellModelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  添加分组模型数据
 *
 *  @param sectionModel 分组模型数据
 */
- (void)addSectionModel:(HVCollectionSectionModel *)sectionModel;
- (void)insertSectionModel:(HVCollectionSectionModel *)sectionModel atIndex:(NSInteger)index;
- (void)addSectionModels:(NSArray<HVCollectionSectionModel *> *)sectionModels;

/**
 *  移除掉分组模型数据
 *
 *  @param sectionModel 分组模型数据
 */
- (void)removeSectionModel:(HVCollectionSectionModel *)sectionModel;

/**
 *  移除掉分组模型数据
 *
 *  @param index 分组索引
 */
- (void)removeSectionModelAtIndex:(NSInteger)index;
- (void)removeSectionModelsInRange:(NSRange)range;
/**
 *	清空所有數據
 */
- (void)removeAllSectionModels;

/**
 *  遍历所有的单元格
 *
 *  @param block 单元格访问block
 */
- (void)enumerateCellModelsUsingBlock:(void(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block;

/**
 *  查找指定的单元格
 *
 *  @param block 测试单元格是否满足条件的block
 *
 *  @return 指定单元格的indexpath
 */
- (NSIndexPath *)indexPathOfCellModelPassingTest:(BOOL(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block;

/**
 *  查找指定的单元格
 *
 *  @param block 测试单元格是否满足条件的block
 *
 *  @return 符合条件的单元格indexpath列表
 */
- (NSArray<NSIndexPath *> *)indexPathsOfCellModelPassingTest:(BOOL(^)(id cellModel,NSIndexPath *indexpath,BOOL *stop))block;

/**
 *  獲取指定單元格的位置
 *
 *  @param cellModel 單元格數據
 *
 *  @return indexpath對象
 */
- (NSIndexPath *)indexPathOfCellModel:(HVCollectionCellModel *)cellModel;

/**
 *  获取多个指定单元格的位置
 *
 *  @param cellModels @[HVCollectionCellModel]
 *
 *  @return @[NSIndexPath]
 */
- (NSArray<NSIndexPath *> *)indexPathsOfCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;

/**
 *  获取指定分组的索引值
 *
 *  @param sectionModel 分组
 *
 *  @return 索引
 */
- (NSInteger)indexOfSectionModel:(HVCollectionSectionModel *)sectionModel;
- (NSIndexSet *)indexSetOfSectionModel:(HVCollectionSectionModel *)sectionModel;

/**
 *  返回indexpath指定的單元格數據
 *
 *  @param indexpath NSIndexPath對象
 *
 *  @return HVCollectionCellModel數據
 */
- (__kindof HVCollectionCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath;
- (NSArray<__kindof HVCollectionCellModel *> *)cellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexpaths;
/**
 *  返回index指定的分组
 *
 *  @param index 索引
 *
 *  @return 分组数据
 */
- (__kindof HVCollectionSectionModel *)sectionModelAtIndex:(NSInteger)index;

/**
 *  移除掉没有单元格的空分组
 */
- (void)removeEmptySectionModels;

/**
 *  获取没有含有cell的空分组
 *
 *  @return @[HVCollectionSectionModel]
 */
- (NSArray<__kindof HVCollectionSectionModel *> *)emptySectionModels;

/**
 *  移动单元格
 *
 *  @param sourceIndexPath      源
 *  @param destinationIndexPath 目的
 */
- (void)moveCellModelAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;


#pragma mark - selection
- (void)selectCellModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)selectCellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)selectCellModel:(HVCollectionCellModel *)cellModel;
- (void)selectCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;
- (void)selectAllCellModels;

- (void)deselectCellModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)deselectCellModel:(HVCollectionCellModel *)cellModel;
- (void)deselectCellModels:(NSArray<HVCollectionCellModel *> *)cellModels;
- (void)deselectAllCellModels;

- (NSIndexPath *)indexPathForSelectedCellModel;
- (__kindof HVCollectionCellModel *)cellModelForSelectedCellModel;
- (NSArray<NSIndexPath *> *)indexPathsForSelectedCellModels;
- (NSArray<__kindof HVCollectionCellModel *> *)cellModelsForSelectedCellModels;

@end

@interface HVCollectionModel(NS_DEPRECATED_IOS)//将要被废弃的接口
@property(nonatomic,strong  ) NSMutableArray *sections;//分組
@property(nonatomic,readonly) NSArray        *allCells;//返回所有的單元格數據
/**
 *  快速加到單元格到最後一個分組中
 *
 *  @param cell 單元格數據
 */
- (void)addCell:(HVCollectionCellModel *)cell;
/**
 *  將cell從所有的分組中移除
 *
 *  @param cell 單元格對象
 */
- (void)removeCell:(HVCollectionCellModel *)cell;

/**
 *	清空所有數據
 */
- (void)removeAllSections;

/**
 *  返回indexpath指定的單元格數據
 *
 *  @param indexpath NSIndexPath對象
 *
 *  @return HVCollectionCellModel數據
 */
- (HVCollectionCellModel *)cellWithIndexPath:(NSIndexPath *)indexpath;

/**
 *  返回index指定的分组
 *
 *  @param index 索引
 *
 *  @return 分组数据
 */
- (HVCollectionSectionModel *)sectionWithIndex:(NSInteger)index;
@end


