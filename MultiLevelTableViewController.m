//
//  MultiLevelTableViewController.m
//  LOFT@iPad
//
//  Created by Bill Gestrich on 1/10/13.
//  Copyright (c) 2013 Crate & Barrel. All rights reserved.
//

#import "MultiLevelTableViewController.h"
#import "MultLevelCell.h"
#define MULTI_LEVEL_CELL @"MULTI_LEVEL_Cell"
#import "ProductDataSource.h"
#import "CalorieModel.h"


@interface MultiLevelTableViewController(){
    NSMutableArray *visibleNodeArray;
    NSMutableDictionary *selectedNodes;
    
    
    
}

@property CalorieModel *model;


@end





@implementation MultiLevelTableViewController









{}//---------------------------------------------------------------------
#pragma mark - Getters/Setters
//-----------------------------------------------------------------------







-(void)viewDidLoad{
    
     self.model = [[CalorieModel alloc] init];

}


/**
 * Sets a delegate for the data to
 * fill the table hierarchy. See
 * protocol <DataTreeSource> for
 * info on what methods need to be
 * implemented to populate data in 
 * this table
 *
 * @author  Bill Gestrich
 * @method  setDataTreeDelegate
 * @since   1.0
 */
-(void)setDataTreeDelegate:(id<DataTreeSource>)dataTreeDelegate
{
    _dataTreeDelegate = dataTreeDelegate;
    
    // A convenient place to ask for initial
    // data to load in table.
    visibleNodeArray = [self.dataTreeDelegate topLevelNodes];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
	[center addObserver:self selector:@selector(modelUpdate:)
                   name:@"model_changed" object:nil];

}





/**
 * Allows another class to get the number
 * of indices selected in a table view
 * This is helpful when another view
 * controller has this view table view
 * controller as a child
 *
 * @author  Bill Gestrich
 * @method  selectedIndices
 * @since   1.0
 */
-(NSArray*)selectedIndices
{
    return [selectedNodes allValues];
}









-(void)modelUpdate:(NSNotification*)sender{
    
    id<DataTreeSource> dataSource = [[ProductDataSource alloc] init];
    //[self setDataTreeDelegate:[ProductDataSource alloc] init] ]
    [self setDataTreeDelegate:dataSource];
    [self.tableView reloadData];
    
    
}
//-----------------------------------------------------------------------
#pragma mark - Life Cycle Methods
//-----------------------------------------------------------------------






-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        //Bookkeeping
        visibleNodeArray = [NSMutableArray array];
        selectedNodes = [NSMutableDictionary dictionary];
        
    }
    
    //This class listens for node updates. This allows nodes to be loaded
    //in incomplete state initially. When updated, the dataTreeDelegate can
    //fire a notification to update the node (row)
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(updateNode:) name:@"CB_UPDATENODE_NOTIFICATION" object:nil];
    //self.tableView.showsVerticalScrollIndicator = YES;
    
    //Register nib file reuse identifier
    /*UINib *nib = [UINib nibWithNibName:@"MultLevelCell"
                                bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:MULTI_LEVEL_CELL];*/
    
    id<DataTreeSource> dataSource = [[ProductDataSource alloc] init];
    //[self setDataTreeDelegate:[ProductDataSource alloc] init] ]
    [self setDataTreeDelegate:dataSource];
    
    
    return self;
}


-(id)init{
    self = [super init];
    if(self){
        
        //Bookkeeping
        visibleNodeArray = [NSMutableArray array];
        selectedNodes = [NSMutableDictionary dictionary];

    }
    
    //This class listens for node updates. This allows nodes to be loaded
    //in incomplete state initially. When updated, the dataTreeDelegate can
    //fire a notification to update the node (row)
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(updateNode:) name:@"CB_UPDATENODE_NOTIFICATION" object:nil];
    self.tableView.showsVerticalScrollIndicator = YES;
    
    //Register nib file reuse identifier
    UINib *nib = [UINib nibWithNibName:@"MultLevelCell"
                                bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:MULTI_LEVEL_CELL];
    

    return self;
}




-(void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self
                      name:@"CB_UPDATENODE_NOTIFICATION"
                    object:nil];
    
    [center removeObserver:self
                      name:@"CB_-DOWNLOAD-SELECTED-TAPPED"
                    object:nil];
    
    [center removeObserver:self
                      name:@"model_changed"
     
                    object:nil];
    
    self.dataTreeDelegate = nil;
}









//-----------------------------------------------------------------------
#pragma mark - Incoming Notifications / methods
//-----------------------------------------------------------------------









