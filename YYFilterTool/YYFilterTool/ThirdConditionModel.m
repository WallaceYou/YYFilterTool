//
//  ThirdConditionModel.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ThirdConditionModel.h"

@implementation ThirdConditionModel

- (NSString *)selectedBtnHighlightedName {
    
    if (_selectedBtnHighlightedName == nil) {
        if (self.multiSelectionEnable) {//多选
            _selectedBtnHighlightedName = @"select_square_bright";
        } else {
            _selectedBtnHighlightedName = @"select_square_right";
        }
        
    }
    
    return _selectedBtnHighlightedName;
}


- (NSString *)selectedBtnNormalName {
    
    if (_selectedBtnNormalName == nil) {
        if (self.multiSelectionEnable) {//多选
            _selectedBtnNormalName = @"select_square_grey";
        } else {
            _selectedBtnNormalName = @"";
        }
        
    }
    
    return _selectedBtnNormalName;
}

@end
