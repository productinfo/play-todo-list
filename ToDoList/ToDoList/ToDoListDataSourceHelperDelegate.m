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
  // If we have just added a new row to the grid, open the task cell up for editing
  if (self.newRowAdded) {
    // If the new row is not visible scroll the grid to the bottom
    float yOffset = grid.contentSize.height - grid.frame.size.height;
    [grid setContentOffset:CGPointMake(0, MAX(0,yOffset)) animated:NO];
    
    SDataGridRow *lastRow = [[grid visibleRows] lastObject];
    SDataGridColumn *taskColumn = nil;
    for (SDataGridColumn *column in grid.columns) {
      if ([column.propertyKey isEqualToString:@"taskName"]) {
        taskColumn = column;
        break;
      }
    }
    
    SDataGridCoord *coordinate = [SDataGridCoord coordinateWithCol:taskColumn row:lastRow];
    SDataGridTextCell *newCell = (SDataGridTextCell*)[grid visibleCellAtCoordinate:coordinate];
    
    // Put the cell into edit mode (make the keyboard appear)
    [newCell respondToEditEvent];
  }
}

- (void)shinobiDataGrid:(ShinobiDataGrid *)grid didFinishEditingCellAtCoordinate:(SDataGridCoord *)coordinate {
  // Update the toDoListItem if the task name has been edited. (For other editable columns,
  // our custom cells will update the toDoListItem)
  if ([coordinate.column.propertyKey isEqualToString:@"taskName"]) {
    ToDoListDataSourceHelper *datasourceHelper = (ToDoListDataSourceHelper*)grid.dataSource;
    SDataGridTextCell *cell = (SDataGridTextCell*)[grid visibleCellAtCoordinate:coordinate];
    
    ToDoListItem *item = (datasourceHelper.sortedData)[coordinate.row.rowIndex];
    item.taskName = cell.textField.text;
  }
  
  // Resort the grid
  for (SDataGridColumn *col in grid.columns) {
    if (col.sortOrder != SDataGridColumnSortOrderNone) {
      // Temporarily set the selection mode to row
      SDataGridSelectionMode oldSelectionMode = grid.selectionMode;
      grid.selectionMode = SDataGridSelectionModeRowSingle;
      
      // Select the row just edited
      [grid setSelectedRows:@[coordinate.row] animated:YES];
      
      // Reorder the grid after a delay (to allow the row selection to work)
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.15f * NSEC_PER_SEC);
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // To force a reorder, we first sort by None, then sort by the current sortOrder
        SDataGridColumnSortOrder currentOrder = col.sortOrder;
        col.sortOrder = SDataGridColumnSortOrderNone;
        col.sortOrder = currentOrder;
        
        // Clear the highlight after a short delay
        dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
          [grid clearSelectionWithAnimation:YES];
          // Reset the selection mode
          grid.selectionMode = oldSelectionMode;
        });
      });
    }
  }
  
  self.newRowAdded = NO;
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

@end
