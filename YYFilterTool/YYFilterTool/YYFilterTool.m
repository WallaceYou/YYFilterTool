//
//  YYFilterTool.m
//  YYFilterTool
//
//  Created by 游宇的Macbook on 2018/9/8.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "YYFilterTool.h"
#import "YYBaseFilter.h"

@interface YYFilterTool ()

@property (nonatomic, strong) YYBaseFilter *baseFilter;

@end




@implementation YYFilterTool

- (void)setLevelType:(NSInteger)levelType {
    self.baseFilter.levelType = levelType;
}

- (void)setTopConditionEnable:(BOOL)topConditionEnable {
    self.baseFilter.topConditionEnable = topConditionEnable;
}

- (void)setMultiSelectionEnable:(BOOL)multiSelectionEnable {
    self.baseFilter.multiSelectionEnable = multiSelectionEnable;
}

- (void)setFirstLevelElements:(NSArray *)firstLevelElements {
    self.baseFilter.firstLevelElements = firstLevelElements;
}

- (void)setSecondLevelElements:(NSArray *)secondLevelElements {
    self.baseFilter.secondLevelElements = secondLevelElements;
}

- (void)setCurrentConditions:(NSMutableArray<FilterSelectIndexModel *> *)currentConditions {
    self.currentConditions = currentConditions;
}

- (void)setSelectedBtnHighlightedName:(NSString *)selectedBtnHighlightedName {
    self.selectedBtnHighlightedName = selectedBtnHighlightedName;
}

- (void)setSelectedBtnNormalName:(NSString *)selectedBtnNormalName {
    self.selectedBtnNormalName = selectedBtnNormalName;
}

- (void)setFilterComplete:(void (^)(NSArray *))filterComplete {
    self.filterComplete = filterComplete;
}


#pragma mark - 单例对象
+ (instancetype)shareInstance {
    static YYFilterTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YYFilterTool alloc] init];
    });
    return tool;
}

+ (void)popFilterViewWithStartY:(CGFloat)startY completion:(void (^)(void))completion {
    
    YYFilterTool *tool = [self shareInstance];
    [tool.baseFilter popFilterViewWithStartY:startY completion:completion];
    
}



- (YYBaseFilter *)baseFilter {
    if (!_baseFilter) {
        _baseFilter = [YYBaseFilter new];
    }
    return _baseFilter;
}






@end
