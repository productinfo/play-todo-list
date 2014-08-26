//
//  EditCategoryViewController.h
//  ShinobiControls
//
//  Created by  on 19/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
//

@import UIKit;
#import "ToDoListAbstractPopoverViewController.h"
#import "ToDoListItem.h"

@protocol ToDoListPickerDelegate<NSObject>
@required
- (void)didSelectCategory:(ToDoListCategory)category;
@end

@interface ToDoListCategoryViewController : ToDoListAbstractPopoverViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<ToDoListPickerDelegate> delegate;
@property (nonatomic, assign) ToDoListCategory selectedCategory;

@end
