//
//  ActionsTableViewController.m
//  b2cmock
//
//  Created by Yotam Sher on 12/3/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import "ActionsTableViewController.h"
#import "ConnAction.h"
#import "ConnActionCell.h"
#import "NewActionViewController.h"

@interface ActionsTableViewController ()

@end

@implementation ActionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.edgesForExtendedLayout = UIRectEdgeNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.actions count ];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ConnActionCell *cell = (ConnActionCell *)[tableView dequeueReusableCellWithIdentifier:@"ActionCell"];
    
    
    ConnAction *action = (self.actions)[indexPath.row];
    
    cell.titleLabel.text = action.title;
    cell.resultsLabel.text = [NSString stringWithFormat:@"%d", action.results];
    cell.resultsLabel.backgroundColor = [self colorForCode:action.color];
    cell.resultsLabel.center = CGPointMake(tableView.contentSize.width - 25 , 27 );
    
    NSLog(@"cell width: %f", cell.frame.size.width);
    
    return cell;
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)NewActionViewControllerDidCancel:(NewActionViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)NewActionViewControllerDidSave:(NewActionViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddConnAction"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        NewActionViewController *newActionViewController = [navigationController viewControllers][0];
        newActionViewController.delegate = self;
    }}


static id s_singleton = nil;
+ (id) alloc {
    if(s_singleton != nil)
        return s_singleton;
    return [super alloc];
}
- (id) initWithCoder:(NSCoder *)aDecoder {
    if(s_singleton != nil)
        return s_singleton;
    self = [super initWithCoder:aDecoder];
    if(self) {
        s_singleton = self;
    }
    return self;
}


- (UIColor *)colorForCode:(int)code
{
    
    switch (code) {
        case 1: return [UIColor colorWithRed:252/255.f green:191/255.f blue:14/255.f alpha:1.0];
        case 2: return [UIColor colorWithRed:69/255.f green:129/255.f blue:165/255.f alpha:1.0];
        case 3: return [UIColor colorWithRed:164/255.f green:123/255.f blue:171/255.f alpha:1.0];
        case 4: return [UIColor colorWithRed:252/255.f green:191/255.f blue:14/255.f alpha:1.0];
        case 5: return [UIColor colorWithRed:252/255.f green:191/255.f blue:14/255.f alpha:1.0];
    }
    return nil;
}

@end
