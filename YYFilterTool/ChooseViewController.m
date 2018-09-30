//
//  ChooseViewController.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/29.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ChooseViewController.h"
#import "YYFilterTool.h"
#import "FilterViewController.h"

@interface ChooseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *chooseArray;

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.title = @"样式选择";
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *chooseName = [self.chooseArray objectAtIndex:indexPath.row];
    cell.textLabel.text = chooseName;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *chooseName = [self.chooseArray objectAtIndex:indexPath.row];
    
    if (self.type == ChooseTypeFirst) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChooseViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"First"];
        vc.type = [chooseName isEqualToString:@"多选"]?ChooseTypeSecond:ChooseTypeThird;
        vc.multiSelectionEnable = [chooseName isEqualToString:@"多选"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (self.type == ChooseTypeSecond) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChooseViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"First"];
        vc.type = ChooseTypeThird;
        vc.topAndIndexCountEnable = [chooseName isEqualToString:@"顶部条件显示、角标显示"];
        vc.multiSelectionEnable = self.multiSelectionEnable;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else  {
        
        self.customImageEnable = [chooseName isEqualToString:@"自定义图片"];
        [self performSegueWithIdentifier:@"chooseToDetail" sender:nil];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"chooseToDetail"]) {
        FilterViewController *vc = segue.destinationViewController;
        vc.multiSelectionEnable = self.multiSelectionEnable;
        vc.topAndIndexCountEnable = self.topAndIndexCountEnable;
        vc.customImageEnable = self.customImageEnable;
    }
}


#pragma mark - Lazy
- (NSArray *)chooseArray {
    if (!_chooseArray) {
        
        switch (self.type) {
            case ChooseTypeFirst:
                _chooseArray = @[@"单选",@"多选"];
                break;
            case ChooseTypeSecond:
                _chooseArray = @[@"顶部条件显示、角标显示",@"都不显示"];
                break;
            case ChooseTypeThird:
                _chooseArray = @[@"自定义图片",@"默认图片"];
                break;
            default:
                break;
        }
        
    }
    return _chooseArray;
}




@end
