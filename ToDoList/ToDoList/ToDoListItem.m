//
//  ToDoListItem.m
//  ToDoList
//
//  Created by Alison Clarke on 12/08/2014.
//
//  Copyright 2014 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ToDoListItem.h"

@implementation ToDoListItem

- (instancetype)initWithTaskName:(NSString *)name dueDate:(NSDate *)date category:(ToDoListCategory)category
                        complete:(BOOL)complete {
  self = [super init];
  
  if (self) {
    self.taskName = name;
    self.dueDate = date;
    self.category = category;
    self.complete = complete;
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
