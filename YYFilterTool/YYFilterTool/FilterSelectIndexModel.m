//
//  FilterSelectIndexModel.m
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/31.
//  Copyright © 2018年 yuyou. All rights reserved.
//

#import "FilterSelectIndexModel.h"

@interface FilterSelectIndexModel () <NSCopying>

@end

@implementation FilterSelectIndexModel

- (id)copyWithZone:(NSZone *)zone {
    FilterSelectIndexModel *indexModel = [FilterSelectIndexModel new];
    indexModel.filterName = self.filterName;
    indexModel.index = self.index;
    indexModel.subIndex = [self.subIndex copy];
    return indexModel;
}

@end
