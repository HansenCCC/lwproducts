//
//  UITableViewCell+HVTableViewCell.h
//  hvui
//
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableViewCellProtocol.h"
@interface UITableViewCell (HVTableViewCell)<HVTableViewCellProtocol>
/**
 *  返回动态高度,一般是使用单例cell进行动态高度计算.block中只需要计算高度,不需要再配置单例cell的bounds,cellModel等属性
 *
 *  @param tableView 列表
 *  @param cellModel 单元格视图
 *  @param cell      单元格单例对象
 *  @param block     计算动态高度的block
 *
 *  @return 动态高度
 */
+ (CGFloat)dynamicHeightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel cellShareInstance:(UITableViewCell<HVTableViewCellProtocol> *)cell calBlock:(CGFloat(^)(UITableView *tableView,HVTableViewCellModel *cellModel,id cell))block;
@end
