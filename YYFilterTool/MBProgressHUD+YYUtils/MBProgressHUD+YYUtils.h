//
//  MBProgressHUD+YYUtils.h
//  MBProgressHUD
//
//  Created by yuyou on 16/1/8.
//  Copyright © 2016年 yuyou. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSUInteger, MBProgressHUDCoverScope) {
    MBProgressHUDCoverScopeView = 1,//遮盖整个View
    MBProgressHUDCoverScopeNone = 2,//不遮盖任何部分
};

typedef NS_ENUM(NSUInteger, MBProgressHUDType) {
    MBProgressHUDTypeClassic = 1,//以前版本的经典黑色样式
    MBProgressHUDTypeWhite = 2,//现在版本的白色样式
};

@interface MBProgressHUD (YYUtils)



#pragma mark - 设置HUD的显示样式
+ (void)setMBProgressHUDType:(MBProgressHUDType)type;





#pragma mark - 在窗口上显示
/**
 在主窗口上显示菊花（遮盖整个窗口，什么都不能点击）
 */
+ (void)showProgressOnWindow;



/**
 在主窗口上显示菊花+文字（遮盖整个窗口，什么都不能点击）
 */
+ (void)showProgressOnWindowText:(NSString *)text;





#pragma mark - 在当前View上显示
/**
 在当前View上显示菊花，默认遮盖范围为整个view
 */
+ (void)showProgressOnCurrentView;



/**
 在当前View上显示菊花+文字，默认遮盖范围为整个view
 
 @param text        显示的文字
 */
+ (void)showProgressOnCurrentViewText:(NSString *)text;



/**
 在当前View上显示菊花
 
 @param coverScope  遮盖范围
 */
+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope;



/**
 在当前View上显示菊花+文字
 
 @param coverScope  遮盖范围
 @param text        显示的文字
 */
+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text;



/**
 在当前View上显示菊花+文字+Y轴偏移量
 
 @param coverScope  遮盖范围
 @param text        显示的文字
 @param offsetY     Y轴偏移量
 */
+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text offsetY:(CGFloat)offsetY;





#pragma mark - 在某个View上显示
/**
 在某个View上显示菊花，默认遮盖范围为整个view
 
 @param view        显示progress的View
 */
+ (void)showProgressOnView:(UIView *)view;



/**
 在某个View上显示菊花+文字，默认遮盖范围为整个view
 
 @param view        显示progress的View
 @param text        显示的文字
 */
+ (void)showProgressOnView:(UIView *)view text:(NSString *)text;



/**
 在某个View上显示菊花
 
 @param view        显示progress的View
 @param coverScope  遮盖范围
 */
+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope;



/**
 在某个View上显示菊花+文字
 
 @param view        显示progress的View
 @param coverScope  遮盖范围
 @param text        显示的文字
 */
+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text;



/**
 在某个View上显示菊花+文字+Y轴偏移量
 
 @param view        显示progress的View
 @param coverScope  遮盖范围
 @param text        显示的文字
 @param offsetY     Y轴偏移量
 */
+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text offsetY:(CGFloat)offsetY;





#pragma mark - 隐藏
/** 隐藏window以及当前Controller的view上的最近的一个HUD */
+ (void)hideHUD;

/** 隐藏view上最近的一个HUD */
+ (void)hideHUDOnView:(UIView *)view;





#pragma mark - 在主窗口显示提示信息
/** 在主窗口上只显示文本信息，并且1.5秒钟后隐藏，背景可以点击 */
+ (void)showMessage:(NSString *)message;

/** 在主窗口上只显示文本信息，并且1.5秒钟后隐藏，根据coverScope参数决定覆盖范围 */
+ (void)showMessage:(NSString *)message coverScope:(MBProgressHUDCoverScope)coverScope;

/** 在主窗口上显示成功信息，并且1.5秒钟后隐藏 */
+ (void)showSuccess:(NSString *)success;

/** 在主窗口上显示成功信息，并且1.5秒钟后隐藏，根据coverScope参数决定覆盖范围 */
+ (void)showSuccess:(NSString *)success coverScope:(MBProgressHUDCoverScope)coverScope;

/** 在主窗口上显示失败信息，并且1.5秒钟后隐藏 */
+ (void)showError:(NSString *)error;

/** 在主窗口上显示失败信息，并且1.5秒钟后隐藏，根据coverScope参数决定覆盖范围 */
+ (void)showError:(NSString *)error coverScope:(MBProgressHUDCoverScope)coverScope;



@end
