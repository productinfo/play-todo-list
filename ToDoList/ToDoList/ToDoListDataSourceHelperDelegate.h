//
//  ToDoListDelegate.h
//  ShinobiPlay
//
//  Created by Richard Doyle on 11/06/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

@import Foundation;
#import <ShinobiGrids/ShinobiDataGrid.h>

@interface ToDoListDataSourceHelperDelegate : NSObject <SDataGridDataSourceHelperDelegate>

@property (nonatomic, assign) BOOL newRowAdded;

@end
