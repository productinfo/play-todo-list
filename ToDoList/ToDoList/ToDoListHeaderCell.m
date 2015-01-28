//
//  ToDoListHeaderCell.m
//  ToDoList
//
//  Created by Daniel Allsop on 13/01/2015.
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

#import "ToDoListHeaderCell.h"

@interface ToDoListHeaderCell ()

@property UIImageView *arrowView;

@end

@implementation ToDoListHeaderCell

- (void)showArrowForSortOrder:(SDataGridColumnSortOrder)sortOrder sortMode:(SDataGridColumnSortMode)sortMode {
  // Remove old arrow
  [self.arrowView removeFromSuperview];
  
  if ((sortMode == SDataGridColumnSortModeBiState) || (sortMode == SDataGridColumnSortModeTriState)) {
    UIImage *arrow;
    
    if (sortOrder == SDataGridColumnSortOrderAscending) {
      arrow = [UIImage imageNamed:@"sort_up"];
    } else if (sortOrder == SDataGridColumnSortOrderDescending) {
      arrow = [UIImage imageNamed:@"sort_down"];
    } else {
      arrow = [UIImage imageNamed:@"no_sort"];
    }
    
    // Create view from image and position at right middle of cell
    self.arrowView = [[UIImageView alloc] initWithImage:arrow];
    self.arrowView.center = CGPointMake(self.frame.size.width - 20,
                                        self.frame.size.height / 2);
    [self addSubview:self.arrowView];
  }
}

@end
