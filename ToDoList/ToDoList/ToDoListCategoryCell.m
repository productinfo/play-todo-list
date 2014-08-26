//
//  ToDoListCategoryCell.m
//  ToDoList
//
//  Created by Alison Clarke on 12/08/2014.
//  Copyright (c) 2014 Alison Clarke. All rights reserved.
//

#import "ToDoListCategoryCell.h"
#import "ToDoListCategoryViewController.h"

@implementation ToDoListCategoryCell

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
  if (self = [super initWithReuseIdentifier:identifier]) {
    // Create a CategoryViewController ready to display when in edit mode
    ToDoListCategoryViewController *vc = [[ToDoListCategoryViewController alloc] initWithNibName:@"ToDoListCategoryPopover"
                                                                                          bundle:nil];
    vc.delegate = self;
    self.popoverViewController = vc;
    [self createNavigationController];
  }
  return self;
}

- (void)setToDoListItem:(ToDoListItem *)toDoListItem {
  [super setToDoListItem:toDoListItem];
  
  // Set the category in the popover
  ((ToDoListCategoryViewController *)self.popoverViewController).selectedCategory = toDoListItem.category;
  
  // Update the displayed text with the new value
  self.label.text = [toDoListItem categoryString];
}

#pragma mark PickerDelegate methods

// Called when the a new value has been selected in the picker
- (void)didSelectCategory:(ToDoListCategory)category {
  // Set the category
  self.toDoListItem.category = category;
  
  // Update the displayed text with the new value
  self.label.text = [self.toDoListItem categoryString];
  
  // Dismiss the popover
  [self.popover dismissPopoverAnimated:YES];
  self.popover = nil;
  
  // Call the didFinishEditingCellAtCoordinate method on the grid's delegate (if the method exists)
  if ([self.dataGrid.delegate respondsToSelector:@selector(shinobiDataGrid:didFinishEditingCellAtCoordinate:)]) {
    [self.dataGrid.delegate shinobiDataGrid:self.dataGrid didFinishEditingCellAtCoordinate:self.coordinate];
  }
}

@end
