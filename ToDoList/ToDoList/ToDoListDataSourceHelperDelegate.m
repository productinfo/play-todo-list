//
//  ToDoListDelegate.m
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import "ToDoListDataSourceHelperDelegate.h"
#import "ToDoListCheckboxCell.h"
#import "ToDoListCategoryCell.h"
#import "ToDoListDateCell.h"
#import "ToDoListDeleteCell.h"
#import "ToDoListDataSourceHelper.h"
#import "ToDoListViewController.h"
#import "ToDoListItem.h"

@implementation ToDoListDataSourceHelperDelegate

- (instancetype)init {
  self = [super init];
  if (self) {
    self.newRowAdded = NO;
  }
  return self;
}

#pragma mark - SDataGridDelegate methods

- (void)didFinishLayingOutShinobiDataGrid:(ShinobiDataGrid *)grid {
  // If we have just added a new row to the grid, highlight it and make sure it's currently visible
  if (self.newRowAdded) {
    // Find current index of new row
    ToDoListDataSourceHelper *datasourceHelper = (ToDoListDataSourceHelper*)grid.dataSource;
    NSInteger rowIndex = [datasourceHelper.sortedData indexOfObject:[datasourceHelper.data lastObject]];
    
    // Highlight the row just added
    SDataGridRow *row = [SDataGridRow rowWithRowIndex:rowIndex sectionIndex:0];
    [grid setSelectedRows:@[row] animated:YES];
    
    // Clear the highlight after a short delay
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [grid clearSelectionWithAnimation:YES];
    });
    
    // Make sure the new row is in view
    [self shinobiDataGrid:grid bringRowIntoView:rowIndex];
    
    self.newRowAdded = NO;
  }
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didFinishEditingCellAtCoordinate:(SDataGridCoord *)coordinate {
  ToDoListDataSourceHelper *datasourceHelper = (ToDoListDataSourceHelper*)grid.dataSource;
  ToDoListItem *item = (datasourceHelper.sortedData)[coordinate.row.rowIndex];
  
  // Update the toDoListItem if the task name has been edited. (For other editable columns,
  // our custom cells will update the toDoListItem)
  if ([coordinate.column.propertyKey isEqualToString:@"taskName"]) {
    SDataGridTextCell *cell = (SDataGridTextCell*)[grid visibleCellAtCoordinate:coordinate];
    item.taskName = cell.textField.text;
  }
  
  // If the grid is sorted on the edited column, re-sort it
  if (coordinate.column.sortOrder != SDataGridColumnSortOrderNone) {
    // Select the row just edited
    [grid setSelectedRows:@[coordinate.row] animated:YES];
    
    // Reorder the grid after a delay (to allow the row selection to finish)
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.2f * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      // To force a reorder, we first sort by None, then sort by the current sortOrder
      SDataGridColumnSortOrder currentOrder = coordinate.column.sortOrder;
      coordinate.column.sortOrder = SDataGridColumnSortOrderNone;
      coordinate.column.sortOrder = currentOrder;
      
      // Make sure the edited row is in view: first need to find its index
      NSInteger rowIndex = [datasourceHelper.sortedData indexOfObject:item];
      if (rowIndex != NSNotFound) {
        [self shinobiDataGrid:grid bringRowIntoView:rowIndex];
      }
      
      // Clear the highlight after a short delay
      dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
      dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        [grid clearSelectionWithAnimation:YES];
      });
    });
  }
}

- (BOOL)shinobiDataGrid:(ShinobiDataGrid *)grid shouldBeginEditingCellAtCoordinate:(const SDataGridCoord *)coordinate {
  // We don't want to edit the complete or delete columns
  if ([coordinate.column.propertyKey isEqualToString:@"complete"] ||
      [coordinate.column.propertyKey isEqualToString:@"delete"]) {
    return NO;
  } else {
    return YES;
  }
}

#pragma mark - SDataGridDataSourceHelperDelegate methods

- (id)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper
       displayValueForProperty:(NSString *)propertyKey
              withSourceObject:(id)object {
  // Our ToDoListItems don't have a delete property so we need to tell the helper what value
  // to display in the delete column. The value won't actually be displayed as our custom
  // cell will take care of it - we just need to return a non-nil value to prevent the helper
  // looking for a delete property on the object
  if ([propertyKey isEqualToString:@"delete"]) {
    return [NSNull null];
  }
  
  // Default
  return nil;
}

