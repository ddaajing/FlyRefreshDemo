//
//  FlyRefreshView.swift
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/29/15.
//  Copyright © 2015 ddaajing. All rights reserved.
//

import UIKit

enum FLIGHT_STATUS {
    case FLIGHT_STATUS_SET_OFF
    case FLIGHT_STATUS_BACK
    case FLIGHT_STATUS_FAIL
    case FLIGHT_STATUS_SUCCESS
}

func IMAGE_HEIGHT() -> CGFloat {
    return 35
}

func SET_OFF_OFFSET() -> CGFloat {
    return 50
}

protocol FlyHeaderViewDelegate: class {
    func requestDataWithFlyHeaderView(flyHeaderView: FlyHeaderView)
    func didFinishedRefreshWithFlyHeaderView(flyHeaderView: FlyHeaderView)
}

extension FlyHeaderView : FlyHeaderViewDelegate {
    func requestDataWithFlyHeaderView(flyHeaderView: FlyHeaderView) {
        
    }
    
    func didFinishedRefreshWithFlyHeaderView(flyHeaderView: FlyHeaderView) {
        
    }
}

class FlyHeaderView: UIView {
    weak var delegate: FlyHeaderViewDelegate?
    
    let tableView: UITableView!
    
    private let refreshMountainHeaderView: RefreshMountainHeaderView
    private let planeImageView: UIImageView

    private let headerHeight: CGFloat
    private let horizonLineHeight: CGFloat

    private var isFlighting: Bool
    private var isDay: Bool

    private let roundedAirPort: UIView
    
    private let successHintLayer: CAEmitterLayer
//    private let failHintLayer: CAEmitterLayer

    init(height:CGFloat) {

        refreshMountainHeaderView = RefreshMountainHeaderView(frame: UIScreen.mainScreen().bounds)
        let plane: UIImage! = UIImage(named: "icon-plane")
        planeImageView = UIImageView(image: plane)
        planeImageView.bounds = CGRectMake(0, 0, plane.size.width, plane.size.height)

        headerHeight = height
        horizonLineHeight = height - IMAGE_HEIGHT() / 2

        isDay = true
        isFlighting = false
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds)
        tableView.tableHeaderView?.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView = UIView(frame:CGRectMake(0, 0, SCREEN_WIDTH(), self.headerHeight))
        tableView.backgroundColor = UIColor.clearColor()

        roundedAirPort = UIView()
        roundedAirPort.bounds = CGRectMake(0, 0, plane.size.width + 20, plane.size.height + 20)
        roundedAirPort.layer.cornerRadius = (plane.size.width + 20) / 2

        successHintLayer = CAEmitterLayer()
        successHintLayer.emitterShape = kCAEmitterLayerLine
        successHintLayer.emitterPosition = CGPointMake(40, horizonLineHeight)
        successHintLayer.emitterSize = CGSizeMake(40, 40)
        successHintLayer.emitterMode = kCAEmitterLayerOutline
        successHintLayer.renderMode = kCAEmitterLayerAdditive
        successHintLayer.seed = (arc4random() % 100) + 1

        let spark = CAEmitterCell()
        spark.birthRate	= 20
        spark.velocity = 125
        spark.emissionRange	= (CGFloat)(2 * M_PI)	// 360 deg
        spark.yAcceleration	= 20		// gravity
        spark.lifetime = 1
        spark.contents = UIImage(named: "star")!.CGImage
        spark.scaleSpeed = 0.2
        spark.greenSpeed = 0.1
        spark.redSpeed = 0.1
        spark.blueSpeed	= 0.1
        spark.alphaSpeed = -0.25
        spark.spin = (CGFloat)(2 * M_PI)
        spark.spinRange	= (CGFloat)(2 * M_PI)
        
        successHintLayer.emitterCells = [spark]

        super.init(frame: UIScreen.mainScreen().bounds)
        
        configSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubviews() {
        self.planeImageView.center = CGPointMake(40, self.horizonLineHeight)
        roundedAirPort.center = CGPointMake(40, self.horizonLineHeight)
        roundedAirPort.backgroundColor = UIColor(red: 0.365, green:0.698, blue:0.875, alpha:1.000)

        // refresh header view
        addSubview(self.refreshMountainHeaderView)
        
        // rounded airport
        addSubview(self.roundedAirPort)
        
        // flight
        addSubview(self.planeImageView)
        
        // tableView
        addSubview(self.tableView)
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)

    }
    
    func flightPath(offset offset:CGFloat, status: FLIGHT_STATUS) -> CGPathRef {
        let rect = CGRectMake(0, 0, SCREEN_WIDTH(), self.horizonLineHeight)
        
        let flightPath = UIBezierPath()
        // flight out of sight
        if (status == FLIGHT_STATUS.FLIGHT_STATUS_SET_OFF) {
            flightPath.moveToPoint(CGPointMake(23 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset))
            flightPath.addLineToPoint(CGPointMake(300.5 * RATIO_X(rect), 12.5 * RATIO_Y(rect)))
            flightPath.addLineToPoint(CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect)))
        }
        else { // flight back
            flightPath.moveToPoint(CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect)))
            flightPath.addLineToPoint(CGPointMake(0 * RATIO_X(rect), 102.5 * RATIO_Y(rect)))
            flightPath.addLineToPoint(CGPointMake(-38.5 * RATIO_X(rect), 120 * RATIO_Y(rect)))
            flightPath.addLineToPoint(CGPointMake(23 * RATIO_X(rect), 120 * RATIO_Y(rect)))
        }
    
        return flightPath.CGPath;
    }
    
    func setOffFlight(offset offset: CGFloat) {
        self.planeImageView.transform = CGAffineTransformIdentity;
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = self.flightPath(offset: offset, status:FLIGHT_STATUS.FLIGHT_STATUS_SET_OFF);
        flightAnimation.calculationMode = kCAAnimationPaced;
        flightAnimation.rotationMode = kCAAnimationRotateAuto;
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [flightAnimation]
        groupAnimation.duration = 1.5
        groupAnimation.delegate = self
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.setValue("setoff", forKey: "id")
            
        groupAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        self.planeImageView.layer.addAnimation(groupAnimation, forKey:"planeAnimation")
        let rect = CGRectMake(0, 0, SCREEN_WIDTH(), self.horizonLineHeight)
        self.planeImageView.center = CGPointMake(346.5 * RATIO_X(rect), 42.5 * RATIO_Y(rect));
    }

    func sendFlightBack() {
        let flightAnimation = CAKeyframeAnimation(keyPath:"position")
        flightAnimation.path = self.flightPath(offset: 0, status: FLIGHT_STATUS.FLIGHT_STATUS_BACK)
        flightAnimation.calculationMode = kCAAnimationPaced;
        flightAnimation.rotationMode = kCAAnimationRotateAuto;
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [flightAnimation]
        groupAnimation.duration = 1.5
        groupAnimation.delegate = self
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.setValue("back", forKey: "id")

        groupAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        self.planeImageView.layer.addAnimation(groupAnimation, forKey:"planeBackAnimation")
        self.planeImageView.center = CGPointMake(40, self.horizonLineHeight)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (self.tableView != nil) {
            self.animationForTableView()
        }
    }
    
    func animationForTableView() {
    let offset = self.tableView.contentOffset.y;
        
        if (self.tableView.contentOffset.y < 0) {
            self.refreshMountainHeaderView.frame = CGRectMake(0,0, self.frame.size.width, self.horizonLineHeight + (-offset));
            
            self.roundedAirPort.center = CGPointMake(self.roundedAirPort.center.x, self.horizonLineHeight + (-offset));
            
            self.refreshMountainHeaderView.parallaxMoutain(offset: -(offset))
            
            let rotateOffset = -max(-SET_OFF_OFFSET(), offset) / SET_OFF_OFFSET();
            
            if (!self.isFlighting) {
            let tanValue = (120 - offset - 12.4) / (300 - 14);
            let maxTanRadians = -atan(tanValue);
            
            self.planeImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(rotateOffset * maxTanRadians), CGAffineTransformMakeTranslation(0, -offset));
            }
        }
    }

    func switchDayAndNight(switchToDay: Bool) {
        let fromColor: UIColor;
        let toColor: UIColor;
        
        if (switchToDay) {
            fromColor = UIColor(red:0.502, green:0.792, blue:0.725, alpha:1.000)
            toColor = UIColor(red:0.193, green:0.306, blue:0.281, alpha:1.000)
        }
        else {
            fromColor = UIColor(red:0.193, green:0.306, blue:0.281, alpha:1.000)
            toColor = UIColor(red:0.502, green:0.792, blue:0.725, alpha:1.000)
        }
        
        let switchDayNightAni = CABasicAnimation(keyPath:"backgroundColor")
        switchDayNightAni.fromValue = fromColor.CGColor
        switchDayNightAni.toValue = toColor.CGColor
        switchDayNightAni.duration = 2;
        switchDayNightAni.delegate = self;
        switchDayNightAni.setValue("switch", forKey:"id")
        self.refreshMountainHeaderView.layer.addAnimation(switchDayNightAni, forKey:"switchDayAndNight")
        self.refreshMountainHeaderView.backgroundColor = toColor;
    }

    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        let offset = self.tableView.contentOffset.y
        
        if (-offset >= SET_OFF_OFFSET()) {
            if (!self.isFlighting) {
                self.isFlighting = true;
                self.setOffFlight(offset: -offset)
                
                self.delegate?.requestDataWithFlyHeaderView(self)
                
                self.switchDayAndNight(self.isDay)
            }
        }
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()

        if (self.tableView != nil) {
            self.tableView.removeObserver(self, forKeyPath:"contentOffset")
        }
    }

    deinit {
        if (self.tableView != nil) {
            self.tableView.removeObserver(self, forKeyPath:"contentOffset")
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let aniId = anim.valueForKey("id")
        
        if(aniId as? String == "setoff") {
        }
        else if(aniId as? String == "back"){
            self.isFlighting = false
            self.delegate?.didFinishedRefreshWithFlyHeaderView(self)
        }
        else if(aniId as? String == "switch") {
            if (self.isFlighting) {
                self.isDay = !self.isDay
                self.switchDayAndNight(self.isDay)
            }
            else {
                self.refreshMountainHeaderView.layer.removeAnimationForKey("switchDayAndNight")
                self.isDay = true
            }
        }
    }

    func showFeedbackHintWithStatus(status: FLIGHT_STATUS) {
        if (status == FLIGHT_STATUS.FLIGHT_STATUS_SUCCESS) {
            self.layer.insertSublayer(self.successHintLayer, below:self.planeImageView.layer)
            
            let delayInSeconds = 1.5
            let popTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                self.successHintLayer.removeFromSuperlayer()
            }
        }
    }
}