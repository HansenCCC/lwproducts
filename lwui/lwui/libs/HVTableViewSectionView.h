//
//  HVTableViewSectionView.h
//  hvui
//	section使用的自定義的頭部/尾部視圖
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableViewSectionViewProtocol.h"
#define kHVTableViewSectionViewDefaultHeight 22
@interface HVTableViewSectionView : UIView<HVTableViewSectionViewProtocol>
@property(nonatomic,strong) UILabel *textLabel;
@end

@interface UIView(HVTableViewSectionViewProtocol)
/**
 *  返回动态高度,一般是使用单例cell进行动态高度计算.block中只需要计算高度,不需要再配置单例cell的bounds,cellModel等属性
 *
 *  @param tableView	列表
 *  @param sectionModel 分组数据
 *  @param kind			分组数据类别
 *  @param view			分组视图单例对象
 *  @param block		计算动态高度的block
 *
 *  @return 动态高度
 */
+ (CGFloat)dynamicHeightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind viewShareInstance:(UIView<HVTableViewSectionViewProtocol> *)view calBlock:(CGFloat(^)(UITableView *tableView,HVTableViewSectionModel *sectionModel,HVTableViewSectionViewKind kind,id view))block;
@end