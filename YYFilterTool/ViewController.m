//
//  ViewController.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/7.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ViewController.h"
#import "YYFilterTool.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) YYFilterTool *filterTool;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}

- (IBAction)buttonClick:(id)sender {
    [self.filterTool popFilterViewWithStartY:150 completion:nil];
}

- (YYFilterTool *)filterTool {
    if (!_filterTool) {
        _filterTool = [YYFilterTool new];
        _filterTool.firstLevelElements = @[@"呵呵",@"信息",@"单独",@"嗷嗷"];
        _filterTool.secondLevelElements = @[@[@"呵呵",@"信息",@"单独",@"嗷嗷",@"呵呵",@"信息",@"单独",@"嗷嗷"],@[@"hh",@"若若",@"安安",@"圆圆",@"那你",@"慢慢",@"了解",@"好吧"],@[@"动画",@"点击",@"撒的",@"人家",@"发你",@"你是",@"大款",@"艾尔"]];
        _filterTool.levelType = YYFilterToolTypeDoubleLevel;
        _filterTool.multiSelectionEnable = YES;
        _filterTool.topConditionEnable = YES;
    }
    return _filterTool;
}


@end
