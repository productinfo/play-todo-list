//
//  ToDoListPopoverCell.m
//  ToDoList
//
//  Created by Alison Clarke on 13/08/2014.
//  Copyright (c) 2014 Alison Clarke. All rights reserved.
//

#import "ToDoListAbstractPopoverCell.h"

@interface ToDoListAbstractPopoverCell ()

@end

@implementation ToDoListAbstractPopoverCell

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
  if (self = [super initWithReuseIdentifier:identifier]) {
    // Add a label
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.label];
  }
  return self;
}

// Create a navigation controller to contain the edit view controller
- (void)createNavigationController {
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.popoverViewController];
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  // Set up the label's frame so it's inset by 20px from left/right and 10px from top/bottom
  self.label.frame = CGRectInset(self.bounds, 20, 10);
}

- (void)applyStyle:(SDataGridCellStyle *)style {
  [super applyStyle:style];
  self.label.font = style.font;
  self.label.textColor = style.textColor;
  self.label.textAlignment = style.textAlignment;
}

#pragma mark SGridEventResponder methods

// Called when the grid's edit event is triggered on this cell
- (void)respondToEditEvent {
  // We need to call the grid's delegate methods for editing cells before doing any more
  
  // Call the shouldBeginEditingCellAtCoordinate method on the grid's delegate (if the method exists)
  if ([self.dataGrid.delegate respondsToSelector:@selector(shinobiDataGrid:shouldBeginEditingCellAtCoordinate:)]) {
    if([self.dataGrid.delegate shinobiDataGrid:self.dataGrid shouldBeginEditingCellAtCoordinate:self.coordinate] == NO) {
      return;
    }
  }
  
  // Call the willBeginEditingCellAtCoordinate method on the grid's delegate (if the method exists)
  if ([self.dataGrid.delegate respondsToSelector:@selector(shinobiDataGrid:willBeginEditingCellAtCoordinate:)]) {
    [self.dataGrid.delegate shinobiDataGrid:self.dataGrid willBeginEditingCellAtCoordinate:self.coordinate];
  }
  
  // Finally create and display the popover
  self.popover = [[UIPopoverController alloc] initWithContentViewController:self.navigationController];
  [self.popover setPopoverContentSize:CGSizeMake(300, 250) animated:NO];
  [self.popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny
                              animated:YES];
}

@end
