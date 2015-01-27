//
//  ToDoListItem.h
//  ShinobiControls
//
//  Created by  on 15/06/2012.
//  Copyright (c) 2012 Scott Logic. All rights reserved.
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
