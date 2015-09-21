//
//  CellDataEntity.h
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/21/15.
//  Copyright © 2015 ddaajing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellDataEntity : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *publishDate;

- (instancetype)initWithTitle:(NSString *)title andIcon:(NSString *)icon andPublishDate:(NSString *)publishDate;

@end
