//
//  EditCategoryViewController.m
//  ShinobiControls
//
//  Created by  on 19/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

#import "ToDoListCategoryViewController.h"

@interface ToDoListCategoryViewController ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) IBOutlet UIPickerView *categoryPicker;

@end

@implementation ToDoListCategoryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.pageTitle = @"Edit Category";
    self.categories = [ToDoListItem categoryStrings];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.categoryPicker selectRow:self.selectedCategory inComponent:0 animated:NO];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return self.categories[row];
}

- (IBAction)doneSelected:(id)sender {
  NSInteger selectedIndex = [self.categoryPicker selectedRowInComponent:0];
  [self.delegate didSelectCategory:selectedIndex];
}

@end
