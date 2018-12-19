//
//  LWTitleTableViewCell.h
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWTitleTableViewCellModel.h"

@interface LWTitleTableViewCell : UITableViewCell<HVTableViewCellProtocol>
@property(readonly, nonatomic) UIView *separatorView;// cell边缘线

AS_SINGLETON(LWTitleTableViewCell);
@property(nonatomic,strong) LWTitleTableViewCellModel *customCellModel;
@end
