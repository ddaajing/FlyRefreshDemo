//
//  RefreshHeaderView.m
//  FlyRefreshDemo
//
//  Created by ddaajing on 8/31/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import "RefreshMountainHeaderView.h"
#import "TreeView.h"

@interface RefreshMoutainHeaderView ()

@property (nonatomic, strong) CAShapeLayer *mostFarMountainLayer;
@property (nonatomic, strong) CAShapeLayer *moreFarMountainLayer;
@property (nonatomic, strong) CAShapeLayer *nearByMountainLayer;

@property (nonatomic, strong) UIColor *mostFarColor;
@property (nonatomic, strong) UIColor *moreFarColor;
@property (nonatomic, strong) UIColor *nearByColor;

@property (nonatomic, assign) CGRect originalFrame;

@property (nonatomic, strong) TreeView *middleTree;
@property (nonatomic, strong) TreeView *leftTree;
@property (nonatomic, strong) TreeView *rightTree;
@property (nonatomic, strong) TreeView *leftFarTree;
@property (nonatomic, strong) TreeView *rightFarTree;

@end

@implementation RefreshMoutainHeaderView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.originalFrame = frame;
        self.backgroundColor = [UIColor colorWithRed:0.502 green:0.792 blue:0.725 alpha:1.000];
        self.clipsToBounds = YES;

        [self configSubviewsWithFrame:frame];
    }
    return self;
}

#pragma mark - getter & setter
- (UIColor *)mostFarColor {
    if (!_mostFarColor) {
        _mostFarColor = [UIColor colorWithRed: 0.482 green: 0.847 blue: 0.875 alpha: 1];
    }
    return _mostFarColor;
}

- (UIColor *)moreFarColor {
    if (!_moreFarColor) {
        _moreFarColor = [UIColor colorWithRed: 0.2 green: 0.565 blue: 0.604 alpha: 1];
    }
    return _moreFarColor;
}

- (UIColor *)nearByColor {
    if (!_nearByColor) {
        _nearByColor = [UIColor colorWithRed: 0.192 green: 0.333 blue: 0.353 alpha: 1];
    }
    return _nearByColor;
}

- (CAShapeLayer *)mostFarMountainLayer {
    if(!_mostFarMountainLayer) {
        _mostFarMountainLayer = [CAShapeLayer layer];
        _mostFarMountainLayer.frame = self.bounds;
        _mostFarMountainLayer.fillColor = self.mostFarColor.CGColor;
        _mostFarMountainLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_mostFarMountainLayer setStrokeColor:self.mostFarColor.CGColor];
        [_mostFarMountainLayer setLineWidth:1];
    }
    return _mostFarMountainLayer;
}

- (CAShapeLayer *)moreFarMountainLayer {
    if(!_moreFarMountainLayer) {
        _moreFarMountainLayer = [CAShapeLayer layer];
        _moreFarMountainLayer.frame = self.bounds;
        _moreFarMountainLayer.fillColor = self.moreFarColor.CGColor;
        _moreFarMountainLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_moreFarMountainLayer setStrokeColor:self.moreFarColor.CGColor];
        [_moreFarMountainLayer setLineWidth:1];
    }
    return _moreFarMountainLayer;
}

- (CAShapeLayer *)nearByMountainLayer {
    if(!_nearByMountainLayer) {
        _nearByMountainLayer = [CAShapeLayer layer];
        _nearByMountainLayer.frame = self.bounds;
        _nearByMountainLayer.fillColor = self.nearByColor.CGColor;
        _nearByMountainLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_nearByMountainLayer setStrokeColor:self.nearByColor.CGColor];
        [_nearByMountainLayer setLineWidth:1];
    }
    return _nearByMountainLayer;
}

- (TreeView *)middleTree {
    if (!_middleTree) {
        _middleTree = [[TreeView alloc] initWithFrame:CGRectMake(260.f / 375.f * SCREEN_WIDTH, 82.f, 30, 120) andTrunkColor:self.nearByColor andLeafColor:[UIColor colorWithRed:0.240 green:0.415 blue:0.442 alpha:1.000]];
    }
    return _middleTree;
}

