//
//  ToDoListDataSourceHelper.m
//  ToDoList
//
//  Created by Richard Doyle on 11/06/2013.
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

#import "ToDoListDataSourceHelper.h"
#import "ToDoListDataSourceHelperDelegate.h"
#import "ToDoListItem.h"

@implementation ToDoListDataSourceHelper

- (instancetype)initWithDataGrid:(ShinobiDataGrid *)dataGrid delegate:(id<SDataGridDataSourceHelperDelegate>)delegate
                            data:(NSArray *)data {
  self = [super initWithDataGrid:dataGrid];
  if (self) {
    // Assign the data and delegate
    self.data = data;
    self.delegate = delegate;
  }
  return self;
}

#pragma mark - Row Deletion

- (void)deleteItemInRow:(NSInteger)rowIndex {
  // Grab the item to delete using its index in the sorted data
  ToDoListItem *itemToDelete = self.sortedData[rowIndex];
  
  // Get a mutable copy of the original data and remove the item
  NSMutableArray *mutableData = [NSMutableArray arrayWithArray:self.data];
  [mutableData removeObject:itemToDelete];
  self.data = [mutableData copy];
  
  [self reloadData];
}

#pragma mark - Row Creation

- (void)createNewToDoListItem {
  // Create a new item, add it to the end of our list and reload the data
  ((ToDoListDataSourceHelperDelegate*)self.delegate).newRowAdded = YES;
  ToDoListItem *newItem = [[ToDoListItem alloc] initWithTaskName:@"New Item"
                                                         dueDate:[NSDate distantPast]
                                                        category:NilCategory
                                                        complete:NO];
  NSMutableArray *mutableData = [NSMutableArray arrayWithArray:self.data];
  [mutableData addObject:newItem];
  self.data = [mutableData copy];
  [self reloadData];
}

@end
