//
//  HVUILayoutConstraintItemWrapper.h
//  hvui
//	对实现HVUILayoutConstraintItemProtocol协议的对象,进行包装.提供被我看见化设置布局相关属性的方法或block
//  Created by moon on 2017/6/5.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HVUILayoutConstraint.h"

@interface HVUILayoutConstraintItemWrapper : NSObject<HVUILayoutConstraintItemProtocol>

typedef CGSize(^HVUILayoutConstraintItemWrapperBlock)(HVUILayoutConstraintItemWrapper *wrapper,CGSize size,BOOL resizeItems);
@property(nonatomic,strong) id<HVUILayoutConstraintItemProtocol> originItem;//被包装的原始布局元素对象
@property(nonatomic,assign) UIEdgeInsets margin;//外边距,默认为(0,0,0,0),self.layoutFrame=self.originItem.layoutFrame+self.margin
@property(nonatomic,assign) CGSize paddingSize;//内边距尺寸,用于计算sizeThatFits.具体为:sizeThatFits的值=self.margin+self.originItem的sizeThatFits值+self.paddingSize
@property(nonatomic,copy) HVUILayoutConstraintItemWrapperBlock sizeThatFitsBlock;//用返回- (CGSize)sizeThatFits:(CGSize)size;和- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems;值的计算
@property(nonatomic,assign) CGSize fixedSize;//固定的尺寸,用于sizeThatFits:计算.如果某一边值<=0,代表这一边值不限定

+ (__kindof HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem;
+ (__kindof HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem fixedSize:(CGSize)fixedSize;
+ (__kindof HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem sizeThatFitsBlock:(HVUILayoutConstraintItemWrapperBlock)sizeThatFitsBlock;
#pragma mark - delegate:HVUILayoutConstraintItemProtocol
- (void)setLayoutFrame:(CGRect)frame;//设置布局尺寸
- (CGRect)layoutFrame;
- (CGSize)sizeOfLayout;//返回尺寸信息
- (BOOL)hidden;//是否隐藏,默认为NO

- (CGSize)sizeThatFits:(CGSize)size;
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems;//适合于容器
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems;//适合于容器
@end
