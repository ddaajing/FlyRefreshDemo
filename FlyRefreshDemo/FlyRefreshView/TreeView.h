//
//  TreeView.h
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/6/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RATIO_TY(rect) (CGRectGetMaxY(rect) / 120.f)
#define RATIO_TX(rect) (CGRectGetMaxX(rect) / 40.f)

/**
 Tree on the mountain
 */
@interface TreeView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTrunkColor:(UIColor *)trunkColor andLeafColor:(UIColor *)leafColor;

/**
 *  Bend tree with wind
 *
 *  @param windForce wind force
 */
- (void)bendTreeWithWind:(CGFloat)windForce;

@end
