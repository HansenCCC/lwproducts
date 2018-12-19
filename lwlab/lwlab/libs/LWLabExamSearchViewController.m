//
//  LWLabExamSearchViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/13.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabExamSearchViewController.h"
#import "LWLabExamListViewController.h"

@interface LWLabExamSearchViewController ()<UISearchResultsUpdating>
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) LWLabExamSubjectViewController *subjectViewController;

@end

@implementation LWLabExamSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建搜索框
    LWLabExamSubjectViewController *contoller = [[LWLabExamSubjectViewController alloc] init];
    contoller.examStrings = [self.examStrings copy];
    
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:contoller];
    search.searchResultsUpdater = self;
    search.searchBar.placeholder = @"搜索";
    //
    self.tableView.tableHeaderView = search.searchBar;
    self.subjectViewController = contoller;
    self.searchController = search;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *inputStr = searchController.searchBar.text ;
    NSMutableArray *examStrings = [[NSMutableArray alloc] init];
    for (NSString *string in self.examStrings) {
        if ([string.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            [examStrings addObject:string];
        }
    }
    self.subjectViewController.examStrings = [examStrings copy];
    [self.subjectViewController reloadDatas];
}
@end
