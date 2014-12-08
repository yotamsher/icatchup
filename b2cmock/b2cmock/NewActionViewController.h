//
//  NewActionViewController.h
//  b2cmock
//
//  Created by Yotam Sher on 12/7/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewActionViewController;

@protocol NewActionViewControllerDelegate <NSObject>
- (void)NewActionViewControllerDidCancel:(NewActionViewController *)controller;
- (void)NewActionViewControllerDidSave:(NewActionViewController *)controller;
@end

@interface NewActionViewController : UITableViewController

@property (nonatomic, weak) id<NewActionViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
