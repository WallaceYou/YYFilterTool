//
//  TopConditionCollectionView.m
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "TopConditionCollectionView.h"
#import "TopConditionCell.h"

#import "FilterSelectIndexModel.h"


@interface TopConditionCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>



@end

@implementation TopConditionCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TopConditionCell class] forCellWithReuseIdentifier:@"TopConditionCell"];
    }
    return self;
}

- (void)setConditions:(NSArray *)conditions {
    _conditions = conditions;
    [self reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

/* section的上左下右边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 14, 0, 14);
}

/* 最小行间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

/* 最小列间距、因为已经算出每个cell的宽度。 cell的列间距不用指定也会自动适配的 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

/* 每格cell的 宽高 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterSelectIndexModel *model = [self.conditions objectAtIndex:indexPath.row];
    
    if (model.subIndex != nil) {
        while (1) {
            model = model.subIndex;
            if (model.subIndex == nil) {
                break;
            }
        }
    }
    
    NSString *conditionName = model.filterName;
    CGFloat itemWidth = [self widthWithFont:[UIFont systemFontOfSize:14] title:conditionName constrainedToHeight:1000];
    
    return CGSizeMake(itemWidth+8*4-1, 46);
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.conditions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopConditionCell" forIndexPath:indexPath];
    
    FilterSelectIndexModel *model = [self.conditions objectAtIndex:indexPath.row];
    
    if (model.subIndex != nil) {
        while (1) {
            model = model.subIndex;
            if (model.subIndex == nil) {
                break;
            }
        }
    }
    
    cell.conditionName = model.filterName;
    
    return cell;
}


#pragma mark - 私有方法

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font title:(NSString *)title constrainedToWidth:(CGFloat)width {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [title boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                   options:(NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
    return ceil(textSize.height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font title:(NSString *)title constrainedToHeight:(CGFloat)height {
    
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                   options:(NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
    
    return ceil(textSize.width);
}

@end
