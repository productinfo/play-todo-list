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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupGrid {
  // Create data source helper and its delegate
  self.delegate = [[ToDoListDataSourceHelperDelegate alloc] init];
  self.datasource = [[ToDoListDataSourceHelper alloc] initWithDataGrid:self.grid delegate:self.delegate];
  
  self.grid.canReorderRows = YES;
  self.grid.selectionMode = SDataGridSelectionModeCellSingle;
  
  // Add the columns to the grid
  [self createAndAddColumnWithTitle:nil
                        propertyKey:@"complete"
                              width:50
                           cellType:[ToDoListCheckboxCell class]
                            canSort:NO
                      textAlignment:NSTextAlignmentLeft];
  [self createAndAddColumnWithTitle:@"Task"
                        propertyKey:@"taskName"
                              width:442
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
