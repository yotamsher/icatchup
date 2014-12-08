//
//  ActionsTableViewController.h
//  b2cmock
//
//  Created by Yotam Sher on 12/3/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewActionViewController.h"

@interface ActionsTableViewController : UITableViewController<NewActionViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray * actions;

@end
