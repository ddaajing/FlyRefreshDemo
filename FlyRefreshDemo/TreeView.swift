//
//  ASwiftFile.swift
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/29/15.
//  Copyright © 2015 ddaajing. All rights reserved.
//

import UIKit

func RATIO_TY(rect:CGRect) -> CGFloat {
    return CGRectGetMaxY(rect) / 120
}

func RATIO_TX(rect:CGRect) -> CGFloat {
    return CGRectGetMaxX(rect) / 40
}

class TreeView : UIView {
    private let trunkColor: UIColor
    private let leafColor: UIColor
    
    private let originalFrame: CGRect
    
    private var trunkLayer: CAShapeLayer
    private var leafLayer: CAShapeLayer
    
    init(frame:CGRect, trunkColor:UIColor, leafColor:UIColor) {
        self.trunkColor = trunkColor
        self.leafColor = leafColor
        
        self.originalFrame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.trunkLayer = CAShapeLayer()
        self.leafLayer = CAShapeLayer()
        
        super.init(frame: frame)
        
        self.configSubviewsWithFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configSubviewsWithFrame() {
        self.leafLayer.frame = self.bounds
        self.leafLayer.fillColor = self.leafColor.CGColor
        self.leafLayer.backgroundColor = UIColor.clearColor().CGColor
        self.leafLayer.strokeColor = UIColor.clearColor().CGColor
        self.leafLayer.lineWidth = 1

        let leafLayerPath = self.leafPath(offset:0, windForce: 0)
        self.leafLayer.path = leafLayerPath
        self.layer.addSublayer(self.leafLayer)

        self.trunkLayer.frame = self.bounds
        self.trunkLayer.fillColor = self.trunkColor.CGColor
        self.trunkLayer.backgroundColor = UIColor.clearColor().CGColor
        self.trunkLayer.strokeColor = self.trunkColor.CGColor
        self.trunkLayer.lineWidth = 3 / 30 * self.bounds.size.width
        
        let trunkLayer = self.trunkPath(offset: 0)
        self.trunkLayer.path = trunkLayer
        self.layer.addSublayer(self.trunkLayer)
    }
    
    func bendTreeWithWindForce(windForce windForce:CGFloat) {
        let leafPath = self.leafPath(offset: 0, windForce: windForce)
        self.leafLayer.path = leafPath
    }
    
    func leafPath(offset offset:CGFloat, windForce:CGFloat) -> CGMutablePathRef {
        let path = CGPathCreateMutable()
        
        let rect = self.originalFrame
        
        CGPathMoveToPoint(path, nil, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset)
        
        CGPathAddCurveToPoint(path, nil, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset, 46.5 * RATIO_TX(rect), 81.5 * RATIO_TY(rect) + offset, 33.5 * RATIO_TX(rect), 48.5 * RATIO_TY(rect) + offset)
        
        // to point and cp2 will be updated when dragging
        CGPathAddCurveToPoint(path, nil, 20.5 * RATIO_TX(rect), 15.5 * RATIO_TY(rect) + offset, (20.5 + windForce) * RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset, (20.5 + windForce) * RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset)
        
        // cp1 will be updated when dragging
        CGPathAddCurveToPoint(path, nil, (20.5 + windForce) * RATIO_TX(rect), (15.5 - windForce / 3) * RATIO_TY(rect) + offset, 11.5 * RATIO_TX(rect), 31.5 * RATIO_TY(rect) + offset, 6.5 * RATIO_TX(rect), 48.5 * RATIO_TY(rect) + offset)
        
        CGPathAddCurveToPoint(path, nil, 1.5 * RATIO_TX(rect), 65.5 * RATIO_TY(rect) + offset, 0.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset, 20.5 * RATIO_TX(rect), 77.5 * RATIO_TY(rect) + offset)
        
        CGPathCloseSubpath(path)

        return path
    }
    
    func trunkPath(offset offset:CGFloat) -> CGMutablePathRef {
        let rect = self.originalFrame
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 19 * RATIO_TX(rect), 53.5 * RATIO_TY(rect) + offset)
        CGPathAddLineToPoint(path, nil, 19 * RATIO_TX(rect) , 90 * RATIO_TY(rect) + offset)
        
        CGPathCloseSubpath(path)
        return path
    }
}

class demo {
    func doSomething() {
        let tree = TreeView(frame: CGRectZero, trunkColor: UIColor.redColor(), leafColor: UIColor.blackColor())
        
        tree.bendTreeWithWindForce(windForce:1)
    }
}
