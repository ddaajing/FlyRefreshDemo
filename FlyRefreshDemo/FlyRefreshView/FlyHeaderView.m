//
//  FlyHeaderView
//
//  Created by ddaajing
//  Copyright (c) 2015年 dajing. All rights reserved.
//

#import "FlyHeaderView.h"

#define IMAGE_HEIGHT 35.f
#define SET_OFF_OFFSET 50.f

@interface FlyHeaderView()

@property (nonatomic, strong) RefreshMoutainHeaderView *refreshMountainHeaderView;
@property (nonatomic, strong) UIImageView *planeImageView;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat horizonLineHeight;

@property (nonatomic, assign) BOOL isFlighting;
@property (nonatomic, strong) UIView *roundedAirPort;

@property (nonatomic, strong) CAAnimation *setOffAnimation;
@property (nonatomic, strong) CAAnimation *backAnimation;

@end

@implementation FlyHeaderView

#pragma mark - lifecycle
- (FlyHeaderView *)initWithTableViewAndHeaderHeight:(CGFloat)height {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    if (self = [super initWithFrame:bounds]) {
        self.headerHeight = height;
        self.horizonLineHeight = height - IMAGE_HEIGHT / 2;

        [self configSubviews];
    }
    
    return self;
}

#pragma mark - setter & getter
- (RefreshMoutainHeaderView *)refreshMountainHeaderView {
    if (!_refreshMountainHeaderView) {
        _refreshMountainHeaderView = [[RefreshMoutainHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.headerHeight - IMAGE_HEIGHT / 2)];
    }
    return _refreshMountainHeaderView;
}

- (UIView *)roundedAirPort {
    if (!_roundedAirPort) {
        UIImage *plane = [UIImage imageNamed:@"icon-plane"];

        _roundedAirPort = [[UIView alloc] init];
        _roundedAirPort.center = CGPointMake(40.f, self.horizonLineHeight);
        _roundedAirPort.bounds = CGRectMake(0, 0, plane.size.width + 20, plane.size.height + 20);
        _roundedAirPort.backgroundColor = [UIColor colorWithRed:0.365 green:0.698 blue:0.875 alpha:1.000];
        _roundedAirPort.layer.cornerRadius = (plane.size.width + 20) / 2.f;
    }
    return _roundedAirPort;
}

- (UIImageView *)planeImageView {
    if (!_planeImageView) {
        UIImage *plane = [UIImage imageNamed:@"icon-plane"];

        self.planeImageView = [[UIImageView alloc] init];
        self.planeImageView.image = plane;
        self.planeImageView.bounds = CGRectMake(0, 0, plane.size.width, plane.size.height);
        self.planeImageView.center = CGPointMake(40.f, self.horizonLineHeight);
    }
    return _planeImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame];
        _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.headerHeight)];
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _tableView;
}

- (void)configSubviews {
    // refresh header view
    [self addSubview:self.refreshMountainHeaderView];
    
    // rounded airport
    [self addSubview:self.roundedAirPort];

    // flight
    [self addSubview:self.planeImageView];
    
    // tableView
    [self addSubview:self.tableView];
}

#pragma mark -  animate flight along specific path
- (CGPathRef)flightPathWithOffset:(CGFloat)offset andStatus:(FLIGHT_STATUS)status {
    CGRect rect = CGRectMake(0, 0, 375.f, self.horizonLineHeight);

    UIBezierPath* flightPath = UIBezierPath.bezierPath;
    // flight out of sight
    if (status == FLIGHT_STATUS_SET_OFF) {
        [flightPath moveToPoint: CGPointMake(23 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset)];
        [flightPath addLineToPoint:CGPointMake(300.5 * RATIO_X(rect), 12.5 * RATIO_Y(rect))];
        [flightPath addLineToPoint: CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect))];
    }
    else { // flight back
        [flightPath moveToPoint: CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect))];
        [flightPath addLineToPoint: CGPointMake(0. * RATIO_X(rect), 102.5 * RATIO_Y(rect))];
        [flightPath addLineToPoint: CGPointMake(-38.5 * RATIO_X(rect), 120 * RATIO_Y(rect))];
        [flightPath addLineToPoint: CGPointMake(23 * RATIO_X(rect), 120 * RATIO_Y(rect))];
    }
    
    return flightPath.CGPath;
}

