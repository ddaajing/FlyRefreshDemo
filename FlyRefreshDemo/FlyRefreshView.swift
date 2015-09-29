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

protocol FlyHeaderViewDelegate: class {
    func requestDataWithFlyHeaderView(flyHeaderView: FlyHeaderView)
    func didFinishedRefreshWithFlyHeaderView(flyHeaderView: FlyHeaderView)
}

class FlyHeaderView: UIView {
    weak var delegate: FlyHeaderViewDelegate?
    
    private let refreshMountainHeaderView: RefreshMountainHeaderView
//    private let planeImageView: UIImageView
//    
//    private let headerHeight: CGFloat
//    private let horizonLineHeight: CGFloat
//    
//    private let isFlighting: Bool
//    private let isDay: Bool
//    
//    private let roundedAirPort: UIView
//    
//    private let successHintLayer: CAEmitterLayer
//    private let failHintLayer: CAEmitterLayer

    init(height:CGFloat) {
        self.refreshMountainHeaderView = RefreshMountainHeaderView(frame: UIScreen.mainScreen().bounds)
        super.init(frame: UIScreen.mainScreen().bounds)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubviews() {
        
    }
}