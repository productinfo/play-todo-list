//
//  ToDoListItem.m
//  ShinobiControls
//
//  Created by  on 15/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

#import "ToDoListItem.h"

@implementation ToDoListItem

- (instancetype)initWithTaskName: (NSString*)name dueDate:(NSDate*)date category:(ToDoListCategory)category {
  self = [super init];
  
  if (self) {
    self.taskName = name;
    self.dueDate = date;
    self.category = category;
    self.complete = NO;
  }
  
  return self;
}

- (NSString *)categoryString {
  return [ToDoListItem categoryToString:self.category];
}

+ (NSArray*)categoryStrings {
  return @[@"Home", @"Office", @"Social", @"Personal", @"Holiday", @"-"];
}

+ (NSString*)categoryToString:(ToDoListCategory)category {
  if (category < [[self class] categoryStrings].count) {
    return [[self class] categoryStrings][category];
  }
  return NULL;
}

@end
