//
//  ExtensionButton.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/7.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ExtensionButton.h"

@implementation ExtensionButton

//按钮太小时（小于44*44）扩大点击范围
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)even {
    
    CGRect bounds =self.bounds;
    
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    
    bounds =CGRectInset(bounds, -0.5* widthDelta, -0.5* heightDelta);
    
    return CGRectContainsPoint(bounds, point);
    
}

@end
