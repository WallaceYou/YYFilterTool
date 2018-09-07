//
//  ConditionListCell.m
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ConditionListCell.h"
#import "YYFilterViewMacro.h"
#import "ConditionListModel.h"
#import "Masonry.h"

@interface ConditionListCell ()

@property (nonatomic, strong) UILabel *conditionNameLb;

@property (nonatomic, strong) UIView *indexBgView;

@property (nonatomic, strong) UILabel *indexLb;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation ConditionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //启动懒加载
        self.conditionNameLb.hidden = NO;
        self.indexLb.hidden = NO;
        self.selectBtn.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setModel:(ConditionListModel *)model {
    _model = model;
    
    if (model.levelType == 1) {//第一层
        
        self.backgroundColor = model.cellSelected?[UIColor whiteColor]:BgGreyColor;
        
    } else {//第二层
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.conditionNameLb.text = model.conditionName;
    
    if (model.levelType == 1) {
        [self.conditionNameLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.selectBtn.mas_left).mas_equalTo(34);
        }];
    } else {
        [self.conditionNameLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.selectBtn.mas_left).mas_equalTo(-3);
        }];
    }
    
    self.selectBtn.hidden = model.levelType == 1;
    self.indexBgView.hidden = !(model.indexNumber > 0);
    self.indexLb.text = [NSString stringWithFormat:@"%ld",model.indexNumber];
//    self.selectBtn.hidden = !model.multiSelectionEnable;
    [self.selectBtn setImage:[UIImage imageNamed:model.boxSelected?model.selectedBtnHighlightedName:model.selectedBtnNormalName] forState:UIControlStateNormal];
    
    self.selectionStyle = model.levelType == 1?UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
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
            make.top.mas_equalTo(self.conditionNameLb).offset(-5);
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

@end
