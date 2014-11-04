//
//  MyListTableViewController.m
//  mytest1
//
//  Created by Yotam Sher on 10/29/14.
//  Copyright (c) 2014 addresses. All rights reserved.
//

#import "MyListTableViewController.h"
#import "MyTodoItem.h"
#import "AddItemViewController.h"

@interface MyListTableViewController ()

@property NSMutableArray *todoItems;

@end


@implementation MyListTableViewController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    AddItemViewController* editor = [segue sourceViewController];
    MyTodoItem* newItem = editor.todoItem;
    if (newItem != nil) {
        [self.todoItems addObject: newItem];
        [self.tableView reloadData];
    }
}

- (void) loadInitialData {
    MyTodoItem *item1 = [[MyTodoItem alloc] init];
    item1.itemName = @"Go fishing";
    [self.todoItems addObject:item1];
    
    MyTodoItem *item2 = [[MyTodoItem alloc] init];
    item2.itemName = @"Drink beer";
    [self.todoItems addObject:item2];
    
    MyTodoItem *item3 = [[MyTodoItem alloc] init];
    item3.itemName = @"Read a book";
    [self.todoItems addObject:item3];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data sourc
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.todoItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    MyTodoItem *item = [self.todoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.itemName;
    
    if(item.completed)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyTodoItem *selectedItem = [self.todoItems objectAtIndex: indexPath.row];
    selectedItem.completed = !selectedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
     
}
@end
