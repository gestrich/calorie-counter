//
//  CalorieModel.m
//  Cowrie Counter
//
//  Created by William Gestrich on 1/19/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "CalorieModel.h"

@implementation CalorieModel

static CalorieModel *sharedObject;

+ (CalorieModel*)sharedInstance
{

    if (sharedObject == nil) {

        sharedObject = [[super allocWithZone:NULL] init];
    }
    return sharedObject;
}





-(NSMutableArray*)calorie_items{
    
     NSError* error = nil;
     
     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://54.243.28.182/calorie_table.php"]];
     
     NSMutableArray *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
     return [JSON mutableCopy];
    
}

-(void)deleteCalorieItem:(NSMutableDictionary*)item{
    
    NSString *post = [NSString stringWithFormat:@"q=%@", [item valueForKey:@"foodIndex"] ];
    //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *postData = [ NSData dataWithBytes: [ post UTF8String ] length: [ post length ] ];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:@"http://54.243.28.182/deleteitem.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:nil];
    [connection start];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"model_changed" object:self userInfo:nil];
    
    
}

@end
