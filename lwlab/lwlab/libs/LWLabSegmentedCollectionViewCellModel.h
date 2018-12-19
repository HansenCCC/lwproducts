//
//  LWLabSegmentedCollectionViewCellModel.h
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <lwui/lwui.h>

@interface LWLabSegmentedCollectionViewCellModel : HVUICollectionViewCellModel
@property (copy, nonatomic) NSString *title;
- (instancetype)initWithTitle:(NSString *)title;
@end
