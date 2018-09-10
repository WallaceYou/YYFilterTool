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


#pragma mark - 单例对象
+ (instancetype)shareInstance {
    static YYFilterTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YYFilterTool alloc] init];
    });
    return tool;
}










@end
