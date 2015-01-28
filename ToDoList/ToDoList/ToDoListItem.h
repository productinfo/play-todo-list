//
//  ToDoListItem.h
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

typedef NS_ENUM(NSInteger, ToDoListCategory) {
  Home,
  Office,
  Social,
  Personal,
  Holiday,
  NilCategory
};

@interface ToDoListItem : NSObject

@property (nonatomic, strong) NSString* taskName;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, assign) ToDoListCategory category;
@property (nonatomic, assign) BOOL complete;

- (instancetype)initWithTaskName:(NSString*)name dueDate:(NSDate*)date category:(ToDoListCategory)category
                        complete:(BOOL)complete;

- (NSString*)categoryString;

// Returns an array of category names whose indices map to the ToDoListCategory enum
+ (NSArray*)categoryStrings;
+ (NSString*)categoryToString:(ToDoListCategory)category;

@end
