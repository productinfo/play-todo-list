//
//  ToDoListAbstractPopoverCell.h
//  ToDoList
//
//  Created by Alison Clarke on 13/08/2014.
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

#import <ShinobiGrids/ShinobiGrids.h>
#import "ToDoListAbstractPopoverViewController.h"

@interface ToDoListAbstractPopoverCell : SDataGridCell

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIPopoverController *popover;

@property (strong, nonatomic) ShinobiDataGrid *dataGrid;
@property (strong, nonatomic) ToDoListItem *toDoListItem;
@property (strong, nonatomic) ToDoListAbstractPopoverViewController *popoverViewController;

- (void)createNavigationController;

@end
