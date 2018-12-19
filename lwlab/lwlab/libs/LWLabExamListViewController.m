//
//  LWLabExamListViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabExamListViewController.h"
#import "LWExamTableViewCellModel.h"
#import "LWLabExamSearchViewController.h"
@interface LWLabExamListViewController ()
//
@property(strong, nonatomic) LWExamTableViewCellModel *communicationCellModel;
@property(strong, nonatomic) LWExamTableViewCellModel *readCellModel;
@property(strong, nonatomic) LWExamTableViewCellModel *vocabularyCellModel;
@property(strong, nonatomic) LWExamTableViewCellModel *endTypeCellModel;
@property(strong, nonatomic) LWExamTableViewCellModel *translateCellModel;
@property(strong, nonatomic) LWExamTableViewCellModel *compositionCellModel;
@end

@implementation LWLabExamListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"英语专业考试";
    //
    if (@available(iOS 11.0, *)) {
    } else {
        // Fallback on earlier versions
        //iOS 11之前消除head多出空白
        self.tableView.tableHeaderView = UITableViewHeaderViewLWStuff;
    }
}
- (void)reloadDatas{
    [self.model removeAllSections];
    //code
    [self.model addCellModel:self.communicationCellModel];
    [self.model addCellModel:self.readCellModel];
    [self.model addCellModel:self.vocabularyCellModel];
    [self.model addCellModel:self.endTypeCellModel];
    [self.model addCellModel:self.translateCellModel];
    [self.model addCellModel:self.compositionCellModel];
    @HV_WEAKIFY(self);
    for (LWExamTableViewCellModel *cellModel in self.model.allCellModels) {
        cellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            LWExamTableViewCellModel *_cellModel = (LWExamTableViewCellModel *)cellModel;
            [_cellModel refresh];
            //
            LWLabExamSearchViewController *contoller = [[LWLabExamSearchViewController alloc] init];
            contoller.examStrings = _cellModel.examStrings;
            contoller.title = _cellModel.title;
            [self.navigationController pushViewController:contoller animated:YES];
        };
    }
    [self.model reloadTableViewData];
}
-(LWExamTableViewCellModel *)communicationCellModel{
    if (!_communicationCellModel) {
        _communicationCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"1交际.json"] name:@"1、交际"];
    }
    return _communicationCellModel;
}
-(LWExamTableViewCellModel *)readCellModel{
    if (!_readCellModel) {
        _readCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"2阅读.json"] name:@"2、阅读"];
    }
    return _readCellModel;
}
-(LWExamTableViewCellModel *)vocabularyCellModel{
    if (!_vocabularyCellModel) {
        _vocabularyCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"3词汇.json"] name:@"3、词汇"];
    }
    return _vocabularyCellModel;
}
-(LWExamTableViewCellModel *)endTypeCellModel{
    if (!_endTypeCellModel) {
        _endTypeCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"4完型.json"] name:@"4、完型"];
    }
    return _endTypeCellModel;
}
-(LWExamTableViewCellModel *)translateCellModel{
    if (!_translateCellModel) {
        _translateCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"5翻译.json"] name:@"5、翻译"];
    }
    return _translateCellModel;
}
-(LWExamTableViewCellModel *)compositionCellModel{
    if (!_compositionCellModel) {
        _compositionCellModel = [[LWExamTableViewCellModel alloc] initWithExamStrings:[NSArray arrayWithStringByExamJson:@"6作文.json"] name:@"6、作文"];
    }
    return _compositionCellModel;
}
@end

@implementation NSArray (Exam)
+ (NSArray <NSString *>*)arrayWithStringByExamJson:(NSString *)fileName{
    NSString *path = [[NSBundle lwlabBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *utf8String = data.UTF8String;
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    //
    NSMutableString *_mstring = [[NSMutableString alloc] initWithString:utf8String];
    NSRange range = [_mstring rangeOfString:@"\n"];
    while (range.location != NSNotFound) {
        NSString *substring = [_mstring substringWithRange:NSMakeRange(0, range.location)];
        if (![strings containsObject:substring]) {
            [strings addObject:substring];
        }
        [_mstring deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
        range = [_mstring rangeOfString:@"\n"];
    }
    return strings;
}
@end

