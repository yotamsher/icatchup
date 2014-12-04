//
//  ConnAction.m
//  b2cmock
//
//  Created by Yotam Sher on 12/3/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnAction : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) int results;

@end