//
//  SplitContainerController.m
//  Cowrie Counter
//
//  Created by William Gestrich on 1/19/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "SplitContainerController.h"
#import "WebsiteViewController.h"

@interface SplitContainerController()<WebActivity>

@property (nonatomic, weak) IBOutlet UIView *containerTop;
@property (nonatomic, weak) IBOutlet UIView *containerBottom;
@property NSDate *updateTimeVersion;

@property IBOutlet UIViewController *controller;

@end

@implementation SplitContainerController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for(UIViewController *vc in self.childViewControllers){
        if([vc.restorationIdentifier isEqualToString:@"web_controller"]){
            [(id)vc setWebEventDelegate:self];
        }
        
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)viewDidLayoutSubviews{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)websiteDidRefresh{
    for(UIViewController *vc in self.childViewControllers){
        if([vc respondsToSelector:@selector(tableView) ]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"model_changed" object:self userInfo:nil];
            [[(id)vc tableView] reloadData];
        }
        
    }
    
}

@end
