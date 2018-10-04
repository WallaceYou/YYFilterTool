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

- (void)setIndexCountShowEnable:(BOOL)indexCountShowEnable {
    self.baseFilter.indexCountShowEnable = indexCountShowEnable;
}

- (void)setFirstLevelElements:(NSArray *)firstLevelElements {
    self.baseFilter.firstLevelElements = firstLevelElements;
}

- (void)setSecondLevelElements:(NSArray *)secondLevelElements {
    self.baseFilter.secondLevelElements = secondLevelElements;
}

- (void)setThirdLevelElement:(NSArray *)thirdLevelElement {
    self.baseFilter.thirdLevelElements = thirdLevelElement;
}

- (void)setCurrentConditions:(NSMutableArray<FilterSelectIndexModel *> *)currentConditions {
    self.baseFilter.currentConditions = currentConditions;
}

- (void)setSelectedBtnHighlightedName:(NSString *)selectedBtnHighlightedName {
    self.baseFilter.selectedBtnHighlightedName = selectedBtnHighlightedName;
}

- (void)setSelectedBtnNormalName:(NSString *)selectedBtnNormalName {
    self.baseFilter.selectedBtnNormalName = selectedBtnNormalName;
}

- (void)setFilterComplete:(void (^)(NSArray *))filterComplete {
    self.baseFilter.filterComplete = filterComplete;
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

/* 获得indexModel最里层的indexModel */
+ (FilterSelectIndexModel *)getInnermostIndexModelWith:(FilterSelectIndexModel *)indexModel {
    FilterSelectIndexModel *model = indexModel;
    if (model.subIndex != nil) {
        while (1) {
            model = model.subIndex;
            if (model.subIndex == nil) {
                break;
            }
        }
    }
    return model;
}

- (void)popFilterViewWithStartY:(CGFloat)startY startAnimateComplete:(void (^)(void))startAnimateComplete closeAnimateComplete:(void (^)(void))closeAnimateComplete {
    
    [self.baseFilter popFilterViewWithStartY:startY startAnimateComplete:startAnimateComplete closeAnimateComplete:^{
        if (closeAnimateComplete) {
            closeAnimateComplete();
        }
        //这个很关键，将baseFilter置为nil，因为YYFilterTool对象在静态区，直到程序结束才会释放，如果不将baseFilter置为nil，则baseFilter对象中的所有引用（在堆中）都会一直持有，导致不会被释放，置为nil后，baseFilter才会被销毁
        self.baseFilter = nil;
    }];
    
}

- (YYBaseFilter *)baseFilter {
    if (!_baseFilter) {
        _baseFilter = [YYBaseFilter new];
    }
    return _baseFilter;
}






@end
