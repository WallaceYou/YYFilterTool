//
//  ViewController.m
//  YYBaseFilter
//
//  Created by yuyou on 2018/9/7.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ViewController.h"
#import "YYFilterTool.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) YYFilterTool *filterTool;//永远返回一个单例对象


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}


- (IBAction)sortbyBtnClick:(id)sender {
    
    self.filterTool.firstLevelElements = @[@"智能排序",@"离我最近",@"好评优先",@"人气最高"];
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
    self.filterTool.filterComplete = ^(NSArray *filters) {
        NSLog(@"%@",filters);
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
    
}


- (IBAction)nearbyBtnClick:(id)sender {
    
    NSMutableArray *firstLevelElements = [NSMutableArray new];
    NSMutableArray *secondLevelElements = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        [firstLevelElements addObject:[NSString stringWithFormat:@"市%i",i]];
        NSMutableArray *elements = [NSMutableArray new];
        for (int j = 0; j < random()%30+1; j++) {
            [elements addObject:[NSString stringWithFormat:@"市%i县%i",i,j]];
        }
        [secondLevelElements addObject:elements];
    }
    
    self.filterTool.firstLevelElements = firstLevelElements;
    self.filterTool.secondLevelElements = secondLevelElements;
    self.filterTool.levelType = YYBaseFilterTypeDoubleLevel;
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
    self.filterTool.filterComplete = ^(NSArray *filters) {
        NSLog(@"%@",filters);
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
    
}

- (IBAction)areaBtnClick:(id)sender {
    NSMutableArray *firstLevelElements = [NSMutableArray new];
    NSMutableArray *secondLevelElements = [NSMutableArray new];
    NSMutableArray *thirdLevelElements = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        [firstLevelElements addObject:[NSString stringWithFormat:@"市%i",i]];
        NSMutableArray *elements = [NSMutableArray new];
        NSMutableArray *elementss = [NSMutableArray new];
        for (int j = 0; j < random()%30+1; j++) {
            [elements addObject:[NSString stringWithFormat:@"市%i县%i",i,j]];
            NSMutableArray *elementsss = [NSMutableArray new];
            for (int k = 0; k < random()%30+1; k++) {
                [elementsss addObject:[NSString stringWithFormat:@"市%i县%i镇%i",i,j,k]];
            }
            [elementss addObject:elementsss];
        }
        [secondLevelElements addObject:elements];
        [thirdLevelElements addObject:elementss];
    }
    
    self.filterTool.firstLevelElements = firstLevelElements;
    self.filterTool.secondLevelElements = secondLevelElements;
    self.filterTool.thirdLevelElement = thirdLevelElements;
    self.filterTool.levelType = YYBaseFilterTypeThreeLevel;
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
    self.filterTool.filterComplete = ^(NSArray *filters) {
        NSLog(@"%@",filters);
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
}

- (YYFilterTool *)filterTool {
    if (!_filterTool) {
        _filterTool = [YYFilterTool shareInstance];
    }
    return _filterTool;
}


@end
