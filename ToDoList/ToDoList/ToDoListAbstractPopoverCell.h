//
//  ToDoListPopoverCell.h
//  ToDoList
//
//  Created by Alison Clarke on 13/08/2014.
//  Copyright (c) 2014 Alison Clarke. All rights reserved.
//

#import <ShinobiGrids/ShinobiGrids.h>
#import "ToDoListAbstractPopoverViewController.h"

@interface ToDoListAbstractPopoverCell : SDataGridCell

@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UINavigationController* navigationController;
@property (strong, nonatomic) UIPopoverController* popover;

@property (nonatomic, strong) ShinobiDataGrid* dataGrid;
@property (strong, nonatomic) ToDoListItem* toDoListItem;
@property (strong, nonatomic) ToDoListAbstractPopoverViewController* popoverViewController;

- (void)createNavigationController;

@end
