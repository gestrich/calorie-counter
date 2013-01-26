//
//  ProductDataSource.m
//  LOFT@iPad
//
//  Created by William Gestrich on 1/12/13.
//  Copyright (c) 2013 Crate & Barrel. All rights reserved.
//

#import "ProductDataSource.h"
#import "CalorieModel.h"


#define OUTDOOR_LIVING 12000
#define FURNITURE 4
#define DINING_AND_ENTERTAINMENT 2
#define KITCHEN_AND_FOOD 3
#define DECORATING_AND_ACCESSORIES 5
#define BED_AND_BATH 14390
#define ORGANIZING_AND_STORAGE 1110
#define WHATS_NEW 14571
#define OUTLET 4000
#define SALE 7

@interface ProductDataSource(){
    
    NSMutableArray *multiLevelData;
}

@end

@implementation ProductDataSource









{}//---------------------------------------------------------------------
#pragma mark - Life Cycle Methods
//-----------------------------------------------------------------------









-(id)init
{
    if(self = [super init]){
        multiLevelData = [NSMutableArray array];
    }
    
    return self;
}









//---------------------------------------------------------------------
#pragma mark - DataTreeSource Delegate Methods
//---------------------------------------------------------------------









-(NSMutableArray*)topLevelNodes
{

    
    //Requests for category information will be sent to API
    //But first, put placeholder information in which will
    //be updated by api data as it comes

    NSMutableDictionary *outdoorLiving =            [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Outdoor Living", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", OUTDOOR_LIVING], @"nodeId", @"loading", @"status",  nil ];
    NSMutableDictionary *furniture =                [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Furniture", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", FURNITURE], @"nodeId", @"loading", @"status", nil ] ;
    NSMutableDictionary *diningAndEntertainment =   [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Dining & Entertaining", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", DINING_AND_ENTERTAINMENT], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *kitchenAndFood =           [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Kitchen & Food", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", KITCHEN_AND_FOOD], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *docoratingAndAccessories = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Decorating & Accessories", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", DECORATING_AND_ACCESSORIES], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *bedAndBath =               [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Bed & Bath", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", BED_AND_BATH], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *organizingAndStorage =     [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Organizing & Storage", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", ORGANIZING_AND_STORAGE], @"nodeId",@"loading", @"status", nil ];
    NSMutableDictionary *whatsNew =                 [NSMutableDictionary dictionaryWithObjectsAndKeys:@"What's New", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", WHATS_NEW], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *outlet =                   [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Outlet", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", OUTLET], @"nodeId", @"loading", @"status", nil ];
    NSMutableDictionary *sale =                     [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Sale", @"name", @"0", @"depth",
                                                     [NSString stringWithFormat:@"%u", SALE], @"nodeId", @"loading", @"status", nil ];
    
    NSMutableArray *initialNodes = [NSMutableArray arrayWithObjects:outdoorLiving, furniture, diningAndEntertainment,
                                    kitchenAndFood, docoratingAndAccessories, bedAndBath, organizingAndStorage,
                                    whatsNew, outlet, sale, nil];
    
#pragma unused(initialNodes)
    
    //Add the objects that we added to our array so
    //we can access them when we get the updated data
    //[multiLevelData addObjectsFromArray:initialNodes];
    
    //Request category information for all categories
    //After callback, these are held in array of dictionaries
    //which is used by delegate to populate the table
    
    /*
    [APIWrapper getCategoryInfo:OUTDOOR_LIVING simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:FURNITURE simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:DINING_AND_ENTERTAINMENT simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:KITCHEN_AND_FOOD simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:DECORATING_AND_ACCESSORIES simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:BED_AND_BATH simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:ORGANIZING_AND_STORAGE simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:WHATS_NEW simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:OUTLET simple:NO target:self callback:@selector(didGetCategory:)];
    [APIWrapper getCategoryInfo:SALE simple:NO target:self callback:@selector(didGetCategory:)];
    */
    
    CalorieModel *model = [[CalorieModel alloc] init];
    
    NSMutableArray *calories = model.calorie_items;
    multiLevelData = calories;
    return calories;
}




-(NSString*)titleForNode:(id)node
{
    
    return [node objectForKey:@"Food"];
}




-(NSInteger)levelForNode:(id)node
{
    return 0;
}




-(BOOL)nodeStillLoding:(id)node
{
    return( [[node objectForKey:@"status"] isEqual:@"loading"] );
}


/*
-(void)didGetCategory:(id)sender
{
    //Got information back from server
    //Now use that info to build a tree
    //of structured data
    
    NSLog(@"Received Data");
    
    //First, check if we received a category back in the expected format
    NSDictionary *topLevelCategory = [[sender objectForKey:@"Categories"] objectForKey:@"children"];
    
    if(topLevelCategory && [topLevelCategory isKindOfClass:[NSDictionary class]]){
        //Find the corresponding node that we already sent to the table view controller
        //as a placeholder. Then we will replace that node with this updated one
        
        NSString* categoryId = [topLevelCategory objectForKey:@"categoryId"];
        
        if(categoryId){
            NSDictionary *placeHolderNode = [self categoryNodeForCategoryId:categoryId ];
            
            NSArray *children = [self childrenForNode:topLevelCategory];
            for(NSMutableDictionary *child in children){
                //Set up the new object
                
                [child setObject:@"NO" forKey:@"selected"];
                
                //Set the depth of child as well
                NSInteger childsDepth = 1;
                [child setObject:[NSNumber numberWithInt:childsDepth ] forKey:@"level"];
                
                
                NSArray *grandChildren = [self childrenForNode:child];
                for(NSMutableDictionary *grandChild in grandChildren){
                    //Set up the new object
                    
                    [grandChild setObject:@"NO" forKey:@"selected"];
                    
                    //Set the depth of child as well
                    NSInteger grandChildsDepth = 2;
                    [grandChild setObject:[NSNumber numberWithInt:grandChildsDepth ] forKey:@"level"];
                    
                }
                
            }
            

            NSMutableDictionary *userInfoForUpdateNode = [NSMutableDictionary dictionary];
            [userInfoForUpdateNode setObject:placeHolderNode forKey:@"oldnode"];
            [userInfoForUpdateNode setObject:topLevelCategory forKey:@"newnode"];
        
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"CB_UPDATENODE_NOTIFICATION" object:self userInfo:userInfoForUpdateNode];
            
        }
        
        
        
        
    }else{
        NSLog(@"Format/object not of returned category is not useable");
        assert(NO);
    }
    

    
}

*/





-(NSArray*)childrenForNode:(id)node
{
    if([node respondsToSelector:@selector(objectForKey:)]){
        return [node objectForKey:@"children"];
    }else{
        return nil;
    }
    
}




-(NSString*)detailTextForNode:(id)node
{
    
    return [node objectForKey:@"Calories"];

    


    
    


    
}

@end
