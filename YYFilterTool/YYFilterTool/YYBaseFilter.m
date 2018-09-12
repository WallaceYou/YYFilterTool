//
//  YYBaseFilter.m
//  YYBaseFilter
//
//  Created by yuyou on 2018/7/28.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "YYBaseFilter.h"
#import "TopConditionCollectionView.h"
#import "ConditionListCell.h"
#import "ConditionListModel.h"

#define FirstLevelScale         0.35//如果是两层筛选，则第一层的tableView的宽度占总宽度的比例
#define TopAndBottomHeight      46//上面topConditionCollectionView的高度以及下面confirmBtn的高度
#define TabelViewCellHeight     50//tableView的行高，无论第一层还是第二层
#define MaxTableViewCellCount   7//最多显示7行，无论第一层还是第二层
#define AnimationDuration       .25


@interface YYBaseFilter () <UITableViewDelegate, UITableViewDataSource>

/* startY表示筛选视图相对于window的Y值是多少，即从Y轴的哪个位置开始 */
@property (nonatomic, assign) CGFloat startY;

/* 表示是否正在进行筛选视图的打开动画，防止在弹出时快速的点击多次导致调用多次关闭动画完成后的回调 */
@property (nonatomic, assign) BOOL ifCloseAnimating;

/* 顶部透明的点击可以收起筛选视图的背景 */
@property (nonatomic, strong) UIButton *topBgClearButton;

/* 点击可以收起筛选视图的黑色背景视图 */
@property (nonatomic, strong) UIButton *shadowBgButton;


@property (nonatomic, strong) UIView *filterView;

/* 头部的条件框collectionView */
@property (nonatomic, strong) TopConditionCollectionView *topConditionCollectionView;

/* 头部条件框下的线 */
@property (nonatomic, strong) UIView *lineView;

/* 一级tableView */
@property (nonatomic, strong) UITableView *firstLevelTableView;

/* 二级tableView */
@property (nonatomic, strong) UITableView *secondLevelTableView;

/* 确定按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;

/* 表示当前选择的索引 */
@property (nonatomic, strong) FilterSelectIndexModel *indexModel;

/* 表示关闭动画完成后的回调 */
@property (nonatomic, copy) void(^closeAnimateComplete)(void);

@end

@implementation YYBaseFilter {
    
    BOOL _allowTopCondition;
}


#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        self.ifCloseAnimating = NO;//关闭动画还没有开始，所以默认已经是NO
        self.levelType = YYBaseFilterTypeSingleLevel;//默认一层
        [self initFilterViews];
        
    }
    
    return self;
}


- (void)dealloc {
    NSLog(@"筛选视图已销毁");
}

