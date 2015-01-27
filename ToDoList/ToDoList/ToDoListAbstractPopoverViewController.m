//
//  AbstractEditViewController.m
//  ShinobiControls
//
//  Created by  on 19/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
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
