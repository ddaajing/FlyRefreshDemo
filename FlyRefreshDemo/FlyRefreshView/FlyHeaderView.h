//
//  FlyHeaderView
//
//  Created by ddaajing
//  Copyright (c) 2015年 dajing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshMoutainHeaderView.h"

@protocol FlyHeaderViewDelegate <NSObject>

- (void)refreshData;
- (void)animationDidFinished;

@end

@interface FlyHeaderView : UIView

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, weak) id<FlyHeaderViewDelegate> delegate;

- (FlyHeaderView *)initWithTableViewAndHeaderHeight:(CGFloat)height;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

@end
