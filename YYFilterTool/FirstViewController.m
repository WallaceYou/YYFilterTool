//
//  FirstViewController.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/29.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "FirstViewController.h"
#import "YYFilterTool.h"
#import "FilterViewController.h"

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *chooseArray;

@end

@implementation FirstViewController

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

    YYFilterTool *tool = [YYFilterTool shareInstance];

    NSString *chooseName = [self.chooseArray objectAtIndex:indexPath.row];
    if ([chooseName isEqualToString:@"多选"]) {
        tool.multiSelectionEnable = YES;
    }
    
    [self performSegueWithIdentifier:@"chooseToDetail" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"chooseToDetail"]) {
        NSLog(@"haha");
    }
}


#pragma mark - Lazy
- (NSArray *)chooseArray {
    if (!_chooseArray) {
        _chooseArray = @[@"单选",@"多选"];
    }
    return _chooseArray;
}




@end
