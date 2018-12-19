//
//  HVTableViewSectionModel.h
//  hvui
//	封裝了列表的分組數據,包含有分組的頭部及尾部信息,以及分組底下的單元格數組
//  Created by moon on 14-4-1.
//  Copyright (c) 2014年 heimavista.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HVCollection_Header.h"

@class HVTableViewModel,HVTableViewCellModel,HVTableViewSectionModel;
@protocol HVTableViewSectionViewProtocol;

typedef void(^HVTableViewSectionModelS)(__kindof HVTableViewSectionModel *sectionModel,__kindof UIView *view);	//繪製該數據時觸發的動作

@interface HVTableViewSectionModel : HVCollectionSectionModel{
}
@property(nonatomic,strong) NSString *indexTitle;//本組的索引字符串
@property(nonatomic,assign) Class<HVTableViewSectionViewProtocol> headViewClass;//默認是UIView
@property(nonatomic,assign) Class<HVTableViewSectionViewProtocol> footViewClass;//默認是UIView

@property(nonatomic,assign) BOOL showHeadView;//是否顯示頭部視圖,默認為否
@property(nonatomic,assign) BOOL showFootView;//是否顯示尾部視圖,默認為否
@property(nonatomic,assign) BOOL showDefaultHeadView;//是否使用系統默認的頭部,默認為NO
@property(nonatomic,assign) BOOL showDefaultFootView;//是否使用系統默認的尾部,默認為NO
@property(nonatomic,assign) CGFloat headViewHeight;//使用系統默認的視圖時,head視圖高度
@property(nonatomic,assign) CGFloat footViewHeight;//使用系統默認的視圖時,foot視圖高度
@property(nonatomic,strong) NSString *headTitle;//head區域的字符串
@property(nonatomic,strong) NSString *footTitle;//foot區域的字符串

@property(nonatomic,readonly) UITableView *tableView;//弱引用外部的tableview
@property(nonatomic,assign) __kindof HVTableViewModel *tableViewModel;

@property(nonatomic,copy) HVTableViewSectionModelS whenShowHeadView;//顯示自定義head視圖的繪製block
@property(nonatomic,copy) HVTableViewSectionModelS whenShowFootView;//顯示自定義foot視圖的繪製block

- (__kindof HVTableViewCellModel *)cellModelAtIndex:(NSInteger)index;

/**
 *  初始化一个显示空白头部的分组
 *
 *  @param height 头部的高度
 *
 *  @return 分组
 */
- (id)initWithBlankHeadView:(CGFloat)height;

/**
 *  初始化一个显示空白尾部的分组
 *
 *  @param height 尾部的高度
 *
 *  @return 分组
 */
- (id)initWithBlankFootView:(CGFloat)height;

/**
 *  初始化一个显示空白头部/尾部的分组
 *
 *  @param headViewHeight 头部高度
 *  @param footViewHeight 尾部高度
 *
 *  @return 分组
 */
- (id)initWithBlankHeadView:(CGFloat)headViewHeight footView:(CGFloat)footViewHeight;

/**
 *  设置显示系统默认的头部视图
 *
 *  @param height 视图高度
 */
- (void)showDefaultHeadViewWithHeight:(CGFloat)height;
/**
 *  设置显示系统默认的尾部视图
 *
 *  @param height 视图高度
 */
- (void)showDefaultFootViewWithHeight:(CGFloat)height;

- (void)displayHeadView:(UIView<HVTableViewSectionViewProtocol> *)view;
- (void)displayFootView:(UIView<HVTableViewSectionViewProtocol> *)view;

- (void)refresh;//刷新整個section
@end

@interface HVTableViewSectionModel(NS_DEPRECATED_IOS)//将要被废弃的接口
@property(nonatomic,strong) NSMutableArray   *cells;//本組底下的單元格對象

/**
 *	添加单元格
 */
- (void)addCellModel:(HVTableViewCellModel *)cellModel atIndex:(NSInteger)index;

/**
 *	清空所有數據
 */
- (void)removeAllCells;
@end
