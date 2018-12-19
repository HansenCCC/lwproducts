//
//  HVTableViewModel.h
//  hvui
//	封裝了列表數據,內部包含有列表的分組數組,給tableview提供datasource與delegate
//  Created by moon on 14-4-3.
//  Copyright (c) 2014年 heimavista.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVCollection_Header.h"

#import "HVTableViewSectionModel.h"
#import "HVTableViewCellModel.h"
#import "HVTableViewSectionViewProtocol.h"
#import "HVTableViewCellProtocol.h"
#import "UITableViewCell+HVTableViewCell.h"
#import "LWDefine.h"
#define TableViewDefaultSectionIndexTitle @"#"

@interface HVTableViewModel : HVCollectionModel<UITableViewDataSource,UITableViewDelegate>{
@protected
	HVTableViewSectionModel *_defaultIndexTitleSectionModel;	//存儲section的indexTitle沒有值的情況
}
@property(nonatomic,assign) id<UITableViewDataSource> forwardDataSource;//遞用鏈傳遞
@property(nonatomic,assign) id<UITableViewDelegate  > forwardDelegate;//遞用鏈傳遞

@property(nonatomic,assign) UITableView *tableView;//弱引用
@property(nonatomic,assign) BOOL showSectionIndexTitle;//是否顯示分組索引,默認為NO
@property(nonatomic,strong) NSString *defaultSectionIndexTitle;//當sectionModel.indexTitle沒有值時,採用此默認值,默認為#

@property(nonatomic,readwrite,getter=isEditting) BOOL editting;//是否处在编辑状态中

#pragma mark - empty
@property(nonatomic,assign) Class emptyBackgroundViewClass;//没有单元格数据时的背景视图类
@property(nonatomic,strong) UIView *emptyBackgroundView;//没有单元格数据时的背景视图
typedef void(^HVTableViewModelC)(HVTableViewModel *model);
@property(nonatomic,copy) HVTableViewModelC whenReloadBackgroundView;
- (void)reloadTableViewBackgroundView;//刷新tableview的backgroundView

/**
 *  使用tableview初始化,会设置tableview的datasource与delegate为self
 *
 *  @param tableView 列表对象
 *
 *  @return 列表的数据模型
 */
- (id)initWithTableView:(UITableView *)tableView;

- (__kindof HVTableViewCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath;
- (__kindof HVTableViewSectionModel *)sectionModelAtIndex:(NSInteger)index;
- (__kindof HVTableViewCellModel *)cellModelForSelectedCellModel;

- (__kindof HVTableViewModel *)forwardDataSourceTo:(id<UITableViewDataSource>)dataSource;
- (__kindof HVTableViewModel *)forwardDelegateTo:(id<UITableViewDelegate>)delegate;

/**
 *  将tableView的dataSource和delegate设置为self.如果forwardDelegate要监听scrollViewDidScroll:事件,则必须在设置collectionView的delegate之前设置forwardDelegate,因为scrollView是在设置delegate时,去获取delegate是否实现scrollViewDidScroll:方法,后续就不会再获取了.
 *
 *  @param tableView 视图
 */
- (void)setTableViewDataSourceAndDelegate:(UITableView *)tableView;


/**
 *	添加上自動分組的單元格數據,分組的索引值為cellModel.indexTitle值,僅當showSectionIndexTitle為YES時才會出現右側的分組索引條
 *	@return 返回被歸進的分組中,其中分組默認設置為顯示系統自帶的title,title值為分組的索引值,
 */
- (__kindof HVTableViewSectionModel *)addAutoIndexedCellModel:(HVTableViewCellModel *)cellModel;

/**
 *	按照字符串順序對分組進行排序
 */
- (void)sort;

/**
 *  刷新列表视图,会保持列表视图的选中状态
 */
- (void)reloadTableViewData;
- (void)reloadTableViewDataWithAnimated:(BOOL)animated;
/**
 *  动画的方式添加/删除单元格
 *
 *  @param cellModel  单元格数据
 *  @param animated   是否动画
 */
- (void)addCellModel:(HVTableViewCellModel *)cellModel animated:(BOOL)animated;

- (void)insertCellModel:(HVTableViewCellModel *)cellModel atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)insertCellModel:(HVTableViewCellModel *)cellModel afterIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)insertCellModel:(HVTableViewCellModel *)cellModel beforeIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

- (void)insertCellModels:(NSArray<HVTableViewCellModel *> *)cellModels afterIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (void)insertCellModels:(NSArray<HVTableViewCellModel *> *)cellModels beforeIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

- (void)insertCellModelsToBottom:(NSArray<HVTableViewCellModel *> *)cellModels scrollToBottom:(BOOL)scrollToBottom;//动画添加单元格到底部,section不存在时,会创建默认的section.会动画将将的单元格从下往上推入
- (void)insertCellModelsToTop:(NSArray<HVTableViewCellModel *> *)cellModels keepContentOffset:(BOOL)keepContentOffset;//添加单元格到顶部,section不存在时,会创建默认的section.keepContentOffset标志是否会保持画面不动

- (void)removeCellModel:(HVTableViewCellModel *)cellModel animated:(BOOL)animated;
- (void)removeCellModels:(NSArray<HVTableViewCellModel *> *)cellModels animated:(BOOL)animated;
- (void)removeCellModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexpaths animated:(BOOL)animated;

- (void)insertSectionModel:(HVTableViewSectionModel *)sectionModel atIndex:(NSInteger)index animated:(BOOL)animated;//动画添加分组
- (void)removeSectionModel:(HVTableViewSectionModel *)sectionModel animated:(BOOL)animated;//动画移除分组
@end

@interface HVTableViewModel(NS_DEPRECATED_IOS)//将要被废弃的接口
/**
 *  返回选中/未选中的单元格列表
 *
 *  @param selected 是否选中
 *
 *  @return 列表数据
 */
- (NSArray *)cellsOfSelected:(BOOL)selected;

- (void)removeEmptySections;
/**
 *	返回指定的HVTableViewSectionModel對象
 */
- (HVTableViewSectionModel *)sectionModelAtSection:(NSUInteger)section;

- (NSIndexPath *)indexPathWithCellModel:(HVTableViewCellModel *)cellModel;
- (NSIndexSet *)indexSetWithSectionModel:(HVTableViewSectionModel *)sectionModel;

/**
 *	添加单元格数据到最后一个分组中,如果没有分组,建立分组
 */
- (HVTableViewSectionModel *)addListedCellModel:(HVTableViewCellModel *)cellModel;

/**
 *	移除掉自動分組的單元格數據
 */
- (void)removeAutoIndexedCellModel:(HVTableViewCellModel *)cellModel;
/**
 *  返回选中/未选中的单元格列表
 *
 *  @param selected 是否选中
 *
 *  @return 列表数据
 */
- (NSArray *)cellModelsOfSelected:(BOOL)selected;
@end
