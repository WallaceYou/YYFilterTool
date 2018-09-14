//
//  ThirdTableView.h
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThirdConditionModel;

@interface ThirdTableView : UITableView

/** 显示第三层表格所需要的所有信息 */
@property (nonatomic, strong) ThirdConditionModel *dataModel;

@end
