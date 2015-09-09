//
//  RefreshHeaderView.h
//  FlyRefreshDemo
//
//  Created by ddaajing on 8/31/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RATIO_Y(rect) (CGRectGetMaxY(rect) / 120.f)
#define RATIO_X(rect) (CGRectGetMaxX(rect) / 240.f)

@interface RefreshMoutainHeaderView : UIView

/**
 *  Parallax mountains and trees
 *
 *  @param offset ScrollView offset Y
 */
- (void)parallaxMoutainWithOffset:(CGFloat)offset;

@end
