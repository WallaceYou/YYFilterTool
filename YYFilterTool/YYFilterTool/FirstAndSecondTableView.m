//
//  FirstAndSecondTableView.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "FirstAndSecondTableView.h"
#import "YYFilterToolMacro.h"
#import "Masonry.h"
#import "FirstAndSecondConditionModel.h"


@interface FirstAndSecondConditionListCell : UITableViewCell

@property (nonatomic, strong) UILabel *conditionNameLb;

@property (nonatomic, strong) UIView *indexBgView;

@property (nonatomic, strong) UILabel *indexLb;

@end

@implementation FirstAndSecondConditionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //启动懒加载
        self.indexLb.hidden = NO;
        self.conditionNameLb.hidden = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)conditionNameLb {
    if (!_conditionNameLb) {
        _conditionNameLb = [UILabel new];
        _conditionNameLb.numberOfLines = 0;
        _conditionNameLb.font = [UIFont systemFontOfSize:14];
        _conditionNameLb.textColor = LightBlackColor;
        _conditionNameLb.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_conditionNameLb];
        [_conditionNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(self.indexBgView.mas_left).mas_equalTo(-3);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _conditionNameLb;
}

- (UILabel *)indexLb {
    if (!_indexLb) {
        _indexLb = [UILabel new];
        
        UIView *indexBgView = [UIView new];
        indexBgView.backgroundColor = BrightBlueColor;
        indexBgView.layer.cornerRadius = 7.5;
        
        [self.contentView addSubview:indexBgView];
        [indexBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.mas_equalTo(5);
        }];
        self.indexBgView = indexBgView;
        
        _indexLb.textColor = [UIColor whiteColor];
        _indexLb.font = [UIFont systemFontOfSize:12];
        _indexLb.text = @"2";
        [indexBgView addSubview:_indexLb];
        [_indexLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
    }
    return _indexLb;
}


@end



@interface FirstAndSecondTableView () <UITableViewDelegate, UITableViewDataSource>

@end


@implementation FirstAndSecondTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = BgGreyColor;
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[FirstAndSecondConditionListCell class] forCellReuseIdentifier:@"FirstAndSecondConditionListCell"];
    }
    return self;
}

- (void)setDataModel:(FirstAndSecondConditionModel *)dataModel {
    _dataModel = dataModel;
    [self reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstAndSecondConditionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstAndSecondConditionListCell"];
    
    cell.conditionNameLb.text = [self.dataModel.dataSource objectAtIndex:indexPath.row];
    cell.indexBgView.hidden = !(self.dataModel.currentSelectConditionsCount > 0);
    cell.indexLb.text = [NSString stringWithFormat:@"%ld",self.dataModel.currentSelectConditionsCount];
    cell.backgroundColor = indexPath.row == self.dataModel.currentSelectCellIndex?[UIColor whiteColor]:BgGreyColor;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.先得到上一个点击的cell，并将背景色置为灰色
    UITableViewCell *lastCell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataModel.currentSelectCellIndex inSection:0]];
    lastCell.backgroundColor = BgGreyColor;

    //2.然后将点击的cell的背景变为白色
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //3.再将当前点击的index记录在dataModel中，这样的话在拖动时才不会导致混乱
    self.dataModel.currentSelectCellIndex = indexPath.row;
    
    //4.告诉外界
    [[NSNotificationCenter defaultCenter] postNotificationName:FirstAndSecondTableViewClick object:nil userInfo:@{@"indexPath":indexPath,@"tableView":self}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TabelViewCellHeight;
}





@end
