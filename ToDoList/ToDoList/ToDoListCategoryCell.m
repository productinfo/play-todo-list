//
//  ToDoListCategoryCell.m
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
