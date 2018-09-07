//
//  ViewController.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/7.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ViewController.h"

#import "YYFilterView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) YYFilterView *filterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (IBAction)buttonClick:(id)sender {
    [self.filterView popFilterViewWithStartY:150 completion:nil];
}

- (YYFilterView *)filterView {
    if (!_filterView) {
        _filterView = [YYFilterView new];
        _filterView.firstLevelElements = @[@"呵呵",@"信息",@"单独",@"嗷嗷"];
        _filterView.secondLevelElements = @[@[@"呵呵",@"信息",@"单独",@"嗷嗷",@"呵呵",@"信息",@"单独",@"嗷嗷"],@[@"hh",@"若若",@"安安",@"圆圆",@"那你",@"慢慢",@"了解",@"好吧"],@[@"动画",@"点击",@"撒的",@"人家",@"发你",@"你是",@"大款",@"艾尔"]];
        _filterView.levelType = YYFilterViewTypeDoubleLevel;
        _filterView.multiSelectionEnable = YES;
        _filterView.topConditionEnable = YES;
    }
    return _filterView;
}


@end