- (BOOL)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper
                    populateCell:(SDataGridCell *)cell
                       withValue:(id)value
                     forProperty:(NSString *)propertyKey
                    sourceObject:(id)object {
  // Complete Column
  if ([propertyKey isEqualToString:@"complete"]) {
    ToDoListItem *item = (ToDoListItem*)object;
    ToDoListCheckboxCell *completeCell = (ToDoListCheckboxCell*)cell;
    [completeCell setToDoListItem:item];
    return YES;
  }
  
  // Date Column
  if ([propertyKey isEqualToString:@"dueDate"]) {
    ToDoListDateCell *dateCell = (ToDoListDateCell*)cell;
    dateCell.dataGrid = helper.dataGrid;
    dateCell.toDoListItem = (ToDoListItem*)object;
    return YES;
  }
  
  // Category Column
  if ([propertyKey isEqualToString:@"category"]) {
    ToDoListCategoryCell *categoryCell = (ToDoListCategoryCell*)cell;
    categoryCell.dataGrid = helper.dataGrid;
    categoryCell.toDoListItem = (ToDoListItem*)object;
    return YES;
  }
  
  // Delete Column
  if ([propertyKey isEqualToString:@"delete"]) {
    ToDoListDeleteCell *deleteCell = (ToDoListDeleteCell*)cell;
    deleteCell.dataGrid = helper.dataGrid;
    return YES;
  }
  
  // Default
  return NO;
}

- (id)dataGridDataSourceHelper:(SDataGridDataSourceHelper *)helper sortValueForProperty:(NSString *)propertyKey
              withSourceObject:(id)object {
  // We want to sort the category column alphabetically, so convert the enum value to a string
  if ([propertyKey isEqualToString:@"category"]) {
    ToDoListCategory category = ((ToDoListItem*)object).category;
    return [ToDoListItem categoryToString:category];
  }
  
  // Default
  return nil;
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didEndReorderingRow:(SDataGridRow *)row {
  // When the user has manually reordered the grid, save the new order to use as our default.
  // We do this after a short delay to make sure the reordering animations have finished,
  // because changing the data will result in a reload of the grid
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.2f * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    ToDoListDataSourceHelper *datasourceHelper = (ToDoListDataSourceHelper*)grid.dataSource;
    datasourceHelper.data = [datasourceHelper.sortedData copy];
  });
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didChangeSortOrderForColumn:(SDataGridColumn*) column
                  from:(SDataGridColumnSortOrder) oldSortOrder {
  // Update canReorderRows - we want them to be reorderable if and only if the sort order is none
  grid.canReorderRows = (column.sortOrder == SDataGridColumnSortOrderNone);
}

#pragma mark - local methods

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid bringRowIntoView:(NSInteger)rowIndex {
  // Only need to do anything if the grid's contents are taller than its frame - otherwise
  // all rows are in view
  if (grid.contentSize.height > grid.frame.size.height) {
    CGFloat rowHeight = [[grid defaultRowHeight] floatValue] + grid.defaultGridLineStyle.width;
    
    // Calculate position of new row within grid
    CGFloat rowTop = rowIndex * rowHeight;
    CGFloat rowBottom = rowTop + rowHeight;
    
    CGFloat newYOffset = grid.contentOffset.y;
    
    if (grid.contentOffset.y > rowTop) {
      // Row is scrolled off the top of the grid, so just scroll to its top
      newYOffset = rowTop;
    } else if (rowBottom > grid.contentOffset.y + grid.frame.size.height - [grid.defaultHeaderRowHeight floatValue]) {
      // Row is off the bottom of the grid, so place it at the bottom
      newYOffset = rowBottom - grid.frame.size.height + [grid.defaultHeaderRowHeight floatValue];
    }
    
    if (newYOffset != grid.contentOffset.y) {
      // Scroll to the new offset
      [grid setContentOffset:CGPointMake(0, newYOffset) animated:YES];
    }
  }
}

@end
