//
//  MultiLevelTableViewController.h
//  LOFT@iPad
//
//  Created by Bill Gestrich on 1/10/13.
//  Copyright (c) 2013 Crate & Barrel. All rights reserved.
//

#import <Foundation/Foundation.h>




@protocol DataTreeSource <NSObject>

-(NSMutableArray*)topLevelNodes;

-(NSArray*)childrenForNode:(id)node;

-(NSString*)titleForNode:(id)node;

-(NSInteger)levelForNode:(id)node;

@optional

-(NSString*)detailTextForNode:(id)node;

-(BOOL)nodeStillLoding:(id)node;

@end




@class MultiLevelTableViewController;


@interface MultiLevelTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id<DataTreeSource> dataTreeDelegate;

@property (strong, nonatomic) NSArray *selectedIndices;

-(IBAction)deleteTapped:(id)sender;

-(void)deselectAllRows;



@end
