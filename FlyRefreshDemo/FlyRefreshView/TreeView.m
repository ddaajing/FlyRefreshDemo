//
//  TreeView.m
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/6/15.
//  Copyright (c) 2015 ddaajing. All rights reserved.
//

#import "TreeView.h"

@interface TreeView ()

/**
 *  keep the original frame, it will be used when dragging
 */
@property (nonatomic, assign) CGRect originalFrame;

// trunk layer
@property (nonatomic, strong) CAShapeLayer *trunkLayer;

// leaf layer
@property (nonatomic, strong) CAShapeLayer *leafLayer;

// trunk fill color
@property (nonatomic, strong) UIColor *trunkFillColor;

// leaf fill color
@property (nonatomic, strong) UIColor *leafFillColor;

@end

@implementation TreeView

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame andTrunkColor:(UIColor *)trunkColor andLeafColor:(UIColor *)leafColor {    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        self.originalFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.trunkFillColor = trunkColor;
        self.leafFillColor = leafColor;
    
        [self configSubviewsWithFrame:frame];
    }
    return self;
}

#pragma setter & getter
- (CAShapeLayer *)leafLayer {
    if(!_leafLayer) {
        _leafLayer = [CAShapeLayer layer];
        _leafLayer.frame = self.bounds;
        _leafLayer.fillColor = self.leafFillColor.CGColor;
        _leafLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_leafLayer setStrokeColor:[UIColor clearColor].CGColor];
        [_leafLayer setLineWidth:1];
    }
    return _leafLayer;
}

- (CAShapeLayer *)trunkLayer {
    if(!_trunkLayer) {
        _trunkLayer = [CAShapeLayer layer];
        _trunkLayer.frame = self.bounds;
        _trunkLayer.fillColor = self.trunkFillColor.CGColor;
        _trunkLayer.backgroundColor = [UIColor clearColor].CGColor;
        [_trunkLayer setStrokeColor:self.trunkFillColor.CGColor];
        [_trunkLayer setLineWidth:3 / 30.f * self.bounds.size.width];
    }
    return _trunkLayer;
}

- (void)configSubviewsWithFrame:(CGRect)frame {
    // leaf layer
    CGMutablePathRef leafLayerPath = [self leafPathWithOffset:0 andWindForce:0];
    self.leafLayer.path = leafLayerPath;
    [self.layer addSublayer:self.leafLayer];
    CFRelease(leafLayerPath);
    
    // trunk layer
    CGMutablePathRef trunkLayer = [self trunkPathWithOffset:0];
    self.trunkLayer.path = trunkLayer;
    [self.layer addSublayer:self.trunkLayer];
    CFRelease(trunkLayer);
}

/**
 *  Leaf of the tree
 *
 *  @param offset Horizontal line offset Y
 *  @param windForce wind force
 *
 *  @return leaf path
 */
- (CGMutablePathRef)leafPathWithOffset:(CGFloat)offset andWindForce:(CGFloat)windForce {
    CGRect rect = self.originalFrame;
    
//    NSLog(@"y position is %f", 19 * RATIO_TX(rect));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset);
    
    CGPathAddCurveToPoint(path, NULL, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset, 46.5 * RATIO_TX(rect), 81.5 * RATIO_TY(rect) + offset, 33.5 * RATIO_TX(rect), 48.5 * RATIO_TY(rect) + offset);
    
    // to point and cp2 will be updated when dragging
    CGPathAddCurveToPoint(path, NULL, 20.5 * RATIO_TX(rect), 15.5 * RATIO_TY(rect) + offset, (20.5 + windForce) * RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset, (20.5 + windForce) * RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset);

    // cp1 will be updated when dragging
    CGPathAddCurveToPoint(path, NULL, (20.5 + windForce)* RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset, 11.5 * RATIO_TX(rect), 31.5 * RATIO_TY(rect) + offset, 6.5 * RATIO_TX(rect), 48.5 * RATIO_TY(rect) + offset);

    CGPathAddCurveToPoint(path, NULL, 1.5 * RATIO_TX(rect), 65.5 * RATIO_TY(rect) + offset, 0.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset);

    CGPathCloseSubpath(path);
    return path;
}

/**
 *  Trunk of the tree
 *
 *  @param offset Horizontal line offset Y
 *
 *  @return Trunk path
 */
- (CGMutablePathRef)trunkPathWithOffset:(CGFloat)offset {
    CGRect rect = self.originalFrame;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 19 * RATIO_TX(rect), 53.5 * RATIO_TY(rect) + offset);
    CGPathAddLineToPoint(path, NULL, 19 * RATIO_TX(rect) , 90 * RATIO_TY(rect) + offset);
    
    CGPathCloseSubpath(path);
    return path;
}

/**
 *  Bend tree with wind
 *
 *  @param windForce wind force
 */
- (void)bendTreeWithWind:(CGFloat)windForce {
    CGMutablePathRef leafPath = [self leafPathWithOffset:0 andWindForce:windForce];
    self.leafLayer.path = leafPath;
}

@end
