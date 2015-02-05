//
//  ToDoListCheckboxCell.m
//  ToDoList
//
//  Created by Richard Doyle on 11/06/2013.
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

#import "ToDoListCheckboxCell.h"

@interface ToDoListCheckboxCell ()

@property (strong, nonatomic) UIImageView *checkbox;
@property (strong, nonatomic) UIImage *checkedImage;
@property (strong, nonatomic) UIImage *uncheckedImage;

@end

@implementation ToDoListCheckboxCell

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
  self = [super initWithReuseIdentifier:identifier];
  if (self) {
    
    self.checkedImage = [UIImage imageNamed:@"task_checkbox_checked"];
    self.uncheckedImage = [UIImage imageNamed:@"task_checkbox_unchecked"];
    
    // Initialise the checkbox with the off image and the correct size.
    self.checkbox = [[UIImageView alloc] initWithImage:self.uncheckedImage];
    self.checkbox.userInteractionEnabled = YES;
    [self addSubview:self.checkbox];
    
    // Add a tap gesture recognizer that will toggle our check box on and off.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];
    [self.checkbox addGestureRecognizer:tapRecognizer];
  }
  return self;
}

- (void)setToDoListItem:(ToDoListItem *)toDoListItem {
  if (toDoListItem != _toDoListItem) {
    _toDoListItem = toDoListItem;
    [self updateImage];
  }
}

// This method is called when the cell is added to the grid. We need to take this opportunity
// to position our check box where we want it - in the center of our cell.
- (void)layoutSubviews {
  self.checkbox.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

// This is the method that will be called by our tap gesture recognizer on our check box.
- (void)toggle {
  // Toggle the item's complete state and update the image to match
  self.toDoListItem.complete = !self.toDoListItem.complete;
  [self updateImage];
}

- (void)updateImage {
  if (self.toDoListItem.complete) {
    self.checkbox.image = self.checkedImage;
  } else {
    self.checkbox.image = self.uncheckedImage;
  }
}

@end
