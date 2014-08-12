//
//  AbstractEditViewController.h
//  ShinobiControls
//
//  Created by  on 19/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

@import UIKit;
#import "ToDoListItem.h"
#import <ShinobiGrids/ShinobiDataGrid.h>

@interface ToDoListAbstractPopoverViewController : UIViewController

@property (nonatomic, strong) NSString* pageTitle;

- (IBAction)doneSelected:(id)sender;

@end
