//
//  ToDoListDateViewController.m
//  ToDoList
//
//  Created by Alison Clarke on 12/08/2014.
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
