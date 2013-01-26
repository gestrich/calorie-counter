//
//  MultLevelCell.m
//  LOFT@iPad
//
//  Created by William Gestrich on 1/12/13.
//  Copyright (c) 2013 Crate & Barrel. All rights reserved.
//

#import "MultLevelCell.h"

#define SUB_TEXT_LEFT_PADDING 5

@interface MultLevelCell()




@end

@implementation MultLevelCell









{}//---------------------------------------------------------------------
#pragma mark - Life Cycle Methods
//-----------------------------------------------------------------------









-(void)awakeFromNib
{
    
    self.textLabel.font = [UIFont systemFontOfSize:30];
    //self.detailTextLabel.font = [UIFont fontWithName:@"CB-55Regular" size:16];
    
    //self.detailTextLabel.text = @"Text Detail";
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView = activityView;
    
    //Move to right side of content view cell
    self.activityView.frame = CGRectMake(
                                         420,8, 30, 30);

    //[self.activityView startAnimating];
    [self.contentView addSubview:self.activityView];
    self.activityView.color = [UIColor colorWithRed:83.0/256.0 green:167.0/256.0 blue:24.0/256.0 alpha:1.0];
    self.activityView.hidesWhenStopped = YES;
    
    UISwipeGestureRecognizer *pangr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showDelete:)];
    [pangr setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:pangr];
    
    
    
}


-(void)showDelete:(id)sender{
    
    NSLog(@"Swype done");
    
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setUpDetailView];

}










//---------------------------------------------------------------------
#pragma mark - Customization methods
//---------------------------------------------------------------------









-(void)setUpDetailView
{
    
#define INDENT_0 30.0
#define INDENT_1 60.0
#define INDENT_2 80.0
    
    //Trim textLabels to size
    [self.textLabel sizeToFit];
    [self.calorieLabel sizeToFit];
    
    //Indent the text to the left
    NSInteger indent;
    if(self.level==0) indent = INDENT_0;
    if(self.level==1) indent = INDENT_1;
    if(self.level==2) indent = INDENT_2;
    
    //Move to center as test
    
    self.textLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
   
    //Move back to left
    self.textLabel.frame = CGRectMake( indent,
                            self.textLabel.frame.origin.y,
                            self.textLabel.frame.size.width,
                            self.textLabel.frame.size.height
                            );
     
     
    /*
    self.calorieLabel.frame = CGRectMake( self.textLabel.frame.origin.x
                                            + self.textLabel.frame.size.width + 10.0,
                                            self.calorieLabel.frame.origin.y,
                                            self.calorieLabel.frame.size.width,
                                            self.calorieLabel.frame.size.height
                                            );
    */
    
}

@end