- (TreeView *)leftTree {
    if (!_leftTree) {
        _leftTree = [[TreeView alloc] initWithFrame:CGRectMake(235.f / 375.f * SCREEN_WIDTH, 100.f, 15, 90) andTrunkColor:[UIColor colorWithRed:0.254 green:0.439 blue:0.467 alpha:1.000] andLeafColor:self.moreFarColor];
    }
    return _leftTree;
}

- (TreeView *)rightTree {
    if (!_rightTree) {
        _rightTree = [[TreeView alloc] initWithFrame:CGRectMake(300.f / 375.f * SCREEN_WIDTH, 105.f, 15, 90) andTrunkColor:[UIColor colorWithRed:0.254 green:0.439 blue:0.467 alpha:1.000] andLeafColor:self.moreFarColor];
    }
    return _rightTree;
}

- (TreeView *)leftFarTree {
    if (!_leftFarTree) {
        _leftFarTree = [[TreeView alloc] initWithFrame:CGRectMake(50 / 375.f * SCREEN_WIDTH, 103.f, 15, 70) andTrunkColor:[UIColor colorWithRed:0.383 green:0.662 blue:0.705 alpha:1.000] andLeafColor:self.moreFarColor];
    }
    return _leftFarTree;
}

- (TreeView *)rightFarTree {
    if (!_rightFarTree) {
        _rightFarTree = [[TreeView alloc] initWithFrame:CGRectMake(70 / 375.f * SCREEN_WIDTH, 82.f, 13, 90) andTrunkColor:[UIColor colorWithRed:0.383 green:0.662 blue:0.705 alpha:1.000] andLeafColor:self.moreFarColor];
    }
    return _rightFarTree;
}

- (void)configSubviewsWithFrame:(CGRect)frame {
    // most far mountain
    CGMutablePathRef mostFarMoutainpPath = [self mostFarPathWithOffset:0];
    self.mostFarMountainLayer.path = mostFarMoutainpPath;
    [self.layer addSublayer:self.mostFarMountainLayer];
    CFRelease(mostFarMoutainpPath);
    
    // more far mountain
    CGMutablePathRef moreFarMoutainpPath = [self moreFarPathWithOffset:0];
    self.moreFarMountainLayer.path = moreFarMoutainpPath;
    [self.layer addSublayer:self.moreFarMountainLayer];
    CFRelease(moreFarMoutainpPath);

    // nearby mountain
    CGMutablePathRef nearbyMoutainpPath = [self nearPathWithOffset:0];
    self.nearByMountainLayer.path = nearbyMoutainpPath;
    [self.layer addSublayer:self.nearByMountainLayer];
    CFRelease(nearbyMoutainpPath);

    // right region trees
    [self addSubview:self.leftTree];
    [self addSubview:self.middleTree];
    [self addSubview:self.rightTree];
    
    // left region trees
    [self addSubview:self.leftFarTree];
    [self addSubview:self.rightFarTree];
}

