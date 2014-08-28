//
//  ToDoListDataSource.h
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

@import Foundation;
#import <ShinobiGrids/ShinobiDataGrid.h>

@interface ToDoListDataSourceHelper : SDataGridDataSourceHelper

// Initialize the helper with a grid, a delegate and an array of ToDoListItems
- (instancetype)initWithDataGrid:(ShinobiDataGrid *)dataGrid delegate:(id<SDataGridDataSourceHelperDelegate>)gridDelegate
                            data:(NSArray *)data;

- (void)deleteItemInRow:(NSInteger)rowIndex;
- (void)createNewToDoListItem;

@end
