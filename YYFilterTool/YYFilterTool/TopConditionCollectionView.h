//
//  TopConditionCollectionView.h
//  MyCoinRisk
//
//  Created by yuyou on 2018/7/30.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterSelectIndexModel;

@interface TopConditionCollectionView : UICollectionView

@property (nonatomic, strong) NSArray<FilterSelectIndexModel *> *conditions;

@end
