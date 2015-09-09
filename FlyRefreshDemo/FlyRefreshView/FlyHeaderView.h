//
//  FlyHeaderView
//
//  Created by ddaajing
//  Copyright (c) 2015年 dajing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshMoutainHeaderView.h"

@interface FlyHeaderView : UIView

@property (nonatomic, strong) UITableView* tableView;

- (FlyHeaderView *)initWithTableViewAndHeaderHeight:(CGFloat)height;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

@end