/**
 * Nodes can be updated even
 * after intially loaded. This
 * is helpful when you want to 
 * load nodes initially with 
 * placeholder data, then expand
 * as a network source populates 
 * more elements for that node
 *
 * @author  Bill Gestrich
 * @method  updateNode
 * @since   1.0
 */
-(void)updateNode:(NSNotification*)notification{
    
    NSMutableDictionary *node = [notification.userInfo objectForKey:@"oldnode"];
    NSMutableDictionary *newNode = [notification.userInfo objectForKey:@"newnode"];
    
    NSInteger indexOfObject = [visibleNodeArray indexOfObject:node];
    
    if(indexOfObject == NSNotFound){
        NSLog(@"Can't find table object for update");
        assert(NO);
    }
    
    //Replace node with the new one
    [visibleNodeArray replaceObjectAtIndex:indexOfObject withObject:newNode];
        

    
    
}



-(IBAction)deleteTapped:(UIButton*)sender{
    NSLog(@"Delete Tapped");
     NSMutableDictionary *node = [visibleNodeArray objectAtIndex:sender.tag];
    
    [self.model deleteCalorieItem:node];
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];

    
    [visibleNodeArray removeObject:node];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];

}









/**
 * Deselect everything
 * and reload
 *
 * @author  Bill Gestrich
 * @method  deselectAllRows
 * @since   1.0
 */
-(void)deselectAllRows{
    [selectedNodes removeAllObjects];
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:YES];
}









//-----------------------------------------------------------------------
#pragma mark - Table view data source
//-----------------------------------------------------------------------










- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    // Return the number of sections.
    
    return 1;
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    // Return the number of rows in the section.
    
    return [visibleNodeArray count];
    
}

- (BOOL) hasExpired:(NSDate*)myDate
{
    return [myDate timeIntervalSinceNow] < 0.f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{

    MultLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:MULTI_LEVEL_CELL];
    
    
    // Get node associated with this cell
    NSMutableDictionary *node = [visibleNodeArray objectAtIndex:indexPath.row];
    
    //Set the title
    NSString *title = [self.dataTreeDelegate titleForNode:node];
    
    if(title){
        cell.textLabel.text = title;
    }else{
        NSLog(@"No title found for node");
    }
    
    //cell.level = 0;
    
    //Set the detail label text
    if([self.dataTreeDelegate respondsToSelector:@selector(detailTextForNode:)]){
        cell.calorieLabel.text = [self.dataTreeDelegate detailTextForNode:node];
    }
    
    //Set tag for delete button so we know what row it is associated with
    cell.deleteButton.tag = indexPath.row;
    
    //Handle the selection of the node
    if([selectedNodes objectForKey:node]){
        cell.selected = YES;

    }else{
        //Not Selected
        cell.selected = NO;
    }
    
    //Handle the activity indicator
    if([self.dataTreeDelegate respondsToSelector:@selector(nodeStillLoding:)] &&
       [self.dataTreeDelegate nodeStillLoding:node]){
        [cell.activityView startAnimating];
    }else{
        //Wait a second to ensure activity indicator shows
        //The delay can be removed from code later
        [cell.activityView stopAnimating];
    }
    
    
    return cell;
    
}









//---------------------------------------------------------------------
#pragma mark - Table view delegate
//-----------------------------------------------------------------------









- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
NSMutableDictionary *node = [visibleNodeArray objectAtIndex:indexPath.row];
        
    NSMutableDictionary *selectedNode = [visibleNodeArray objectAtIndex:indexPath.row ];
    BOOL newSelectionState;
    if( [selectedNodes objectForKey:selectedNode] ) newSelectionState = NO;
    else newSelectionState = YES;
    
    [self toggleSelection:node];
    


}




/*
 * Required to cover empty cells at bottom
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}




/*
 * Required to show line above top cell
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 1)];
    
    view.backgroundColor = [UIColor lightGrayColor];
    view.opaque = NO;
    view.alpha = .4;
    return view;
}



/*
 * Required to show 1 point high line above top cell
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}









//-----------------------------------------------------------------------
#pragma mark - Helper Methods
//-----------------------------------------------------------------------









/*
 *
 *toggle a cell select/unselected
 */
-(void)toggleSelection:(NSMutableDictionary*)node
{
    //Toggle row selection
    if(![selectedNodes objectForKey:node])
    {
        //Not selected -- add it as selected
        [selectedNodes setObject:node forKey:node];
        
    }else
    {
        //Already selected -- remove from selection dictionary
        [selectedNodes removeObjectForKey:node];

        
    }
    [self.tableView reloadData];
}



@end




