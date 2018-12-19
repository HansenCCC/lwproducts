//
//  LWFormSelectOneElement.h
//  lwui
//  单选选择
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormTextFieldElement.h"
#import "LWFormSelectOption.h"

@interface LWFormSelectOneElement : LWFormTextFieldElement
@property(nonatomic,strong) HVCollectionModel *optionModel;//选项模型
@property(nonatomic,strong) LWFormSelectOption *selectedOption;//选中的选项
@property(nonatomic,strong) NSObject *selectedKey;//选中的选项值
@property(nonatomic,strong) NSIndexPath *selectedIndexPath;//选中的选项
@property(nonatomic,readonly) NSArray<__kindof LWFormSelectOption *> *options;//可选的选项


/**
 删除所有选项
 */
- (void)removeAllOptions;

/**
 *  添加一个选项
 *
 *  @param key  选项值
 *  @param desc 选项显示字符串
 *  @param selected 是否选中
 */
- (void)addOption:(NSObject *)key desc:(NSString *)desc selected:(BOOL)selected;

/**
 *  根据key值,找到对应的option选项
 *
 *  @param key key对象
 *
 *  @return option选项
 */
- (LWFormSelectOption *)optionWithKey:(id)key;
@end
