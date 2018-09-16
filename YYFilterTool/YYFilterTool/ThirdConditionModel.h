//
//  ThirdConditionModel.h
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdConditionModel : NSObject

/** 是否支持多选 */
@property (nonatomic, assign) BOOL multiSelectionEnable;

/** 当前条件的选中情况 */
@property (nonatomic, strong) NSArray *currentSelectedConditions;

/** 三级的数据源 */
@property (nonatomic, strong) NSArray *dataSource;

/* 表示钩框亮色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnHighlightedName;

/* 表示钩框暗色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnNormalName;

@end
