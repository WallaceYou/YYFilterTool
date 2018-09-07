//
//  YYFilterToolMacro.h
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#ifndef YYFilterToolMacro_h
#define YYFilterToolMacro_h

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
