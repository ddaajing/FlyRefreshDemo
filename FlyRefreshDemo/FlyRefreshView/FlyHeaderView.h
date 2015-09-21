//
//  FlyHeaderView
//
//  Created by ddaajing
//  Copyright (c) 2015年 dajing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshMoutainHeaderView.h"

typedef NS_ENUM(NSInteger, FLIGHT_STATUS) {
    FLIGHT_STATUS_SET_OFF,
    FLIGHT_STATUS_BACK,
    FLIGHT_STATUS_WHOLE,
};

@class FlyHeaderView;

@protocol FlyHeaderViewDelegate <NSObject>

@required
- (void)requestDataWithFlyHeaderView:(FlyHeaderView *)flyHeaderView;
- (void)didRecievedDataWithFlyHeaderView:(FlyHeaderView *)flyHeaderView;
- (void)didFinishedRefreshWithFlyHeaderView:(FlyHeaderView *)flyHeaderView;

@end

@interface FlyHeaderView : UIView

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, weak) id<FlyHeaderViewDelegate> delegate;

- (FlyHeaderView *)initWithTableViewAndHeaderHeight:(CGFloat)height;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)sendFlightBack;

@end
