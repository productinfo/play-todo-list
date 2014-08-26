//
//  ToDoListCompleteCell.h
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import <ShinobiGrids/ShinobiDataGrid.h>
#import "ToDoListItem.h"

@class ToDoListCheckboxCell;

@protocol ToDoListCheckboxCellDelegate <NSObject>

- (void)checkboxCellDidChange:(ToDoListCheckboxCell *)checkbox;

@end

@interface ToDoListCheckboxCell : SDataGridCell

@property (nonatomic, weak) id<ToDoListCheckboxCellDelegate> checkboxCellDelegate;
@property (nonatomic, strong) ToDoListItem *toDoListItem;

@end
