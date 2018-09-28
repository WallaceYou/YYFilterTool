//
//  YYBaseFilter.h
//  YYBaseFilter
//
//  Created by yuyou on 2018/7/28.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FilterSelectIndexModel.h"
#import "YYFilterToolMacro.h"



@interface YYBaseFilter : NSObject

/** 筛选层级，一层，两层还是三层 */
@property (nonatomic, assign) YYBaseFilterType levelType;

/** 表示上方是否展示已经选择的条件 */
@property (nonatomic, assign) BOOL topConditionEnable;

/** 是否支持多选，默认不支持 */
@property (nonatomic, assign) BOOL multiSelectionEnable;

/** 是否支持角标显示，默认不支持 */
@property (nonatomic, assign) BOOL indexCountShowEnable;

/** 第一层元素数组，注意：格式为  @[@"a",@"b",@"c"]，格式错误可能会引起闪退 */
@property (nonatomic, strong) NSArray *firstLevelElements;

/** 第二层元素数组，注意：格式为  @[@[@"aa",@"bb",@"cc"],@[@"aa",@"bb",@"cc"],@[@"aa",@"bb",@"cc"]]，格式错误可能会引起闪退 */
@property (nonatomic, strong) NSArray *secondLevelElements;

/** 第三层元素数组，注意：格式为  @[@[@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"]],@[@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"]],@[@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"],@[@"aaa",@"bbb",@"ccc"]]]，格式错误可能会引起闪退 */
@property (nonatomic, strong) NSArray *thirdLevelElements;

/** 当前选择的所有条件 */
@property (nonatomic, strong) NSMutableArray<FilterSelectIndexModel *> *currentConditions;

/** 表示钩框亮色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnHighlightedName;

/** 表示钩框暗色按钮名字 */
@property (nonatomic, copy) NSString *selectedBtnNormalName;

/** 点击筛选后的回调 */
@property (nonatomic, copy) void(^filterComplete)(NSArray *filters);


/** 开始动画，弹出筛选视图，startY表示筛选视图相对于window的Y值是多少，即从Y轴的哪个位置开始，另外两个回调分别是视图展开动画完成后的回调，视图关闭动画完成后的回调 */
- (void)popFilterViewWithStartY:(CGFloat)startY startAnimateComplete:(void(^)(void))startAnimateComplete closeAnimateComplete:(void(^)(void))closeAnimateComplete;

@end
