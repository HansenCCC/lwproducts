//
//  LWUIWebViewController.h
//  lwui
//  封装webview
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUIWebViewController : UIViewController

@property(nonatomic, strong) NSURL *requestURL;

/**
 加载网页

 @param request request
 */
- (void)loadRequest:(NSURLRequest *)request;
/**
 加载HTML

 @param string HTMLString
 */
- (void)loadHTMLString:(NSString *)string;

@end
