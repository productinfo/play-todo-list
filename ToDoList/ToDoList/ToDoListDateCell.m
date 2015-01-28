//
//  ToDoListDateCell.m
//  ToDoList
//
//  Created by Alison Clarke on 13/08/2014.
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

#import "ToDoListDateCell.h"

static NSDateFormatter *ToDoListDateFormatter = nil;

@implementation ToDoListDateCell

+ (void)initialize {
  ToDoListDateFormatter = [[NSDateFormatter alloc] init];
  [ToDoListDateFormatter setDateStyle:NSDateFormatterMediumStyle];
}

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
  if (self = [super initWithReuseIdentifier:identifier]) {
    // Create a editCategoryViewController ready to display when in edit mode
    ToDoListDateViewController *vc = [[ToDoListDateViewController alloc] initWithNibName:@"ToDoListDatePopover"
                                                                                  bundle:nil];
    vc.delegate = self;
    self.popoverViewController = vc;
    [self createNavigationController];
  }
  return self;
}

- (void)setToDoListItem:(ToDoListItem *)toDoListItem {
  [super setToDoListItem:toDoListItem];
  
  ((ToDoListDateViewController *)self.popoverViewController).selectedDate = self.toDoListItem.dueDate;
  [self updateDateLabel];
}

- (void)updateDateLabel {
  if ([self.toDoListItem.dueDate isEqualToDate:[NSDate distantPast]]) {
    self.label.text = @"-";
  } else {
    self.label.text = [ToDoListDateFormatter stringFromDate:self.toDoListItem.dueDate];
  }
}

- (void)didSelectDate:(NSDate *)date {
  // Set the new date on the item
  [self.toDoListItem setDueDate:date];
  
  // Update the label
  [self updateDateLabel];
  
  // Dismiss the popover
  [self.popover dismissPopoverAnimated:YES];
  self.popover = nil;
  
  // Call the didFinishEditingCellAtCoordinate method on the grid's delegate (if the method exists)
  if ([self.dataGrid.delegate respondsToSelector:@selector(shinobiDataGrid:didFinishEditingCellAtCoordinate:)]) {
    [self.dataGrid.delegate shinobiDataGrid:self.dataGrid didFinishEditingCellAtCoordinate:self.coordinate];
  }
}

@end
