//
//  HVUICollectionViewModel.h
//  hvui
//	UICollectionView的数据源模型
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollection_Header.h"
#import "HVUICollectionViewSectionModel.h"
#import "HVUICollectionViewCellModel.h"
#import "HVUICollectionViewCellProtocol.h"

@interface HVUICollectionViewModel : HVCollectionModel<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,assign) id<UICollectionViewDataSource> forwardDataSource;//遞用鏈傳遞
@property(nonatomic,assign) id<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> forwardDelegate;//遞用鏈傳遞
@property(nonatomic,readwrite,getter=isEditting) BOOL editting;//是否处在编辑状态中
@property(nonatomic,assign) UICollectionView *collectionView;//弱引用外部的collectionView

#pragma mark - empty
@property(nonatomic,assign) Class emptyBackgroundViewClass;//没有单元格数据时的背景视图类
@property(nonatomic,strong) __kindof UIView *emptyBackgroundView;//没有单元格数据时的背景视图
typedef void(^HVUICollectionViewModelC)(__kindof HVUICollectionViewModel *model);
@property(nonatomic,copy) HVUICollectionViewModelC whenReloadBackgroundView;
- (void)reloadCollectionViewBackgroundView;//刷新tableview的backgroundView

- (id)initWithCollectionView:(UICollectionView *)collectionView;

- (__kindof HVUICollectionViewCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath;
- (__kindof HVUICollectionViewSectionModel *)sectionModelAtIndex:(NSInteger)index;
- (__kindof HVUICollectionViewCellModel *)cellModelForSelectedCellModel;

/**
 *  将collectionView的dataSource和delegate设置为self.如果forwardDelegate要监听scrollViewDidScroll:事件,则必须在设置collectionView的delegate之前设置forwardDelegate,因为scrollView是在设置delegate时,去获取delegate是否实现scrollViewDidScroll:方法,后续就不会再获取了.
 *
 *  @param collectionView 集合视图
 */
- (void)setCollectionViewDataSourceAndDelegate:(UICollectionView *)collectionView;

/**
 *  刷新集合视图,会保持集合视图的cell选中状态
 */
- (void)reloadCollectionViewData;

/**
 *  动画的方式添加/删除单元格
 *
 *  @param cellModel  单元格数据
 *  @param animated   是否动画
 *  @param completion 动画结束后的回调
 */
- (void)addCellModel:(HVCollectionCellModel *)cellModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)removeCellModel:(HVCollectionCellModel *)cellModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)removeCellModels:(NSArray<HVCollectionCellModel *> *)cellModels animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

- (void)moveCellModelAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath inCollectionViewBatchUpdatesBlock:(BOOL)isBatchUpdates;

- (void)insertSectionModel:(HVUICollectionViewSectionModel *)sectionModel atIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;//动画添加分组
- (void)removeSectionModel:(HVUICollectionViewSectionModel *)sectionModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;//动画移除分组
@end

@interface HVUICollectionViewModel(NS_DEPRECATED_IOS)//将要被废弃的接口
/**
 *  往前近的一个分组添加单元格,如果没有分组,创建分组
 *
 *  @param cellModel 单元格
 *
 *  @return 被添加单元格的分组
 */
- (HVUICollectionViewSectionModel *)addListedCellModel:(HVUICollectionViewCellModel *)cellModel;
/**
 *  选中单元格,其他单元格置于未选中状态
 *
 *  @param cellModel 单元格对象
 */
- (void)selectSingleCellModel:(HVUICollectionViewCellModel *)cellModel;

/**
 *  选中的单元格数据
 *
 *  @return 单元格数据对象
 */
- (HVUICollectionViewCellModel *)selectedCellModel;

/**
 *  选中的多个单元格数据
 *
 *  @return @[HVUICollectionViewCellModel]
 */
- (NSArray *)selectedCellModels;


@end
