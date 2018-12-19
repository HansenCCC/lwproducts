//
//  SVTableViewSectionView.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2018/8/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "SVTableViewSectionView.h"

@implementation SVTableViewSectionModel
- (instancetype)init{
    if (self = [super init]) {
        self.footViewClass = [SVTableViewSectionView class];
        self.headViewClass = [SVTableViewSectionView class];
    }
    return self;
}
- (id)initWithBlankHeadView:(CGFloat)height{
    if (self = [super initWithBlankHeadView:height]) {
        self.showDefaultHeadView = NO;
    }
    return self;
}
- (id)initWithBlankFootView:(CGFloat)height{
    if (self = [super initWithBlankFootView:height]) {
        self.showDefaultFootView = NO;
    }
    return self;
}
@end
@implementation SVTableViewSectionView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+ (CGFloat)heightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind{
    if (kind == HVTableViewSectionViewKindOfHead) {
        return sectionModel.headViewHeight;
    }else{
        return sectionModel.footViewHeight;
    }
}
@end
