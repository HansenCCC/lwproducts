//
//  LWLabSDWebTableViewCell.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWLabSDWebTableViewCellModel.h"

@interface LWLabSDWebTableViewCell : UITableViewCell<HVTableViewCellProtocol>
AS_SINGLETON(LWLabSDWebTableViewCell);
@property(nonatomic,strong) LWLabSDWebTableViewCellModel *customCellModel;
@end
