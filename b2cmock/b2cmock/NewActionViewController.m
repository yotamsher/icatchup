//
//  NewActionViewController.m
//  b2cmock
//
//  Created by Yotam Sher on 12/7/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import "NewActionViewController.h"

@implementation NewActionViewController

- (IBAction)cancel:(id)sender
{
    [self.delegate NewActionViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    [self.delegate NewActionViewControllerDidSave:self];
}
@end
