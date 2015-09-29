//
//  RefreshMoutainHeaderView.swift
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/29/15.
//  Copyright © 2015 ddaajing. All rights reserved.
//

import UIKit

func SCREEN_WIDTH() -> CGFloat {
    return UIScreen.mainScreen().bounds.size.width
}

func RATIO_Y(rect:CGRect) -> CGFloat {
    return CGRectGetMaxY(rect) / 120
}

func RATIO_X(rect:CGRect) -> CGFloat {
    return CGRectGetMaxX(rect) / 240
}


class RefreshMoutainHeaderView: UIView {
    var mostFarMountainLayer: CAShapeLayer
    var moreFarMountainLayer: CAShapeLayer
    var nearByMountainLayer: CAShapeLayer
    
    let mostFarColor: UIColor
    let moreFarColor: UIColor
    let nearByColor: UIColor
    
    let originalFrame: CGRect
    
    let middleTree: TreeView
    let leftTree: TreeView
    let rightTree: TreeView
    let leftFarTree: TreeView
    let rightFarTree: TreeView

    override init(frame: CGRect) {
        self.mostFarMountainLayer = CAShapeLayer()
        self.moreFarMountainLayer = CAShapeLayer()
        self.nearByMountainLayer = CAShapeLayer()

        mostFarColor = UIColor(red: 0.482, green: 0.847, blue: 0.875, alpha: 1)
        self.moreFarColor = UIColor(red:  0.2, green: 0.565, blue: 0.604, alpha: 1)
        self.nearByColor = UIColor(red: 0.192, green: 0.333, blue: 0.353, alpha: 1)
        
        self.originalFrame = frame;

        self.middleTree = TreeView(frame: CGRectMake(260 / 375 * SCREEN_WIDTH(), 82, 30, 120), trunkColor: self.nearByColor, leafColor: UIColor(red: 0.240, green:0.415, blue:0.442, alpha:1.000))
        self.leftTree = TreeView(frame: CGRectMake(235 / 375 * SCREEN_WIDTH(), 100, 15, 90), trunkColor:UIColor(red: 0.254, green:0.439, blue:0.467, alpha:1.000), leafColor: moreFarColor)
        self.rightTree = TreeView(frame: CGRectMake(300 / 375 * SCREEN_WIDTH(), 103, 15, 90), trunkColor:UIColor(red: 0.254, green:0.439, blue:0.467, alpha:1.000), leafColor: moreFarColor)
        self.leftFarTree = TreeView(frame: CGRectMake(50 / 375 * SCREEN_WIDTH(), 103, 15, 70), trunkColor:UIColor(red: 0.383, green:0.662, blue:0.705, alpha:1.000), leafColor: moreFarColor)
        self.rightFarTree = TreeView(frame: CGRectMake(70 / 375 * SCREEN_WIDTH(), 82, 13, 90), trunkColor:UIColor(red: 0.383, green:0.662, blue:0.705, alpha:1.000), leafColor: moreFarColor)

        super.init(frame: frame)

        self.backgroundColor = UIColor(red:0.502, green:0.792, blue:0.725, alpha:1.000)
        self.clipsToBounds = true

        self.configSubviewsWithFrame(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubviewsWithFrame(frame: CGRect) {
        self.mostFarMountainLayer.frame = frame;
        self.mostFarMountainLayer.fillColor = self.mostFarColor.CGColor;
        self.mostFarMountainLayer.backgroundColor = UIColor.clearColor().CGColor
        self.mostFarMountainLayer.strokeColor = self.mostFarColor.CGColor
        self.mostFarMountainLayer.lineWidth = 1
        
        self.moreFarMountainLayer.frame = frame;
        self.moreFarMountainLayer.fillColor = self.moreFarColor.CGColor;
        self.moreFarMountainLayer.backgroundColor = UIColor.clearColor().CGColor
        self.moreFarMountainLayer.strokeColor = self.moreFarColor.CGColor
        self.moreFarMountainLayer.lineWidth = 1

        self.nearByMountainLayer.frame = frame;
        self.nearByMountainLayer.fillColor = self.nearByColor.CGColor;
        self.nearByMountainLayer.backgroundColor = UIColor.clearColor().CGColor
        self.nearByMountainLayer.strokeColor = self.nearByColor.CGColor
        self.nearByMountainLayer.lineWidth = 1

        // most far mountain
        let mostFarMoutainpPath = self.mostFarPath(offset: 0)
        self.mostFarMountainLayer.path = mostFarMoutainpPath;
        self.layer.addSublayer(self.mostFarMountainLayer)

        
        // more far mountain
        let moreFarMoutainpPath = self.moreFarPath(offset:0)
        self.moreFarMountainLayer.path = moreFarMoutainpPath
        self.layer.addSublayer(self.moreFarMountainLayer)
        
        // nearby mountain
        let nearbyMoutainpPath = self.nearPath(offset: 0)
        self.nearByMountainLayer.path = nearbyMoutainpPath
        self.layer.addSublayer(self.nearByMountainLayer)
        
        // right region trees
        self.addSubview(self.leftTree)
        self.addSubview(self.middleTree)
        self.addSubview(self.rightTree)
        
        // left region trees
        self.addSubview(self.leftFarTree)
        self.addSubview(self.rightFarTree)

    }
    
    func mostFarPath(offset offset:CGFloat) -> CGMutablePathRef {
        let rect = self.originalFrame;
        
        let mostFarMoutainpPath = CGPathCreateMutable();
        CGPathMoveToPoint(mostFarMoutainpPath, nil, 0, 64 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 58 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
        
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 58 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 143 * RATIO_X(rect), 64 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 215 * RATIO_X(rect), 40 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 240 * RATIO_X(rect), 53 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 0, 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(mostFarMoutainpPath, nil, 0, 64 * RATIO_Y(rect) + offset);
        CGPathCloseSubpath(mostFarMoutainpPath);
        return mostFarMoutainpPath;
    }
    
    func moreFarPath(offset offset:CGFloat) -> CGMutablePathRef {
        let rect = self.originalFrame;
        let moreFarMoutainpPath = CGPathCreateMutable();
        CGPathMoveToPoint(moreFarMoutainpPath, nil, 0, 75 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 72 * RATIO_X(rect), 58 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 187 * RATIO_X(rect), 85 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 218 * RATIO_X(rect), 58 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 240 * RATIO_X(rect), 75 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 0, 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(moreFarMoutainpPath, nil, 0, 75 * RATIO_Y(rect) + offset);
        CGPathCloseSubpath(moreFarMoutainpPath);
        
        return moreFarMoutainpPath;
    }

    func nearPath(offset offset:CGFloat) -> CGMutablePathRef {
        let rect = self.originalFrame;
        
        let nearbyMoutainpPath = CGPathCreateMutable();
        CGPathMoveToPoint(nearbyMoutainpPath, nil, 240 * RATIO_X(rect), 88 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(nearbyMoutainpPath, nil, 240 * RATIO_X(rect), 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(nearbyMoutainpPath, nil, 0, 120 * RATIO_Y(rect) + offset);
        CGPathAddLineToPoint(nearbyMoutainpPath, nil, 0, 88 * RATIO_Y(rect) + offset);
        CGPathAddCurveToPoint(nearbyMoutainpPath, nil, 0, 88 * RATIO_Y(rect) + offset, 190 * RATIO_X(rect), 50 * RATIO_Y(rect) + offset, 240 * RATIO_X(rect), 88 * RATIO_Y(rect) + offset);
        CGPathCloseSubpath(nearbyMoutainpPath);
        
        return nearbyMoutainpPath;
    }
    
    func parallaxMoutain(offset offset:CGFloat) {
        let mostFarMoutainpPath = self.mostFarPath(offset: offset * 1.3)
        let moreFarMoutainpPath = self.moreFarPath(offset: offset * 1.2)
        let nearbyMoutainpPath = self.nearPath(offset: offset * 1.3)
        
        self.mostFarMountainLayer.path = mostFarMoutainpPath;
        self.moreFarMountainLayer.path = moreFarMoutainpPath;
        self.nearByMountainLayer.path = nearbyMoutainpPath;
        
        // move trees downside by offset
        self.leftTree.frame = CGRectMake(self.leftTree.frame.origin.x, 100 + offset * 1.3, self.leftTree.frame.size.width, self.leftTree.frame.size.height);
        self.middleTree.frame = CGRectMake(self.middleTree.frame.origin.x, 82 + offset * 1.3, self.middleTree.frame.size.width, self.middleTree.frame.size.height);
        self.rightTree.frame = CGRectMake(self.rightTree.frame.origin.x, 105 + offset * 1.3, self.rightTree.frame.size.width, self.rightTree.frame.size.height);
        
        self.leftFarTree.frame = CGRectMake(self.leftFarTree.frame.origin.x, 103 + offset * 1.2, self.leftFarTree.frame.size.width, self.leftFarTree.frame.size.height);
        self.rightFarTree.frame = CGRectMake(self.rightFarTree.frame.origin.x, 82 + offset * 1.2, self.rightFarTree.frame.size.width, self.rightFarTree.frame.size.height);
        
        // bend trees
        self.leftTree.bendTreeWithWindForce(windForce: min(50, offset) / 50 * 8)
        self.middleTree.bendTreeWithWindForce(windForce: min(50, offset) / 50 * 8)
        self.rightTree.bendTreeWithWindForce(windForce: min(50, offset) / 50 * 8)
        
        self.leftFarTree.bendTreeWithWindForce(windForce: min(50, offset) / 50 * 8)
        self.rightFarTree.bendTreeWithWindForce(windForce: min(50, offset) / 50 * 8)
    }
}