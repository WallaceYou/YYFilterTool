//
//  ThirdTableView.m
//  YYFilterTool
//
//  Created by yuyou on 2018/9/14.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ThirdTableView.h"
#import "YYFilterToolMacro.h"
#import "Masonry.h"
#import "ThirdConditionModel.h"

@interface ThirdConditionListCell : UITableViewCell

@property (nonatomic, strong) UILabel *conditionNameLb;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) NSDictionary *modelDic;

@end

@implementation ThirdConditionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //启动懒加载
        self.conditionNameLb.hidden = NO;
        self.selectBtn.hidden = NO;
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
            make.right.mas_equalTo(self.selectBtn.mas_left).mas_equalTo(-3);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _conditionNameLb;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.userInteractionEnabled = NO;
        UIImage *image = [UIImage imageNamed:@"select_square_grey"];
        [_selectBtn setImage:image forState:UIControlStateNormal];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-16);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _selectBtn;
}

- (void)setModelDic:(NSDictionary *)modelDic {
    _modelDic = modelDic;
    
    BOOL selected = [modelDic[@"selected"] boolValue];
    NSString *conditionName = modelDic[@"conditionName"];
    NSString *selectedBtnHighlightedName = modelDic[@"selectedBtnHighlightedName"];
    NSString *selectedBtnNormalName = modelDic[@"selectedBtnNormalName"];
    
    [self.selectBtn setImage:[UIImage imageNamed:selected?selectedBtnHighlightedName:selectedBtnNormalName] forState:UIControlStateNormal];
    self.conditionNameLb.text = conditionName;
}

@end


@interface ThirdTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ThirdTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        [self registerClass:[ThirdConditionListCell class] forCellReuseIdentifier:@"ThirdConditionListCell"];
    }
    return self;
}

- (void)setDataModel:(ThirdConditionModel *)dataModel {
    _dataModel = dataModel;
    [self reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThirdConditionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdConditionListCell"];
    
    NSMutableDictionary *modelDic = [NSMutableDictionary new];
    
    modelDic[@"selected"] = [self.dataModel.currentSelectedConditions objectAtIndex:indexPath.row];
    modelDic[@"conditionName"] = [self.dataModel.dataSource objectAtIndex:indexPath.row];
    modelDic[@"selectedBtnHighlightedName"] = self.dataModel.selectedBtnHighlightedName;
    modelDic[@"selectedBtnNormalName"] = self.dataModel.selectedBtnNormalName;
    
    cell.modelDic = modelDic;
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //更改数据源，刷新tableView
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.dataModel.currentSelectedConditions];
    
    if (mArray.count == 0) {
        return;
    }
    
    BOOL selected = [[mArray objectAtIndex:indexPath.row] boolValue];
    
    
    if (self.dataModel.multiSelectionEnable) {//如果支持多选
        if (selected) {//如果是已经选中的，点击则置为没选中
            [mArray replaceObjectAtIndex:indexPath.row withObject:@(NO)];
        } else {//如果是未选中的，则置为已选中
            [mArray replaceObjectAtIndex:indexPath.row withObject:@(YES)];
        }
    } else {//不支持多选
        //不管选没选中，都置为选中
        [mArray replaceObjectAtIndex:indexPath.row withObject:@(YES)];
    }
    
    //然后更改数据源
    self.dataModel.currentSelectedConditions = [mArray copy];
    
    //刷新表格
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //告诉外界
    [[NSNotificationCenter defaultCenter] postNotificationName:ThirdTableViewClick object:nil userInfo:@{@"indexPath":indexPath}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TabelViewCellHeight;
}



@end
