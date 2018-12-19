//
//  LWLabSDWebTableViewCellModel.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLabSDWebTableViewCellModel : HVTableViewCellModel
@property (copy, nonatomic) NSString *urlString;
@property (copy, nonatomic) NSString *title;
- (instancetype)initWithTitle:(NSString *)title urlString:(NSString *)urlString;
@end
