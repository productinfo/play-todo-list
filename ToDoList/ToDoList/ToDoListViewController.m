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
#import "ShinobiPlayUtils/UIFont+SPUFont.h"
#import "ShinobiPlayUtils/UIColor+SPUColor.h"

@interface ToDoListViewController ()

@property (strong, nonatomic) IBOutlet UIButton *addNewButton;

@property (strong, nonatomic) ToDoListDataSourceHelper *datasource;
@property (strong, nonatomic) ToDoListDataSourceHelperDelegate *delegate;

@end

@implementation ToDoListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	
  [self setupGrid];
  self.addNewButton.center = CGPointMake(CGRectGetMaxX(self.grid.frame) - (CGRectGetWidth(self.addNewButton.frame) / 2),
                                         CGRectGetMinY(self.grid.frame) - (CGRectGetHeight(self.addNewButton.frame) / 2));
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupGrid {
  SDataGridTheme *theme = [SDataGridiOS7Theme new];
  
  theme.headerRowStyle.textVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  theme.headerRowStyle.font = [UIFont boldShinobiFontOfSize:20];
  theme.headerRowStyle.textColor = [UIColor shinobiDarkGrayColor];
  theme.headerRowStyle.backgroundColor = [[UIColor shinobiPlayGreenColor] shinobiBackgroundColor];
  
  theme.rowStyle.font = [UIFont boldShinobiFontOfSize:16];
  theme.rowStyle.textColor = [UIColor shinobiDarkGrayColor];
  theme.alternateRowStyle = theme.rowStyle;
  
  theme.selectedCellStyle.backgroundColor = [[UIColor shinobiPlayGreenColor] shinobiLightColor];
  theme.selectedCellStyle.textColor = [UIColor shinobiDarkGrayColor];
  theme.selectedCellStyle.font = theme.rowStyle.font;
  
  [self.grid applyTheme:theme];
  
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
  return @[[[ToDoListItem alloc] initWithTaskName:@"Pick up milk"
                                          dueDate:today
                                         category:Home
                                         complete:YES],
           [[ToDoListItem alloc] initWithTaskName:@"Mow the lawn"
                                          dueDate:tomorrow
                                         category:Home
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Buy birthday present for John"
                                          dueDate:tomorrow
                                         category:Social
                                         complete:YES],
           [[ToDoListItem alloc] initWithTaskName:@"Dinner with Jane @ 7pm"
                                          dueDate:tomorrow
                                         category:Social
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Phone Mum"
                                          dueDate:inAWeek
                                         category:Social
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Prepare presentation for next week"
                                          dueDate:inAWeek
                                         category:Office complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Set up out-of-office"
                                          dueDate:inTenDays
                                         category:Office
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Doctors appointment @ 9am"
                                          dueDate:inFourWeeks
                                         category:Personal
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Buy foreign currency"
                                          dueDate:inTwoWeeks
                                         category:Holiday
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Buy sun cream"
                                          dueDate:inTwoWeeks
                                         category:Holiday
                                         complete:NO],
           [[ToDoListItem alloc] initWithTaskName:@"Packing"
                                          dueDate:inTwoWeeks
                                         category:Holiday
                                         complete:NO]
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
