//
//  ToDoListDataSource.m
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
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
  ToDoListItem *newItem = [[ToDoListItem alloc] initWithTaskName:@"New Item" dueDate:[NSDate distantPast]
                                                        category:NilCategory];
  NSMutableArray *mutableData = [NSMutableArray arrayWithArray:self.data];
  [mutableData addObject:newItem];
  self.data = [mutableData copy];
  [self reloadData];
}

@end
