//
//  FilterSelectIndexModel.h
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/31.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSelectIndexModel : NSObject

/** 点击的条件的名字 */
@property (nonatomic, copy) NSString *filterName;

/** 点击的cell在此层的索引 */
@property (nonatomic, assign) NSInteger index;

/** 表示下一层级model数据，如果没有下一级，则此值为nil */
@property (nonatomic, strong) FilterSelectIndexModel *subIndex;

@end
