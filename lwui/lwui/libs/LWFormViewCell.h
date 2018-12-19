//
//  LWFormViewCell.h
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWFormElement.h"

#define kLWFormViewCellDefaultHeight 44
#define kLWFormViewCellMargin UIEdgeInsetsMake(11, 15, 11, 15)

@interface LWFormViewCell : UITableViewCell<HVTableViewCellProtocol>
AS_SINGLETON(LWFormViewCell);
/**
 *  返回内容的边距,默认是kHVFormViewCellMargin
 *
 *  @return 边距
 */
+ (UIEdgeInsets)contentMarginInsets;
@property(nonatomic, readonly) UIEdgeInsets contentMarginInsets;//右边

@property(readonly, nonatomic) HVUIFlowLayoutButton *commonButton;
@property(nonatomic,   strong) LWFormElement *customCellModel;
@property(nonatomic,   strong) HVUIFlowLayoutConstraint *flowLayoutConstraint;//流布局
@end