#pragma mark - mountains path
- (CGMutablePathRef)mostFarPathWithOffset:(CGFloat)offset {
    CGRect rect = self.originalFrame;

    CGMutablePathRef mostFarMoutainpPath = CGPathCreateMutable();
    CGPathMoveToPoint(mostFarMoutainpPath, NULL, 0, 64 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 58 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
    
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 58 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 143 * RATIO_X(rect), 64 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 215 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 240 * RATIO_X(rect), 53 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 0, 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(mostFarMoutainpPath, NULL, 0, 64 * RATIO_Y(rect) + offset);
    CGPathCloseSubpath(mostFarMoutainpPath);
    return mostFarMoutainpPath;
}

- (CGMutablePathRef)moreFarPathWithOffset:(CGFloat)offset {
    CGRect rect = self.originalFrame;
    CGMutablePathRef moreFarMoutainpPath = CGPathCreateMutable();
    CGPathMoveToPoint(moreFarMoutainpPath, NULL, 0, 75 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 72 * RATIO_X(rect), 58 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 187 * RATIO_X(rect), 85 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 218 * RATIO_X(rect), 58 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 240 * RATIO_X(rect), 75 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 0, 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(moreFarMoutainpPath, NULL, 0, 75 * RATIO_Y(rect) + offset);
    CGPathCloseSubpath(moreFarMoutainpPath);

    return moreFarMoutainpPath;
}

- (CGMutablePathRef)nearPathWithOffset:(CGFloat)offset {
    CGRect rect = self.originalFrame;
    
    CGMutablePathRef nearbyMoutainpPath = CGPathCreateMutable();
    CGPathMoveToPoint(nearbyMoutainpPath, NULL, 240 * RATIO_X(rect), 88 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(nearbyMoutainpPath, NULL, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(nearbyMoutainpPath, NULL, 0, 120 * RATIO_Y(rect) + offset);
    CGPathAddLineToPoint(nearbyMoutainpPath, NULL, 0, 88 * RATIO_Y(rect) + offset);
    CGPathAddCurveToPoint(nearbyMoutainpPath, NULL, 0, 88 * RATIO_Y(rect) + offset, 190 * RATIO_X(rect), 50 * RATIO_Y(rect) + offset, 240 * RATIO_X(rect), 88 * RATIO_Y(rect) + offset);
    CGPathCloseSubpath(nearbyMoutainpPath);

    return nearbyMoutainpPath;
}

- (void)parallaxMoutainWithOffset:(CGFloat)offset {
    CGMutablePathRef mostFarMoutainpPath = [self mostFarPathWithOffset:offset * 1.3];
    CGMutablePathRef moreFarMoutainpPath = [self moreFarPathWithOffset:offset * 1.2];
    CGMutablePathRef nearbyMoutainpPath = [self nearPathWithOffset:offset * 1.3];
    
    self.mostFarMountainLayer.path = mostFarMoutainpPath;
    CFRelease(mostFarMoutainpPath);
    
    self.moreFarMountainLayer.path = moreFarMoutainpPath;
    CFRelease(moreFarMoutainpPath);

    self.nearByMountainLayer.path = nearbyMoutainpPath;
    CFRelease(nearbyMoutainpPath);
    
    // move trees downside by offset
    self.leftTree.frame = CGRectMake(self.leftTree.frame.origin.x, 100.f + offset * 1.3, self.leftTree.frame.size.width, self.leftTree.frame.size.height);
    self.middleTree.frame = CGRectMake(self.middleTree.frame.origin.x, 82.f + offset * 1.3, self.middleTree.frame.size.width, self.middleTree.frame.size.height);
    self.rightTree.frame = CGRectMake(self.rightTree.frame.origin.x, 105.f + offset * 1.3, self.rightTree.frame.size.width, self.rightTree.frame.size.height);

    self.leftFarTree.frame = CGRectMake(self.leftFarTree.frame.origin.x, 103.f + offset * 1.2, self.leftFarTree.frame.size.width, self.leftFarTree.frame.size.height);
    self.rightFarTree.frame = CGRectMake(self.rightFarTree.frame.origin.x, 82.f + offset * 1.2, self.rightFarTree.frame.size.width, self.rightFarTree.frame.size.height);

    // bend trees
    [self.leftTree bendTreeWithWind:MIN(50, offset) / 50 * 8.f];
    [self.middleTree bendTreeWithWind:MIN(50, offset) / 50 * 8.f];
    [self.rightTree bendTreeWithWind:MIN(50, offset) / 50 * 8.f];
    
    [self.leftFarTree bendTreeWithWind:MIN(50, offset) / 50 * 8.f];
    [self.rightFarTree bendTreeWithWind:MIN(50, offset) / 50 * 8.f];
}

@end
