//
//  FirstAndSecondConditionModel.h
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterSelectIndexModel.h"

@interface FirstAndSecondConditionModel : NSObject

/** 当前选中的条件个数 */
@property (nonatomic, assign) NSInteger currentSelectConditionsCount;

/** 一级或者二级的数据源 */
@property (nonatomic, strong) NSArray *dataSource;

/** 当前选中的是第几个cell */
@property (nonatomic, assign) NSInteger currentSelectCellIndex;

@end
