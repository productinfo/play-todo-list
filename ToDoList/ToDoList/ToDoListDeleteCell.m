//
//  ToDoListDeleteCell.m
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import "ToDoListDeleteCell.h"
#import "ToDoListDataSourceHelper.h"

@interface ToDoListDeleteCell()

@property (nonatomic, strong)  UIButton *deleteButton;
@property (nonatomic, strong)  UIImage *deleteIcon;
@property (nonatomic, strong)  UIImage *deleteIconPressed;

@end

@implementation ToDoListDeleteCell

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
  self = [super initWithReuseIdentifier:identifier];
  if (self) {
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteIcon = [UIImage imageNamed:@"delete_row"];
    self.deleteIconPressed = [UIImage imageNamed:@"delete_row_pressed"];
    
    self.deleteButton.frame = CGRectMake(0, 0, self.deleteIcon.size.width, self.deleteIcon.size.height);
    [self.deleteButton setImage:self.deleteIcon forState:UIControlStateNormal];
    [self.deleteButton setImage:self.deleteIconPressed forState:UIControlStateHighlighted];
    
    [self.deleteButton addTarget:self action:@selector(deleteRow) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
  }
  return self;
}

// This method is called when the cell is added to the grid. We resize the button so it's
// as big as the cell
- (void)layoutSubviews {
  self.deleteButton.frame = self.bounds;
}

- (void)deleteRow {
  ToDoListDataSourceHelper *dataSourceHelper = (ToDoListDataSourceHelper*)self.dataGrid.dataSource;
  [dataSourceHelper deleteItemInRow:self.coordinate.row.rowIndex];
}

@end
