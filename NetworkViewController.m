//
//  NetworkViewController.m
//  Cowrie Counter
//
//  Created by William Gestrich on 1/19/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "NetworkViewController.h"
#import "SimpleGetNetwork.h"

@interface NetworkViewController ()<NetworkStatus>

@property (nonatomic, strong) SimpleGetNetwork *getObject;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation NetworkViewController

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
    self.getObject = [[SimpleGetNetwork alloc] init];
    self.getObject.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getTapped:(UIButton *)sender {
    
    [self.getObject getOrCancelAction:sender];
    

    
    
}
- (IBAction)showImageTapped:(id)sender {
    
    UIImage *image = [self.getObject getImage];
    [self.imageView setImage:image];
    
}

-(void)connectionFailedWithMessage:(NSString*)message{
    
}


-(void)connectionCompletedWithData:(NSData*)data{
    UIImage *image = [self.getObject getImage];
    [self.imageView setImage:image];
    
}


-(void)bytesTransferred:(NSInteger)bytes{
    NSLog(@"Bytes Transferred: %u", bytes);
}



@end
