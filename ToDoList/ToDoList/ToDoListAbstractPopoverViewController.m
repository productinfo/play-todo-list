//
//  ToDoListAbstractPopoverViewController.m
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

#import "ToDoListAbstractPopoverViewController.h"
#import "ShinobiPlayUtils/UIColor+SPUColor.h"
#import "ShinobiPlayUtils/UIFont+SPUFont.h"

@implementation ToDoListAbstractPopoverViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = self.pageTitle;
  NSDictionary *titleAttributes = @{ NSFontAttributeName : [UIFont boldShinobiFontOfSize:18],
                                NSForegroundColorAttributeName : [UIColor shinobiDarkGrayColor] };
  [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(doneSelected:)];
  NSDictionary *buttonTitleAttributes = @{ NSFontAttributeName : [UIFont boldShinobiFontOfSize:16],
                                          NSForegroundColorAttributeName : [UIColor shinobiDarkGrayColor] };
  [rightButton setTitleTextAttributes:buttonTitleAttributes forState:UIControlStateNormal];
  [self.navigationItem setRightBarButtonItem:rightButton];
}

- (IBAction)doneSelected:(id)sender {
  // Blank implementation.  Children can override this
}

@end
