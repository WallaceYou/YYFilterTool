//
//  ConditionListModel.h
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionListModel : NSObject

@property (nonatomic, copy) NSString *conditionName;

/* 代表这是第几层的cell，如果是第一二层cell，则背景为灰色，没有钩框，如果是第三层，则背景为白色，根据multiSelectionEnable判断有没有钩框 */
@property (nonatomic, assign) NSInteger levelType;

/* 代表角标数（只针对于两层筛选的第一层的cell） */
@property (nonatomic, assign) NSInteger indexNumber;

/* 表示这个cell是否被选中（只针对第一层cell） */
@property (nonatomic, assign) BOOL cellSelected;

/* 表示钩框是否被选中 */
@property (nonatomic, assign) BOOL boxSelected;

/* 表示钩框亮色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnHighlightedName;

/* 表示钩框暗色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnNormalName;

@end
