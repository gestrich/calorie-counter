//
//  DataManager.m
//  Cowrie Counter
//
//  Created by William Gestrich on 1/19/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

static DataManager *dataManager = nil;

+(DataManager*)sharedInstance{
    if(dataManager == nil){
        dataManager = [[super allocWithZone:nil] init];
    }
    
    return dataManager;
}

-(id)init{
    self = [super init];
    if(self){
        //Initialization
    }
    
    return self;
}


@end
