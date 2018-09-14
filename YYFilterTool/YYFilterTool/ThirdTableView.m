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
//    if (tableView == self.firstLevelTableView) {//如果是点击的是第一层tableView
//        
//        if (self.levelType == YYBaseFilterTypeSingleLevel) {//如果是一层筛选
//            
//            if (self.multiSelectionEnable) {
//                
//                //先在当前条件中寻找，如果有此条件则删除，并刷新
//                NSArray *indexModelArray = [self.currentConditions copy];
//                
//                for (FilterSelectIndexModel *indexModel in indexModelArray) {
//                    if (indexModel.index == indexPath.row) {
//                        
//                        NSInteger index = [indexModelArray indexOfObject:indexModel];
//                        
//                        [self.currentConditions removeObjectAtIndex:index];
//                        self.topConditionCollectionView.conditions = self.currentConditions;
//                        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//                        [self.firstLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                        return;
//                    }
//                }
//                
//            }
//            
//            
//            
//            //如果没找到，则将此条件添加到self.currentConditions中去
//            FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
//            secondModel.filterName = [self.firstLevelElements objectAtIndex:indexPath.row];
//            secondModel.index = indexPath.row;
//            secondModel.subIndex = nil;
//            
//            if (!self.multiSelectionEnable) {
//                [self.currentConditions removeAllObjects];
//            }
//            
//            [self.currentConditions addObject:secondModel];
//            
//            //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
//            self.topConditionCollectionView.conditions = self.currentConditions;
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            
//            //然后刷新第二层tableView点击的这一行
//            [self.firstLevelTableView reloadData];
//            
//            if (self.multiSelectionEnable == NO) {//如果不支持多选，则直接返回
//                [self.confirmBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//            }
//            
//            
//        } else if (self.levelType == YYBaseFilterTypeDoubleLevel) {//如果是两层筛选
//            
//            //先得到上一个点击的cell，并将背景色置为灰色
//            UITableViewCell *lastCell = [self.firstLevelTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]];
//            lastCell.backgroundColor = BgGreyColor;
//            
//            //然后将点击的cell的背景变为白色
//            UITableViewCell *cell = [self.firstLevelTableView cellForRowAtIndexPath:indexPath];
//            cell.backgroundColor = [UIColor whiteColor];
//            
//            //然后将当前选择的cell信息记录下来，保存在self.indexModel中
//            FilterSelectIndexModel *indexModel = [FilterSelectIndexModel new];
//            indexModel.filterName = [self.firstLevelElements objectAtIndex:indexPath.row];
//            indexModel.index = indexPath.row;
//            indexModel.subIndex = nil;
//            self.indexModel = indexModel;
//            
//            
//            //如果允许多选
//            if (self.multiSelectionEnable) {
//                
//                //删除现有所有条件
//                [self.currentConditions removeAllObjects];
//                
//                //一个for循环全选所有二级条件
//                NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
//                
//                for (NSString *secondFilter in secondElements) {
//                    
//                    FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
//                    secondModel.filterName = secondFilter;
//                    secondModel.index = [secondElements indexOfObject:secondFilter];
//                    secondModel.subIndex = nil;
//                    
//                    BOOL isExist = NO;
//                    
//                    for (FilterSelectIndexModel *model in self.currentConditions) {
//                        if (model.subIndex.index == secondModel.index && model.index == self.indexModel.index) {
//                            isExist = YES;
//                            break;
//                        }
//                    }
//                    
//                    if (isExist) {
//                        continue;
//                    }
//                    
//                    
//                    FilterSelectIndexModel *firstModel = [FilterSelectIndexModel new];
//                    firstModel.filterName = self.indexModel.filterName;
//                    firstModel.index = self.indexModel.index;
//                    firstModel.subIndex = secondModel;
//                    
//                    
//                    [self.currentConditions addObject:firstModel];
//                    
//                }
//                
//                //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
//                self.topConditionCollectionView.conditions = self.currentConditions;
//                
//                [self.secondLevelTableView reloadData];
//                [self.firstLevelTableView reloadData];
//            }
//            
//            
//        }
//        
//    } else {//如果点击的是第二层tableView
//        
//        if (self.multiSelectionEnable) {
//            //先在当前条件中寻找，如果有此条件则删除，并刷新
//            NSArray *indexModelArray = [self.currentConditions copy];
//            
//            for (FilterSelectIndexModel *indexModel in indexModelArray) {
//                if (indexModel.index == self.indexModel.index && indexModel.subIndex.index == indexPath.row) {
//                    
//                    NSInteger index = [indexModelArray indexOfObject:indexModel];
//                    
//                    [self.currentConditions removeObjectAtIndex:index];
//                    self.topConditionCollectionView.conditions = self.currentConditions;
//                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//                    [self.secondLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                    
//                    
//                    [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                    
//                    return;
//                }
//            }
//            
//        }
//        
//        
//        
//        //如果没找到，则将此条件添加到self.currentConditions中去
//        NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
//        FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
//        secondModel.filterName = [secondElements objectAtIndex:indexPath.row];
//        secondModel.index = indexPath.row;
//        secondModel.subIndex = nil;
//        
//        FilterSelectIndexModel *firstModel = [FilterSelectIndexModel new];
//        firstModel.filterName = self.indexModel.filterName;
//        firstModel.index = self.indexModel.index;
//        firstModel.subIndex = secondModel;
//        
//        if (!self.multiSelectionEnable) {
//            [self.currentConditions removeAllObjects];
//        }
//        
//        [self.currentConditions addObject:firstModel];
//        
//        //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
//        self.topConditionCollectionView.conditions = self.currentConditions;
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        //然后刷新第二层tableView点击的这一行
//        [self.secondLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        if (self.multiSelectionEnable == NO) {//如果不支持多选，则直接返回
//            [self.confirmBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//        }
//        
//        
//        [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//        
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TabelViewCellHeight;
}



@end
