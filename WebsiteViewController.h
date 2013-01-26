//
//  WebsiteViewController.h
//  TestApp
//
//  Created by William Gestrich on 11/12/12.
//  Copyright (c) 2012 William Gestrich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebActivity <NSObject>

-(void)websiteDidRefresh;

@end

@interface WebsiteViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITableViewController *tableViewController;
@property (weak, nonatomic) id<WebActivity>webEventDelegate;



@end