#pragma mark - Privite Func
- (void)initFilterViews {
    
    
    UIView *kWindow = [UIApplication sharedApplication].delegate.window;
    
    
    _topBgClearButton = [UIButton new];
    _topBgClearButton.backgroundColor = [UIColor clearColor];
    [_topBgClearButton addTarget:self action:@selector(shadowBgButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [kWindow addSubview:_topBgClearButton];
    
    
    _shadowBgButton = [UIButton new];
    _shadowBgButton.backgroundColor = [UIColor blackColor];
    [_shadowBgButton addTarget:self action:@selector(shadowBgButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [kWindow addSubview:_shadowBgButton];
    
    _filterView = [UIView new];
    [kWindow addSubview:_filterView];
    
    //顶部已经筛选的条件
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _topConditionCollectionView = [[TopConditionCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _topConditionCollectionView.backgroundColor = [UIColor whiteColor];
    _topConditionCollectionView.showsHorizontalScrollIndicator = NO;
    [_filterView addSubview:_topConditionCollectionView];
    
    //顶部已筛选的条件下方的那根线
    _lineView = [UIView new];
    _lineView.backgroundColor = BgGreyColor;
    [_filterView addSubview:_lineView];
    
    
    //底部确定按钮
    //    _confirmBtn = [UIButton buttonWithTitle:@"完成" titleColor:WhiteColor textFont:FONT_SystemFontSize(FONT_SIZE_TITLE) buttonBgColor:BrightBlueColor];
    _confirmBtn = [UIButton new];
    [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_confirmBtn setBackgroundImage:[self createImageWithColor:BrightBlueColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_filterView addSubview:_confirmBtn];
    
    //一级条件
    _firstLevelTableView = [UITableView new];
    _firstLevelTableView.delegate = self;
    _firstLevelTableView.dataSource = self;
    _firstLevelTableView.backgroundColor = BgGreyColor;
    _firstLevelTableView.tableFooterView = [UIView new];
    [_firstLevelTableView registerClass:[ConditionListCell class] forCellReuseIdentifier:@"ConditionListCell"];
    [_filterView addSubview:_firstLevelTableView];
    
    //二级条件
    _secondLevelTableView = [UITableView new];
    _secondLevelTableView.delegate = self;
    _secondLevelTableView.dataSource = self;
    _secondLevelTableView.tableFooterView = [UIView new];
    [_secondLevelTableView registerClass:[ConditionListCell class] forCellReuseIdentifier:@"ConditionListCell"];
    [_filterView addSubview:_secondLevelTableView];
}


#pragma mark - Setter
- (void)setFirstLevelElements:(NSArray *)firstLevelElements {
    _firstLevelElements = firstLevelElements;
    [self.firstLevelTableView reloadData];
}

- (void)setSecondLevelElements:(NSArray *)secondLevelElements {
    _secondLevelElements = secondLevelElements;
    [self.secondLevelTableView reloadData];
}

- (void)setTopConditionEnable:(BOOL)topConditionEnable {
    
    if (self.multiSelectionEnable) {
        //首先检查是否允许多选，只有允许多选的情况才可以设置显示topCondition
        _topConditionEnable = topConditionEnable;
        
    } else {//如果不允许多选，可以先设置到_allowTopCondition这里
        _allowTopCondition = topConditionEnable;
    }
}

- (void)setMultiSelectionEnable:(BOOL)multiSelectionEnable {
    _multiSelectionEnable = multiSelectionEnable;
    
    //设置完之后看看_topConditionEnable是否为YES，如果为YES说明之前设置了topConditionEnable，只不过当时还没设置multiSelectionEnable，此时可以设置topConditionEnable了
    _topConditionEnable = _allowTopCondition;
}


- (void)setIndexModel:(FilterSelectIndexModel *)indexModel {
    _indexModel = indexModel;
    [self.secondLevelTableView reloadData];
}


#pragma mark - Public Func
/* 开始动画，弹出筛选视图，startY表示筛选视图相对于window的Y值是多少，即从Y轴的哪个位置开始，另外两个回调分别是视图展开动画完成后的回调，视图关闭动画完成后的回调 */
- (void)popFilterViewWithStartY:(CGFloat)startY startAnimateComplete:(void (^)(void))startAnimateComplete closeAnimateComplete:(void (^)(void))closeAnimateComplete {
    
    if (self == nil) {
        return;
    }
    
    self.closeAnimateComplete = closeAnimateComplete;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topFilterDeleteBtnClick:) name:@"FilterViewTopCollectionDeleteBtnClick" object:nil];
    
    self.startY = startY;
    
    
    //计算topConditionCollectionView的高度
    CGFloat topColletionHeight = self.topConditionEnable?TopAndBottomHeight:0;
    
    //计算confirmBtn的高度
    CGFloat confirmBtnHeight = self.multiSelectionEnable?TopAndBottomHeight:0;
    _confirmBtn.hidden = !self.multiSelectionEnable;
    
    //计算得到数量最多的一个数组有几个元素
    NSInteger maxElement = 0;
    
    for (NSArray *secondElements in self.secondLevelElements) {//先比较第二层
        if (secondElements.count > maxElement) {
            maxElement = secondElements.count;
        }
    }
    
    if (self.firstLevelElements.count > maxElement) {//再比较第一层
        maxElement = self.firstLevelElements.count;
    }
    
    if (maxElement > MaxTableViewCellCount) {//最多只能有七行，即最多350高
        maxElement = MaxTableViewCellCount;
    }
    
    //计算tableView的高度和宽度
    CGFloat tableViewHeight = TabelViewCellHeight*maxElement;
    
    CGFloat firstTableWidth = kWindowW*(self.levelType==YYBaseFilterTypeSingleLevel?1:FirstLevelScale);
    CGFloat secondTableWidth = kWindowW*(self.levelType==YYBaseFilterTypeSingleLevel?0:(1-FirstLevelScale));
    
    //计算self的高度
    CGFloat popViewHeight = topColletionHeight+tableViewHeight+confirmBtnHeight;
    
    
    //先确定视图的开始位置
    self.topBgClearButton.frame = CGRectMake(0, 0, kWindowW, startY);
    self.filterView.frame = CGRectMake(0, startY, kWindowW, 0);
    self.topConditionCollectionView.frame = CGRectMake(0, 0, kWindowW, 0);
    self.lineView.frame = CGRectMake(0, 0, kWindowW, 0);
    self.firstLevelTableView.frame = CGRectMake(0, 0, firstTableWidth, 0);;
    self.secondLevelTableView.frame = CGRectMake(firstTableWidth, 0, secondTableWidth, 0);
    self.confirmBtn.frame = CGRectMake(0, 0, kWindowW, 0);
    
    self.shadowBgButton.frame = CGRectMake(0, startY, kWindowW, kWindowH - startY);
    self.shadowBgButton.alpha = 0.0;
    
    //如果是多于一层的筛选，则将第一层的第一个cell的颜色置为白色（即默认已经选中了第一个）
    //    if (self.levelType != YYBaseFilterTypeSingleLevel) {
    //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //        [self tableView:self.firstLevelTableView didSelectRowAtIndexPath:indexPath];
    //    }
    
    //两层则没有分割线，一层则有
    _firstLevelTableView.separatorStyle = self.levelType == YYBaseFilterTypeSingleLevel?UITableViewCellSeparatorStyleSingleLine:UITableViewCellSeparatorStyleNone;
    
    //出现的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        
        self.filterView.frame = CGRectMake(0, startY, kWindowW, popViewHeight);
        self.topConditionCollectionView.frame = CGRectMake(0, 0, kWindowW, topColletionHeight);
        self.lineView.frame = CGRectMake(0, TopAndBottomHeight-1, kWindowW, 1);
        self.firstLevelTableView.frame = CGRectMake(0, topColletionHeight, firstTableWidth, tableViewHeight);
        self.secondLevelTableView.frame = CGRectMake(firstTableWidth, topColletionHeight, secondTableWidth, tableViewHeight);
        self.confirmBtn.frame = CGRectMake(0, topColletionHeight+tableViewHeight, kWindowW, confirmBtnHeight);
        
        self.shadowBgButton.alpha = 0.8;
        
    } completion:^(BOOL finished) {
        
        if (startAnimateComplete) {
            startAnimateComplete();
        }
    }];
}


/* 关闭筛选视图 */
- (void)closeFilterViewCompletion:(void(^)(void))completion {
    
    //如果正在进行关闭动画，那么返回
    if (self.ifCloseAnimating) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FilterViewTopCollectionDeleteBtnClick" object:nil];
    
    //计算tableView的宽度
    CGFloat firstTableWidth = kWindowW*(self.levelType==YYBaseFilterTypeSingleLevel?1:FirstLevelScale);
    CGFloat secondTableWidth = kWindowW*(self.levelType==YYBaseFilterTypeSingleLevel?0:(1-FirstLevelScale));
    
    //关闭动画开始，则此值置为yes
    self.ifCloseAnimating = YES;
    //消失的动画
    [UIView animateWithDuration:AnimationDuration animations:^{
        
        //将self及self的子视图都置为最初的位置
        self.topConditionCollectionView.frame = CGRectMake(0, 0, kWindowW, 0);
        self.lineView.frame = CGRectMake(0, 0, kWindowW, 0);
        self.firstLevelTableView.frame = CGRectMake(0, 0, firstTableWidth, 0);
        self.secondLevelTableView.frame = CGRectMake(firstTableWidth, 0, secondTableWidth, 0);
        self.confirmBtn.frame = CGRectMake(0, 0, kWindowW, 0);
        self.filterView.frame = CGRectMake(0, self.startY, kWindowW, 0);
        
        self.shadowBgButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.filterView.superview) {
            [self.filterView removeFromSuperview];
        }

        if (self.topBgClearButton.subviews) {
            [self.topBgClearButton removeFromSuperview];
        }

        if (self.shadowBgButton.superview) {
            [self.shadowBgButton removeFromSuperview];
        }
        
        self.ifCloseAnimating = NO;//表示动画已结束
        
        if (completion) {
            completion();
        }
        
        
        if (self.closeAnimateComplete) {
            self.closeAnimateComplete();
        }
    }];
}


#pragma mark - Button Click

- (void)shadowBgButtonClick {
    
    [self closeFilterViewCompletion:nil];
}

- (void)confirmBtnClick {
    
    [self closeFilterViewCompletion:^{
        
        if (self.filterComplete) {
            self.filterComplete(self.currentConditions);
        }
    }];
    
}

#pragma mark - Notification Func
- (void)topFilterDeleteBtnClick:(NSNotification *)notification {
    
    //得到当前点击的按钮的序号
    NSDictionary *userInfo = notification.userInfo;
    UICollectionViewCell *cell = userInfo[@"cell"];
    NSIndexPath *indexPath = [self.topConditionCollectionView indexPathForCell:cell];
    
    if (indexPath.row >= self.currentConditions.count) {
        //        [MBProgressHUD showMessage:@"越界"];
        return;
    }
    
    //通过序号去当前选择的条件中删除相应序号的条件
    //先拿到那个条件
    FilterSelectIndexModel *indexModel = [self.currentConditions objectAtIndex:indexPath.row];
    
    //得到这个条件在第二层tableView中的序号
    NSIndexPath *secondIndexPath = [NSIndexPath indexPathForRow:indexModel.subIndex.index inSection:0];
    
    //把这个条件在条件数组中删除
    [self.currentConditions removeObjectAtIndex:indexPath.row];
    
    //更新条件collectionView
    self.topConditionCollectionView.conditions = self.currentConditions;
    
    if (indexModel.index == self.indexModel.index) {
        //更新这个条件对应于第二层tableView那一个cell
        [self.secondLevelTableView reloadRowsAtIndexPaths:@[secondIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    } else {
        [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}


#pragma mark - Private Func
- (UIImage *)createImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.firstLevelTableView) {
        return self.firstLevelElements.count;
    } else if (tableView == self.secondLevelTableView) {
        
        if (self.indexModel.index >= self.secondLevelElements.count) {
            return 0;
        }
        
        NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
        
        if ([secondElements isKindOfClass:[NSArray class]]) {
            return secondElements.count;
        } else {
            return 0;
        }
        
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConditionListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConditionListCell"];
    
    ConditionListModel *model = [ConditionListModel new];
    model.selectedBtnHighlightedName = self.selectedBtnHighlightedName;
    model.selectedBtnNormalName = self.selectedBtnNormalName;
    
    if (tableView == self.firstLevelTableView) {//如果是第一层tableView
        
        if (self.levelType == YYBaseFilterTypeSingleLevel) {//如果是一层筛选
            
            model.levelType = 2;
            model.conditionName = [self.firstLevelElements objectAtIndex:indexPath.row];
            
            for (FilterSelectIndexModel *indexModel in self.currentConditions) {
                if (indexModel.index == indexPath.row) {
                    model.boxSelected = YES;
                }
            }
            
        } else {//两层筛选
            model.levelType = 1;
            model.conditionName = [self.firstLevelElements objectAtIndex:indexPath.row];
            if (indexPath.row == self.indexModel.index) {
                model.cellSelected = YES;
            }
            
            
            NSInteger indexNumber = 0;
            for (FilterSelectIndexModel *model in self.currentConditions) {
                if (model.index == indexPath.row) {
                    indexNumber ++;
                }
            }
            
            model.indexNumber = indexNumber;
            
        }
        
    } else {//第二层tableView，则一定是两层筛选
        
        model.levelType = 2;
        
        NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
        if ([secondElements isKindOfClass:[NSArray class]]) {
            model.conditionName = [secondElements objectAtIndex:indexPath.row];
        } else {
            model.conditionName = @"";
        }
        
        for (FilterSelectIndexModel *indexModel in self.currentConditions) {
            if (indexModel.index == self.indexModel.index && indexModel.subIndex.index == indexPath.row) {
                model.boxSelected = YES;
            }
        }
    }
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.firstLevelTableView) {//如果是点击的是第一层tableView
        
        if (self.levelType == YYBaseFilterTypeSingleLevel) {//如果是一层筛选
            
            if (self.multiSelectionEnable) {
                
                //先在当前条件中寻找，如果有此条件则删除，并刷新
                NSArray *indexModelArray = [self.currentConditions copy];
                
                for (FilterSelectIndexModel *indexModel in indexModelArray) {
                    if (indexModel.index == indexPath.row) {
                        
                        NSInteger index = [indexModelArray indexOfObject:indexModel];
                        
                        [self.currentConditions removeObjectAtIndex:index];
                        self.topConditionCollectionView.conditions = self.currentConditions;
                        [tableView deselectRowAtIndexPath:indexPath animated:YES];
                        [self.firstLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        return;
                    }
                }
                
            }
            
            
            
            //如果没找到，则将此条件添加到self.currentConditions中去
            FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
            secondModel.filterName = [self.firstLevelElements objectAtIndex:indexPath.row];
            secondModel.index = indexPath.row;
            secondModel.subIndex = nil;
            
            if (!self.multiSelectionEnable) {
                [self.currentConditions removeAllObjects];
            }
            
            [self.currentConditions addObject:secondModel];
            
            //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
            self.topConditionCollectionView.conditions = self.currentConditions;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            //然后刷新第二层tableView点击的这一行
            [self.firstLevelTableView reloadData];
            
            if (self.multiSelectionEnable == NO) {//如果不支持多选，则直接返回
                [self.confirmBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
            
        } else if (self.levelType == YYBaseFilterTypeDoubleLevel) {//如果是两层筛选
            
            //先得到上一个点击的cell，并将背景色置为灰色
            UITableViewCell *lastCell = [self.firstLevelTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]];
            lastCell.backgroundColor = BgGreyColor;
            
            //然后将点击的cell的背景变为白色
            UITableViewCell *cell = [self.firstLevelTableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            
            //然后将当前选择的cell信息记录下来，保存在self.indexModel中
            FilterSelectIndexModel *indexModel = [FilterSelectIndexModel new];
            indexModel.filterName = [self.firstLevelElements objectAtIndex:indexPath.row];
            indexModel.index = indexPath.row;
            indexModel.subIndex = nil;
            self.indexModel = indexModel;
            
            
            //如果允许多选
            if (self.multiSelectionEnable) {
                
                //删除现有所有条件
                [self.currentConditions removeAllObjects];
                
                //一个for循环全选所有二级条件
                NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
                
                for (NSString *secondFilter in secondElements) {
                    
                    FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
                    secondModel.filterName = secondFilter;
                    secondModel.index = [secondElements indexOfObject:secondFilter];
                    secondModel.subIndex = nil;
                    
                    BOOL isExist = NO;
                    
                    for (FilterSelectIndexModel *model in self.currentConditions) {
                        if (model.subIndex.index == secondModel.index && model.index == self.indexModel.index) {
                            isExist = YES;
                            break;
                        }
                    }
                    
                    if (isExist) {
                        continue;
                    }
                    
                    
                    FilterSelectIndexModel *firstModel = [FilterSelectIndexModel new];
                    firstModel.filterName = self.indexModel.filterName;
                    firstModel.index = self.indexModel.index;
                    firstModel.subIndex = secondModel;
                    
                    
                    [self.currentConditions addObject:firstModel];
                    
                }
                
                //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
                self.topConditionCollectionView.conditions = self.currentConditions;
                
                [self.secondLevelTableView reloadData];
                [self.firstLevelTableView reloadData];
            }
            
            
        }
        
    } else {//如果点击的是第二层tableView
        
        if (self.multiSelectionEnable) {
            //先在当前条件中寻找，如果有此条件则删除，并刷新
            NSArray *indexModelArray = [self.currentConditions copy];
            
            for (FilterSelectIndexModel *indexModel in indexModelArray) {
                if (indexModel.index == self.indexModel.index && indexModel.subIndex.index == indexPath.row) {
                    
                    NSInteger index = [indexModelArray indexOfObject:indexModel];
                    
                    [self.currentConditions removeObjectAtIndex:index];
                    self.topConditionCollectionView.conditions = self.currentConditions;
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    [self.secondLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                    
                    [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    
                    return;
                }
            }
            
        }
        
        
        
        //如果没找到，则将此条件添加到self.currentConditions中去
        NSArray *secondElements = [self.secondLevelElements objectAtIndex:self.indexModel.index];
        FilterSelectIndexModel *secondModel = [FilterSelectIndexModel new];
        secondModel.filterName = [secondElements objectAtIndex:indexPath.row];
        secondModel.index = indexPath.row;
        secondModel.subIndex = nil;
        
        FilterSelectIndexModel *firstModel = [FilterSelectIndexModel new];
        firstModel.filterName = self.indexModel.filterName;
        firstModel.index = self.indexModel.index;
        firstModel.subIndex = secondModel;
        
        if (!self.multiSelectionEnable) {
            [self.currentConditions removeAllObjects];
        }
        
        [self.currentConditions addObject:firstModel];
        
        //将当前条件再赋值给头部当前条件collectionView中，刷新collectionView的显示
        self.topConditionCollectionView.conditions = self.currentConditions;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //然后刷新第二层tableView点击的这一行
        [self.secondLevelTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (self.multiSelectionEnable == NO) {//如果不支持多选，则直接返回
            [self.confirmBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        
        [self.firstLevelTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexModel.index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TabelViewCellHeight;
}

#pragma mark - Lazy

- (NSMutableArray *)currentConditions {
    if (!_currentConditions) {
        _currentConditions = [NSMutableArray new];
    }
    return _currentConditions;
}

@end
