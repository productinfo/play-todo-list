//
//  AbstractEditViewController.m
//  ShinobiControls
//
//  Created by  on 19/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

#import "ToDoListAbstractPopoverViewController.h"

@implementation ToDoListAbstractPopoverViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = _pageTitle;
  
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(doneSelected:)];
  [self.navigationItem setRightBarButtonItem:rightButton];
}


- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  self.pageTitle = nil;
}

- (IBAction)doneSelected:(id)sender {
  // Blank implementation.  Children can override this
}

@end
