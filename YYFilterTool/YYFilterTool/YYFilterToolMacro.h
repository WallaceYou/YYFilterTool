//
//  YYFilterToolMacro.h
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#ifndef YYFilterToolMacro_h
#define YYFilterToolMacro_h

typedef NS_ENUM(NSUInteger, YYBaseFilterType) {
    YYBaseFilterTypeSingleLevel = 1,
    YYBaseFilterTypeDoubleLevel = 2,
};


/* UI相关 */
#define FirstLevelScale             0.35//如果是两层筛选，则第一层的tableView的宽度占总宽度的比例
#define FirstAndSecondLevelScale    0.2//如果是三层筛选，则第一层和第二层tableView的宽度的比例
#define TopAndBottomHeight          46//上面topConditionCollectionView的高度以及下面confirmBtn的高度
#define TabelViewCellHeight         50//tableView的行高，无论第一层还是第二层
#define MaxTableViewCellCount       7//最多显示7行，无论第一层还是第二层
#define AnimationDuration           .25

/* 屏幕尺寸相关 */
#define kWindowH                [UIScreen mainScreen].bounds.size.height
#define kWindowW                [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS           [[UIScreen mainScreen] bounds]
#define SCREEN_MAX_LENGTH       (MAX(kWindowW, kWindowH))
#define SCREEN_MIN_LENGTH       (MIN(kWindowW, kWindowH))

/* 颜色 */
#define UIColorFromRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RedColor                UIColorFromRGB16(0xcc0000)

#define BrightBlueColor         UIColorFromRGB16(0x3473F6)

#define BgGreyColor             UIColorFromRGB16(0xECECF0)

#define LightBlackColor         UIColorFromRGB16(0x333333)

#endif /* YYFilterToolMacro_h */
