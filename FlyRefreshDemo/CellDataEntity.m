//
//  CellDataEntity.m
//  FlyRefreshDemo
//
//  Created by ddaajing on 9/21/15.
//  Copyright © 2015 ddaajing. All rights reserved.
//

#import "CellDataEntity.h"

@implementation CellDataEntity

- (instancetype)initWithTitle:(NSString *)title andIcon:(NSString *)icon andPublishDate:(NSString *)publishDate {
    if (self = [super init]) {
        _title = title;
        _icon = icon;
        _publishDate = publishDate;
    }
    return self;
}

@end
