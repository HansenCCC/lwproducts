//
//  LWLabInputImageTableViewCell.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWLabInputImageTableViewCellModel.h"

@interface LWLabInputImageTableViewCell : UITableViewCell<HVTableViewCellProtocol>
AS_SINGLETON(LWLabInputImageTableViewCell);
@property(nonatomic,strong) LWLabInputImageTableViewCellModel *customCellModel;
@end
