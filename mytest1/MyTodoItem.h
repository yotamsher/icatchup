//
//  MyTodoItem.h
//  mytest1
//
//  Created by Yotam Sher on 10/31/14.
//  Copyright (c) 2014 addresses. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTodoItem : NSObject

@property NSString* itemName;
@property BOOL completed;
@property (readonly) NSDate* creationDate;

@end
