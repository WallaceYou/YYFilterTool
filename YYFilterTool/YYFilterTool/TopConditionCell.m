//
//  TopConditionCell.m
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "TopConditionCell.h"
#import "YYFilterToolMacro.h"
#import "Masonry.h"
#import "ExtensionButton.h"

#define LabelLeftRightInset     8


@interface TopConditionCell ()

/* 条件椭圆背景 */
@property (nonatomic, strong) UIView *ellipseBgView;

/* 条件名字 */
@property (nonatomic, strong) UILabel *conditionNameLb;

/* 删除按钮 */
@property (nonatomic, strong) ExtensionButton *deleteBtn;

@end

@implementation TopConditionCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //懒加载
        self.ellipseBgView.hidden = NO;
        self.conditionNameLb.hidden = NO;
        self.deleteBtn.hidden = NO;
        
    }
    return self;
}

- (void)setConditionName:(NSString *)conditionName {
    _conditionName = conditionName;
    
    self.conditionNameLb.text = conditionName;
}



#pragma mark - 懒加载

- (UIView *)ellipseBgView {
    if (!_ellipseBgView) {
        _ellipseBgView = [UIView new];
        _ellipseBgView.backgroundColor = BgGreyColor;
        _ellipseBgView.layer.cornerRadius = 10;
        [self.contentView addSubview:_ellipseBgView];
        [_ellipseBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerY.mas_equalTo(0);
            make.height.mas_equalTo(26);
        }];
    }
    return _ellipseBgView;
}

- (UILabel *)conditionNameLb {
    if (!_conditionNameLb) {
        _conditionNameLb = [UILabel new];
        _conditionNameLb.textColor = LightBlackColor;
        _conditionNameLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_conditionNameLb];
        [_conditionNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.ellipseBgView.mas_left).mas_equalTo(LabelLeftRightInset);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _conditionNameLb;
}

- (ExtensionButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [ExtensionButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setImage:[UIImage imageNamed:@"small_remove"] forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteBtn];
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.ellipseBgView.mas_right).mas_equalTo(-LabelLeftRightInset);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _deleteBtn;
}

- (void)deleteBtnClick:(UIButton *)deleteBtn {
    [[NSNotificationCenter defaultCenter] postNotificationName:FilterViewTopCollectionDeleteBtnClick object:nil userInfo:@{@"cell":self}];
}


@end
