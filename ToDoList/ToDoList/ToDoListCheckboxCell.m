//
//  ToDoListCompleteCell.m
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
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
  _toDoListItem = toDoListItem;
  [self updateImage];
}

// This method is called when the cell is added to the grid. We need to take this opportunity
// to position our check box where we want it - in the center of our cell.
-(void)layoutSubviews {
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
