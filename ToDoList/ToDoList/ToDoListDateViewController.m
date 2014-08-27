//
//  EditDateViewController.m
//  ShinobiControls
//
//  Created by  on 18/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

#import "ToDoListDateViewController.h"

@interface ToDoListDateViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ToDoListDateViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.pageTitle = @"Edit Date";
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (!self.selectedDate || [self.selectedDate isEqualToDate:[NSDate distantPast]]) {
    self.datePicker.date = [NSDate date];
  } else {
    self.datePicker.date = self.selectedDate;
  }
}

- (void)viewDidUnload {
  [self setDatePicker:nil];
  [super viewDidUnload];
}

- (IBAction)doneSelected:(id)sender {
  self.selectedDate = self.datePicker.date;
  [self.delegate didSelectDate:self.selectedDate];
}

@end
