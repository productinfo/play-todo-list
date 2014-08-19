//
//  ToDoListViewController.h
//  ToDoList
//
//  Created by Alison Clarke on 11/08/2014.
//  Copyright (c) 2014 Alison Clarke. All rights reserved.
//

@import UIKit;
#import "ShinobiPlayUtils/SPUGalleryManagedViewController.h"
#import <ShinobiGrids/ShinobiGrids.h>

@interface ToDoListViewController : SPUGalleryManagedViewController

@property (strong, nonatomic) IBOutlet ShinobiDataGrid *grid;

@end
