# YYFilterTool
* 筛选视图，条件筛选，多层筛选，一层筛选：类似美团外卖下拉分类筛选，三层筛选：类似地区筛选，下拉筛选视图，功能强大，使用方便。
---
# Installation
1、选择`Download ZIP` 下载YYFilterTool。  
2、将YYFilterTool整个文件夹拖入工程中。  
3、`import "YYStarTool.h"`。  
4、YYFilterTool使用`Masonry`布局，请先导入`Masonry`才可继续使用。

---
# Function
* 最多可支持3层筛选。  
* 支持单选和多选。  
* 多选时，可支持顶部条件框显示，角标显示。  
* 可自定义选择图片的样式。
* 工具对象是全局单例的，用到的时候只需拿到单例对象，然后赋值相应属性，调用弹出pop方法即可。

---
# How to use
### 1、单选 + 一层筛选

```objc
    YYFilterTool *filterTool = [YYFilterTool shareInstance];
    filterTool.firstLevelElements = @[@"智能排序",@"离我最近",@"好评优先",@"人气最高"];
//    filterTool.levelType = YYBaseFilterTypeSingleLevel;//默认是一层，所以可以不用写
//    filterTool.multiSelectionEnable = NO;//默认不支持多选，所以可以不写
    [filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:nil];
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/1.gif)

### 2、多选 + 一层筛选
```objc
    filterTool.multiSelectionEnable = YES;//多选
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/2.gif)

### 3、多选 + 一层筛选 + 顶部条件框
```objc
    //加一句
    filterTool.topConditionEnable = YES;//顶部条件框的显示
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/3.gif)

### 4、多选 + 三层筛选 + 顶部条件框
```objc
    YYFilterTool *filterTool = [YYFilterTool shareInstance];
    
    NSMutableArray *firstLevelElements = [NSMutableArray new];
    NSMutableArray *secondLevelElements = [NSMutableArray new];
    NSMutableArray *thirdLevelElements = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        [firstLevelElements addObject:[NSString stringWithFormat:@"市%i",i]];
        NSMutableArray *elements = [NSMutableArray new];
        NSMutableArray *elementss = [NSMutableArray new];
        for (int j = 0; j < 15; j++) {//random()%30+1
            [elements addObject:[NSString stringWithFormat:@"市%i县%i",i,j]];
            NSMutableArray *elementsss = [NSMutableArray new];
            for (int k = 0; k < 15; k++) {
                [elementsss addObject:[NSString stringWithFormat:@"市%i县%i镇%i",i,j,k]];
            }
            [elementss addObject:elementsss];
        }
        [secondLevelElements addObject:elements];
        [thirdLevelElements addObject:elementss];
    }
    filterTool.firstLevelElements = firstLevelElements;
    filterTool.secondLevelElements = secondLevelElements;
    filterTool.thirdLevelElement = thirdLevelElements;
    filterTool.levelType = YYBaseFilterTypeThreeLevel;//三层筛选
    filterTool.multiSelectionEnable = YES;//多选
    filterTool.topConditionEnable = YES;//顶部条件框的显示
    [filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:nil];
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/4.gif)

### 5、多选 + 三层筛选 + 顶部条件框 + 角标
```objc
    filterTool.indexCountShowEnable = YES;//角标显示
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/5.gif)

### 6、自定义图片
```objc
    filterTool.selectedBtnHighlightedName = @"1";//设置选中图片
    filterTool.selectedBtnNormalName = @"2";//设置没选中图片
```
* 效果

![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/6.gif)
![图片](https://github.com/WallaceYou/YYFilterTool/blob/master/ShowImage/7.gif)
