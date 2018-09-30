//
//  MBProgressHUD+YYUtils.m
//  MBProgressHUD
//
//  Created by yuyou on 16/1/8.
//  Copyright © 2016年 yuyou. All rights reserved.
//

#import "MBProgressHUD+YYUtils.h"
#import "Masonry.h"

#define DURATION 1.5
#define HUD_BORDER_LENGTH 200
#define kWindowH [UIScreen mainScreen].bounds.size.height
#define kWindowW [UIScreen mainScreen].bounds.size.width

static MBProgressHUDType mbType = MBProgressHUDTypeClassic;

@implementation MBProgressHUD (YYUtils)

#pragma mark - 设置HUD的显示样式
+ (void)setMBProgressHUDType:(MBProgressHUDType)type {
    mbType = type;
}





#pragma mark - 在窗口上显示
+ (void)showProgressOnWindow {
    [self showProgressOnWindowText:@""];
}



+ (void)showProgressOnWindowText:(NSString *)text {
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [self getDefaultHUDWithMode:MBProgressHUDModeIndeterminate];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    [keyWindow addSubview:hud];
}





#pragma mark - 在当前View上显示
+ (void)showProgressOnCurrentView {
    [self showProgressOnCurrentViewCoverScope:MBProgressHUDCoverScopeView];
}



+ (void)showProgressOnCurrentViewText:(NSString *)text {
    [self showProgressOnCurrentViewCoverScope:MBProgressHUDCoverScopeView text:text];
}



+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope {
    //不设置Y轴偏移量与文字，则默认只显示一个居中的菊花
    [self showProgressOnCurrentViewCoverScope:coverScope text:@"" offsetY:0];
}



+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text {
    //不设置Y轴偏移量，则默认居中显示
    [self showProgressOnCurrentViewCoverScope:coverScope text:text offsetY:0];
}



+ (void)showProgressOnCurrentViewCoverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text offsetY:(CGFloat)offsetY {
    UIView *currentView = [self currentViewController].view;
    [self showProgressOnView:currentView coverScope:coverScope text:text offsetY:offsetY];
}





#pragma mark - 在某个View上显示
+ (void)showProgressOnView:(UIView *)view {
    [self showProgressOnView:view coverScope:MBProgressHUDCoverScopeView];
}



+ (void)showProgressOnView:(UIView *)view text:(NSString *)text {
    [self showProgressOnView:view coverScope:MBProgressHUDCoverScopeView text:text];
}



+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope {
    //不设置Y轴偏移量与文字，则默认只显示一个居中的菊花
    [self showProgressOnView:view coverScope:coverScope text:@"" offsetY:0];
}



+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text {
    //不设置Y轴偏移量，则默认居中显示
    [self showProgressOnView:view coverScope:coverScope text:text offsetY:0];
}



+ (void)showProgressOnView:(UIView *)view coverScope:(MBProgressHUDCoverScope)coverScope text:(NSString *)text offsetY:(CGFloat)offsetY {
    
    //获取一个默认的hud，再进行相应自定义
    MBProgressHUD *hud = [self getDefaultHUDWithMode:MBProgressHUDModeIndeterminate];
    hud.label.text = text;
    hud.offset = CGPointMake(0, offsetY);
    [view addSubview:hud];
    
    if (coverScope == MBProgressHUDCoverScopeNone) {//如果不遮盖任何部分，则将用户响应取消，即点击到hud上的响应会传递到下一层响应链上
        hud.userInteractionEnabled = NO;
    }
}





#pragma mark - 隐藏
+ (void)hideHUD {
    
    //将window上的隐藏掉
    [self hideHUDOnView:nil];
    
    //将currentView上的隐藏掉
    [self hideHUDOnView:[self currentViewController].view];
}

+ (void)hideHUDOnView:(UIView *)view {
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideHUDForView:view animated:YES];
        return;
    }
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark - 在主窗口显示提示信息
+ (void)showMessage:(NSString *)message {
    [self showMessage:message coverScope:MBProgressHUDCoverScopeNone];
}


+ (void)showMessage:(NSString *)message coverScope:(MBProgressHUDCoverScope)coverScope {
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    //获取一个默认的hud，再进行相应自定义
    MBProgressHUD *hud = [self getDefaultHUDWithMode:MBProgressHUDModeText];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:DURATION];
    if (coverScope == MBProgressHUDCoverScopeNone) {//如果不遮盖任何部分，则将用户响应取消，即点击到hud上的响应会传递到下一层响应链上
        hud.userInteractionEnabled = NO;
    }
    [window addSubview:hud];
}


+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success coverScope:MBProgressHUDCoverScopeNone];
}

+ (void)showSuccess:(NSString *)success coverScope:(MBProgressHUDCoverScope)coverScope {
    [self showText:success icon:@"MBProgressHUD_success.png" coverScope:coverScope];
}


+ (void)showError:(NSString *)error {
    [self showError:error coverScope:MBProgressHUDCoverScopeNone];
}

+ (void)showError:(NSString *)error coverScope:(MBProgressHUDCoverScope)coverScope {
    [self showText:error icon:@"MBProgressHUD_error.png" coverScope:coverScope];
}


#pragma mark - 私有方法
+ (MBProgressHUD *)getDefaultHUDWithMode:(MBProgressHUDMode)mode {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.layer.cornerRadius = 10.0;
    hud.mode = mode;
    
    if (mbType == MBProgressHUDTypeClassic) {
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        hud.label.textColor = [UIColor whiteColor];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    }
    
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [hud showAnimated:YES];
    return hud;
}


+ (void)showText:(NSString *)text icon:(NSString *)icon coverScope:(MBProgressHUDCoverScope)coverScope {
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    //获取一个默认的hud，再进行相应自定义
    MBProgressHUD *hud = [self getDefaultHUDWithMode:MBProgressHUDModeCustomView];
    
    //自定义视图
    UIView *customView = [[UIView alloc] init];
    
    //显示的错误或者成功图片icon
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [customView addSubview:imageView];
    
    //提示label
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    if (mbType == MBProgressHUDTypeClassic) {
        textLabel.textColor = [UIColor whiteColor];
    }
    textLabel.text = text;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [customView addSubview:textLabel];
    
    //准备VFL中子视图与实际对象引用之间的关联关系的字典
    NSDictionary *diction = NSDictionaryOfVariableBindings(imageView, textLabel);
    
    //创建一个VFL中的长度参照表
    NSDictionary *metrics = @{@"left":@0,@"right":@0,@"top":@0,@"bottom":@0,@"space":@(10)};

    //VFL水平方向表达式
    NSString *hVFL = @"H:|-left-[textLabel]-right-|";
    NSArray *hcs = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:0 metrics:metrics views:diction];
    [customView addConstraints:hcs];
    
    //VFL竖直方向表达式
    NSString *vVFL = @"V:|-top-[imageView]-space-[textLabel]-bottom-|";
    NSArray *vcs = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:NSLayoutFormatAlignAllCenterX metrics:metrics views:diction];
    [customView addConstraints:vcs];
    
    //赋值自定义视图
    hud.customView = customView;
    [hud hideAnimated:YES afterDelay:DURATION];
    if (coverScope == MBProgressHUDCoverScopeNone) {//如果不遮盖任何部分，则将用户响应取消，即点击到hud上的响应会传递到下一层响应链上
        hud.userInteractionEnabled = NO;
    }
    
    [window addSubview:hud];
}

#pragma mark - 找到当前显示的控制器
+ (UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}


@end
