//
//  LWLabCarouselTableViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabCarouselTableViewController.h"
#import "LWLabSDWebTableViewCellModel.h"
#import "LWLabSDWebImageApiMessage.h"
#import "LWLabCarouselCollectionViewCell.h"

@interface LWLabCarouselTableViewController ()<LWUICarouselViewDelegate>
@property (strong, nonatomic) LWUICarouselView *carouselView;
@property (strong, nonatomic) NSArray *datas;
@end

@implementation LWLabCarouselTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.carouselView = [[LWUICarouselView alloc] initWithDelegate:self];
    self.carouselView.pageControl.hidden = YES;
    [self.carouselView.collectionView registerClass:[LWLabCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"LWLabCarouselCollectionViewCell"];
    CGRect bounds = self.view.bounds;
    CGRect f1= bounds;
    f1.size.height = f1.size.width/2;
    self.carouselView.frame = f1;
    self.tableView.tableHeaderView = self.carouselView;
    //
    [self requestDatas];
}
- (void)reloadDatas{
    [self.model removeAllSections];
    for (NSString *name in [UIFont familyNames]) {
        [self.model addCellModel:[[LWFormElement alloc] initWithTitle:name]];
    }
    [self.model reloadTableViewData];
}
- (void)requestDatas{
    LWLabSDWebImageApiMessage *api = [[LWLabSDWebImageApiMessage alloc] init];
    @HV_WEAKIFY(self);
    api.whenSucceed = ^(__kindof LWLabSDWebImageApiMessage *msg) {
        @HV_NORMALIZEANDNOTNIL(self);
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in msg.result[@"body"][@"item"]) {
            LWLabSDWebImageModel *m = [[LWLabSDWebImageModel alloc] initWithDic:dic];
            [items addObject:m];
        }
        self.datas = [items copy];
        [self.carouselView reloadData];
    };
    [api send];
}
#pragma mark - LWUICarouselViewDelegate
- (UICollectionViewCell *)lwCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWLabCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWLabCarouselCollectionViewCell" forIndexPath:indexPath];
    cell.cellModel = [self.datas objectAtIndex:indexPath.row];
    return cell;
}
- (NSInteger)lwCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}
-(CGSize)lwCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = collectionView.bounds.size;
    return cellSize;
}
@end
