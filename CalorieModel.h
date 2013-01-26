//
//  CalorieModel.h
//  Cowrie Counter
//
//  Created by William Gestrich on 1/19/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalorieModel : NSObject

@property (nonatomic, strong) NSMutableArray *calorie_items;


-(void)deleteCalorieItem:(NSMutableDictionary*)item;

+ (CalorieModel*)sharedInstance;


@end
