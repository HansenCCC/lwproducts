//
//  LWFormSelectOneElement.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/20.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormSelectOneElement.h"
#import "LWFormSelectOneViewCell.h"

@interface LWFormSelectOneElement ()

@end

@implementation LWFormSelectOneElement
- (instancetype)init{
    if (self = [super init]) {
        self.cellClass = [LWFormSelectOneViewCell class];
        self.optionModel = [[HVCollectionModel alloc] init];
    }
    return self;
}
-(NSArray<LWFormSelectOption *> *)options{
    return [self.optionModel allCellModels];
}
- (void)removeAllOptions{
    [self.optionModel removeAllSections];
}
-(void)addOption:(NSObject *)key desc:(NSString *)desc selected:(BOOL)selected{
    LWFormSelectOption *option = [[LWFormSelectOption alloc] initWithKey:key value:desc userInfo:nil];
    [self.optionModel addCellModel:option];
    if(selected){
        self.selectedOption = option;
    }
}
- (LWFormSelectOption *)optionWithKey:(id)key{
    LWFormSelectOption *option = nil;
    for (LWFormSelectOption *o in [self.optionModel allCellModels]) {
        if ([o.key isEqual:key]) {
            option = o;
            break;
        }
    }
    return option;
}
- (NSObject *)selectedKey{
    return self.selectedOption.key;
}
- (void)setSelectedKey:(NSObject *)selectedKey{
    LWFormSelectOption *option = [self optionWithKey:selectedKey];
    self.selectedOption = option;
}
- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    LWFormSelectOption *option = (LWFormSelectOption *)[self.optionModel cellModelAtIndexPath:selectedIndexPath];
    self.selectedOption = option;
}
- (NSIndexPath *)selectedIndexPath{
    NSIndexPath *indexPath = [self.optionModel indexPathOfCellModel:self.selectedOption];
    return indexPath;
}
- (NSString *)valueString{
    return self.selectedOption.value;
}
@end
