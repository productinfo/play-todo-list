//
//  ToDoListViewController.m
//  ToDoList
//
//  Created by Alison Clarke on 11/08/2014.
//  Copyright (c) 2014 Alison Clarke. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoListDataSourceHelper.h"
#import "ToDoListDataSourceHelperDelegate.h"
#import "ToDoListCheckboxCell.h"
#import "ToDoListCategoryCell.h"
#import "ToDoListDateCell.h"
#import "ToDoListDeleteCell.h"
#import "ToDoListItem.h"

@interface ToDoListViewController ()

@property (strong, nonatomic) IBOutlet UIButton *addNewButton;

@property (strong, nonatomic) ToDoListDataSourceHelper *datasource;
@property (strong, nonatomic) ToDoListDataSourceHelperDelegate *delegate;

@end

@implementation ToDoListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	
  [self setupGrid];
  [self.addNewButton setCenter:CGPointMake(CGRectGetMaxX(self.grid.frame) - (CGRectGetWidth(self.addNewButton.frame) / 2),
                                           CGRectGetMinY(self.grid.frame) - (CGRectGetHeight(self.addNewButton.frame) / 2))];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupGrid {
  // Create data source helper and its delegate
  self.delegate = [[ToDoListDataSourceHelperDelegate alloc] init];
  NSArray *data = [self createToDoListItems];
  self.datasource = [[ToDoListDataSourceHelper alloc] initWithDataGrid:self.grid
                                                              delegate:self.delegate
                                                                  data:data];
  
  self.grid.canReorderRows = YES;
  self.grid.defaultRowHeight = @45;
  
  // Add the columns to the grid
  [self createAndAddColumnWithTitle:nil
                        propertyKey:@"complete"
                              width:50
                           cellType:[ToDoListCheckboxCell class]
                            canSort:NO
                      textAlignment:NSTextAlignmentLeft];
  [self createAndAddColumnWithTitle:@"Task"
                        propertyKey:@"taskName"
                              width:326
                           cellType:[SDataGridTextCell class]
                            canSort:YES
                      textAlignment:NSTextAlignmentLeft];
  [self createAndAddColumnWithTitle:@"Due"
                        propertyKey:@"dueDate"
                              width:170
                           cellType:[ToDoListDateCell class]
                            canSort:YES
                      textAlignment:NSTextAlignmentLeft];
  [self createAndAddColumnWithTitle:@"Category"
                        propertyKey:@"category"
                              width:210
                           cellType:[ToDoListCategoryCell class]
                            canSort:YES
                      textAlignment:NSTextAlignmentLeft];
  [self createAndAddColumnWithTitle:nil
                        propertyKey:@"delete"
                              width:50
                           cellType:[ToDoListDeleteCell class]
                            canSort:NO
                      textAlignment:NSTextAlignmentLeft];
  
  [self.grid reload];
}

- (IBAction)addNewToDoListItem:(id)sender {
  [self.datasource createNewToDoListItem];
}

- (void)keyboardWillShow:(id)sender {
  self.addNewButton.enabled = NO;
}

- (void)keyboardWillHide:(id)sender {
  self.addNewButton.enabled = YES;
}

#pragma mark - Utility methods

- (NSArray *)createToDoListItems {
  // Create some due dates
  NSDate *today = [[NSDate alloc] init];
  NSDate *tomorrow = [today dateByAddingTimeInterval:24 * 60 * 60];
  NSDate *inAWeek = [today dateByAddingTimeInterval:7 * 24 * 60 * 60];
  NSDate *inTenDays = [today dateByAddingTimeInterval:10 * 24 * 60 * 60];
  NSDate *inTwoWeeks = [today dateByAddingTimeInterval:2 * 7 * 24 * 60 * 60];
  NSDate *inFourWeeks = [today dateByAddingTimeInterval:4 * 7 * 24 * 60 * 60];
  
  // Create some items
  return @[[[ToDoListItem alloc] initWithTaskName:@"Pick up milk" dueDate:today category:Home],
           [[ToDoListItem alloc] initWithTaskName:@"Mow the lawn" dueDate:tomorrow category:Home],
           [[ToDoListItem alloc] initWithTaskName:@"Buy birthday present for John" dueDate:tomorrow category:Social],
           [[ToDoListItem alloc] initWithTaskName:@"Dinner with Jane @ 7pm" dueDate:tomorrow category:Social],
           [[ToDoListItem alloc] initWithTaskName:@"Phone Mum" dueDate:inAWeek category:Social],
           [[ToDoListItem alloc] initWithTaskName:@"Prepare presentation for next week" dueDate:inAWeek category:Office],
           [[ToDoListItem alloc] initWithTaskName:@"Set up out-of-office" dueDate:inTenDays category:Office],
           [[ToDoListItem alloc] initWithTaskName:@"Doctors appointment @ 9am" dueDate:inFourWeeks category:Personal],
           [[ToDoListItem alloc] initWithTaskName:@"Buy foreign currency" dueDate:inTwoWeeks category:Holiday],
           [[ToDoListItem alloc] initWithTaskName:@"Buy sun cream" dueDate:inTwoWeeks category:Holiday],
           [[ToDoListItem alloc] initWithTaskName:@"Packing" dueDate:inTwoWeeks category:Holiday]
          ];
}

- (void)createAndAddColumnWithTitle:(NSString*)title propertyKey:(NSString*)propertyKey
                              width:(NSInteger)width cellType:(Class)cellType canSort:(BOOL)canSort
                      textAlignment:(NSTextAlignment)alignment {
  SDataGridColumn *column = [SDataGridColumn columnWithTitle:title];
  column.propertyKey = propertyKey;
  column.width = @(width);
  column.cellType = cellType;
  column.canReorderViaLongPress = YES;
  column.editable = YES;
  if (canSort) {
    column.sortMode = SDataGridColumnSortModeTriState;
  }
  column.cellStyle.textAlignment = alignment;
  [self.grid addColumn:column];
}

@end
