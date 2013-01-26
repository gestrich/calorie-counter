//
//  MultLevelCell.h
//  LOFT@iPad
//
//  Created by William Gestrich on 1/12/13.
//  Copyright (c) 2013 Crate & Barrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultLevelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, weak) IBOutlet UILabel *calorieLabel;
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property NSInteger level;

@end
