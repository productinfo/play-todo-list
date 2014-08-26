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

- (instancetype)initWithDataGrid:(ShinobiDataGrid *)dataGrid delegate:(id<SDataGridDataSourceHelperDelegate>)delegate {
  self = [super initWithDataGrid:dataGrid];
  if (self) {
    // Create the to do list
    [self populateToDoList];
    
    // Assign the delegate
    self.delegate = delegate;
  }
  return self;
}

- (void)populateToDoList {
  // Create some due dates
  NSDate *today = [[NSDate alloc] init];
  NSDate *tomorrow = [today dateByAddingTimeInterval:24 * 60 * 60];
  NSDate *inAWeek = [today dateByAddingTimeInterval:7 * 24 * 60 * 60];
  NSDate *inTenDays = [today dateByAddingTimeInterval:10 * 24 * 60 * 60];
  NSDate *inTwoWeeks = [today dateByAddingTimeInterval:2 * 7 * 24 * 60 * 60];
  NSDate *inFourWeeks = [today dateByAddingTimeInterval:4 * 7 * 24 * 60 * 60];
  
  // Add some items
  self.data = @[[[ToDoListItem alloc] initWithTaskName:@"Pick up milk" dueDate:today category:Home],
                [[ToDoListItem alloc] initWithTaskName:@"Mow the lawn" dueDate:tomorrow category:Home],
                [[ToDoListItem alloc] initWithTaskName:@"Buy birthday present for John" dueDate:tomorrow category:Social],
                [[ToDoListItem alloc] initWithTaskName:@"Dinner with Jane @ 7pm" dueDate:tomorrow category:Social],
                [[ToDoListItem alloc] initWithTaskName:@"Phone Mum" dueDate:inAWeek category:Social],
                [[ToDoListItem alloc] initWithTaskName:@"Prepare presentation for next week" dueDate:inAWeek category:Office],
                [[ToDoListItem alloc] initWithTaskName:@"Set up out-of-office" dueDate:inTenDays category:Office],
                [[ToDoListItem alloc] initWithTaskName:@"Doctors appointment @ 9am" dueDate:inFourWeeks category:Personal],
                [[ToDoListItem alloc] initWithTaskName:@"Buy foreign currency" dueDate:inTwoWeeks category:Holiday],
                [[ToDoListItem alloc] initWithTaskName:@"Buy sun cream" dueDate:inTwoWeeks category:Holiday],
                [[ToDoListItem alloc] initWithTaskName:@"Packing" dueDate:inTwoWeeks category:Holiday]
                ];
}

#pragma mark - Row Deletion

- (void)deleteItemInRow:(NSInteger)rowIndex {
  // Sorted data reflects the ordering of items on the screen
  // We need to set our data to match this ordering with the correct row removed
  NSMutableArray *mutableData = [NSMutableArray arrayWithArray:self.sortedData];
  [mutableData removeObjectAtIndex:rowIndex];
  self.data = [mutableData copy];
  
  [self reloadData];
}

#pragma mark - Row Creation

- (void)createNewToDoListItem {
  // Set the data to match what is on screen so it does not reorder when we change the sort order
  self.data = [self.sortedData copy];
  
  // We set the sort order to none so the new row will appear at the bottom of the grid
  for (SDataGridColumn *column in self.dataGrid.columns) {
    column.sortOrder = SDataGridColumnSortOrderNone;
  }
  
  ((ToDoListDataSourceHelperDelegate*)self.delegate).newRowAdded = YES;
  ToDoListItem *newItem = [[ToDoListItem alloc] initWithTaskName:@"" dueDate:[NSDate distantPast]
                                                        category:NilCategory];
  
  NSMutableArray *mutableData = [NSMutableArray arrayWithArray:self.data];
  [mutableData addObject:newItem];
  self.data = [mutableData copy];
}

@end
