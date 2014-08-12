//
//  EditDateViewController.h
//  ShinobiControls
//
//  Created by  on 18/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

@import UIKit;
#import <ShinobiGrids/ShinobiGrid.h>
#import "ToDoListAbstractPopoverViewController.h"

@protocol ToDoListDatePickerDelegate<NSObject>
@required
-(void)didSelectDate:(NSDate *)date;
@end

@interface ToDoListDateViewController : ToDoListAbstractPopoverViewController

@property (nonatomic, weak) id<ToDoListDatePickerDelegate> delegate;
@property (strong, nonatomic) NSDate *selectedDate;

@end