- (void)setOffFlightWithOffset:(CGFloat)offset {
    self.planeImageView.transform = CGAffineTransformIdentity;
    
    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.path = [self flightPathWithOffset:offset andStatus:FLIGHT_STATUS_SET_OFF];
    flightAnimation.calculationMode = kCAAnimationPaced;
    flightAnimation.rotationMode = kCAAnimationRotateAuto;
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[flightAnimation];
    groupAnimation.duration = 1.5f;
    groupAnimation.delegate = self;
    groupAnimation.fillMode = kCAFillModeForwards;
    [groupAnimation setValue:@"setoff" forKey:@"id"];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.planeImageView.layer addAnimation:groupAnimation forKey:@"planeAnimation"];
    self.setOffAnimation = groupAnimation;
}

- (void)sendFlightBack {
    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.path = [self flightPathWithOffset:0 andStatus:FLIGHT_STATUS_BACK];
    flightAnimation.calculationMode = kCAAnimationPaced;
    flightAnimation.rotationMode = kCAAnimationRotateAuto;
    
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.animations = @[flightAnimation];
    groupAnimation.duration = 1.5f;
    groupAnimation.delegate = self;
    groupAnimation.fillMode = kCAFillModeForwards;
    [groupAnimation setValue:@"back" forKey:@"id"];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.planeImageView.layer addAnimation:groupAnimation forKey:@"planeBackAnimation"];
    self.backAnimation = groupAnimation;
}

#pragma mark - KVO scrollView offset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.tableView) {
        [self animationForTableView];
    }
}

- (void)animationForTableView {
    CGFloat offset = self.tableView.contentOffset.y;
    //    NSLog(@"offset is %f", -offset);
    
    if (self.tableView.contentOffset.y < 0) {
        self.refreshMountainHeaderView.frame = CGRectMake(0,0, self.frame.size.width, self.horizonLineHeight + (-offset));
        
        self.roundedAirPort.center = CGPointMake(self.roundedAirPort.center.x, self.horizonLineHeight + (-offset));
        
        [self.refreshMountainHeaderView parallaxMoutainWithOffset:-(offset)];
        
        CGFloat rotateOffset = -MAX(-SET_OFF_OFFSET, offset) / SET_OFF_OFFSET;
        
        if (!self.isFlighting) {
            CGFloat tanValue = (120.f - offset - 12.4) / (300.f - 14.f);
            CGFloat maxTanRadians = -atan(tanValue);
            
            self.planeImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(rotateOffset * maxTanRadians), CGAffineTransformMakeTranslation(0, - offset));
        }
    }
}

#pragma mark - scrollViewWillEndDragging
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat offset = self.tableView.contentOffset.y;
    
    if (-offset >= SET_OFF_OFFSET) {
        if (!self.isFlighting) {
            self.isFlighting = YES;
            [self setOffFlightWithOffset:-offset];
            
            [self.delegate requestDataWithFlyHeaderView:self];
        }
    }
}

#pragma mark - dealloc
- (void)removeFromSuperview {
    if (self.tableView) {
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [super removeFromSuperview];
}

- (void)dealloc {
    if (self.tableView) {
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if([[anim valueForKey:@"id"] isEqualToString:@"setoff"]) {
        CGRect rect = CGRectMake(0, 0, 375.f, self.horizonLineHeight);
        self.planeImageView.center = CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect));
    }
    else {
        self.isFlighting = NO;
        self.planeImageView.center = CGPointMake(40.f, self.horizonLineHeight);
        [self.delegate didFinishedRefreshWithFlyHeaderView:self];
    }
}

@end
