//
//  YYFilterTool.h
//  YYFilterTool
//
//  Created by 游宇的Macbook on 2018/9/8.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYFilterToolMacro.h"
#import "FilterSelectIndexModel.h"
#import <UIKit/UIKit.h>

@interface YYFilterTool : NSObject

/**
 *  @discussion YYFilterTool这个类只是将baseFilter又进行了一次封装，提供一个单例对象，外界每次给单例对象中属性的赋值，其实只是给单例对象中baseFilter的赋值，单例对象中的属性永远为nil，而每次视图关闭后，baseFilter都被销毁了，不会造成单例对象中的某一属性一直引用堆中对象。这样就可以做到项目中的所有地方用到的筛选视图，都只使用这一个单例对象即可，每次pop出不同类型的筛选视图，只需赋值不同的属性，然后再pop
 *
 */

/** 筛选层级，一层还是两层，目前支持两层，以后有需求可以拓展到三层 */
@property (nonatomic, assign) NSInteger levelType;

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
@property (nonatomic, strong) NSArray *thirdLevelElement;

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

/** 单例对象 */
+ (instancetype)shareInstance;

/** 获得indexModel最里层的indexModel */
+ (FilterSelectIndexModel *)getInnermostIndexModelWith:(FilterSelectIndexModel *)indexModel;

@end
