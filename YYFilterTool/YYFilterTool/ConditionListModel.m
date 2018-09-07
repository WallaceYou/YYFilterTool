//
//  ConditionListModel.m
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ConditionListModel.h"

@implementation ConditionListModel

- (NSString *)selectedBtnHighlightedName {
    
    if (_selectedBtnHighlightedName == nil) {
        _selectedBtnHighlightedName = @"select_square_bright";
    }
    
    return _selectedBtnHighlightedName;
}


- (NSString *)selectedBtnNormalName {
    
    if (_selectedBtnNormalName == nil) {
        _selectedBtnNormalName = @"select_square_grey";
    }
    
    return _selectedBtnNormalName;
}

@end
