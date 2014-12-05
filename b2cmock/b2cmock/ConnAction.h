//
//  ConnAction.m
//  b2cmock
//
//  Created by Yotam Sher on 12/3/14.
//  Copyright (c) 2014 MyTests. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) int results;
@property (nonatomic, assign) int color;

@end