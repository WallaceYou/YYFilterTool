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

/** 是否支持角标显示 */
@property (nonatomic, assign) BOOL indexCountShowEnable;

/** 当前列表中每个cell里选中的条件个数 */
@property (nonatomic, strong) NSArray *currentSelectConditionsCounts;

/** 一级或者二级的数据源 */
@property (nonatomic, strong) NSArray *dataSource;

/** 当前选中的是第几个cell */
@property (nonatomic, assign) NSInteger currentSelectCellIndex;

@end
