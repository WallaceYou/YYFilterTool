//
//  FirstViewController.h
//  YYFilterTool
//
//  Created by yuyou on 2018/9/29.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ChooseType) {
    ChooseTypeFirst,
    ChooseTypeSecond,
    ChooseTypeThird,
};

@interface FirstViewController : UIViewController

@property (nonatomic, assign) BOOL multiSelectionEnable;

@property (nonatomic, assign) BOOL topAndIndexCountEnable;

@property (nonatomic, assign) BOOL customImage;


@property (nonatomic, assign) ChooseType type;


@end
