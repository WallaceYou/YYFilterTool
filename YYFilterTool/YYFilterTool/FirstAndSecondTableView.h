//
//  FirstAndSecondTableView.h
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstAndSecondConditionModel;

@interface FirstAndSecondTableView : UITableView

/** 显示第一层或者第二层表格所需要的所有信息 */
@property (nonatomic, strong) FirstAndSecondConditionModel *dataModel;

@end
