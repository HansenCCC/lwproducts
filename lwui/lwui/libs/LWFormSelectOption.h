//
//  LWFormSelectOption.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

@interface LWFormSelectOption : HVCollectionCellModel
@property(strong, nonatomic) id key;//选项值对象
@property(nonatomic, strong) NSString *value;//选项的显示字符串

- (id)initWithKey:(NSObject *)key value:(NSString *)value userInfo:(id)userInfo;
@end
