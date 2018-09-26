//
//  ViewController.m
//  YYBaseFilter
//
//  Created by yuyou on 2018/9/7.
//  Copyright © 2018年 hengtiansoft. All rights reserved.
//

#import "ViewController.h"
#import "YYFilterTool.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) YYFilterTool *filterTool;//永远返回一个单例对象


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)sortbyBtnClick:(id)sender {
    
    self.filterTool.firstLevelElements = @[@"智能排序",@"离我最近",@"好评优先",@"人气最高"];
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
    self.filterTool.filterComplete = ^(NSArray *filters) {
        for (FilterSelectIndexModel *model in filters) {
            FilterSelectIndexModel *innermostModel = [YYFilterTool getInnermostIndexModelWith:model];
            NSLog(@"%@",innermostModel.filterName);
        }
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
    
}


- (IBAction)nearbyBtnClick:(id)sender {
    
    NSMutableArray *firstLevelElements = [NSMutableArray new];
    NSMutableArray *secondLevelElements = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        [firstLevelElements addObject:[NSString stringWithFormat:@"市%i",i]];
        NSMutableArray *elements = [NSMutableArray new];
        for (int j = 0; j < random()%30+1; j++) {
            [elements addObject:[NSString stringWithFormat:@"市%i县%i",i,j]];
        }
        [secondLevelElements addObject:elements];
    }
    
    self.filterTool.firstLevelElements = @[@"艾欧尼亚",@"德玛西亚",@"诺克萨斯",@"巨神峰",@"祖安",@"皮尔特沃夫",@"弗雷尔卓德",@"比尔吉沃特",@"暗影岛",@"恕瑞玛",@"班德尔城",@"虚空之地",@"符文大陆"];
    
    self.filterTool.secondLevelElements = @[
                                            @[@"暗黑元首",@"暗影之拳",@"惩戒之箭",@"刀锋意志",@"疾风剑豪",@"九尾妖狐",@"狂暴之心",@"盲僧",@"暮光之眼",@"齐天大圣",@"天启者",@"无极剑圣",@"戏命师",@"影流之主",@"众星之子",@"影流之镰",@"幻翎",@"逆羽"],
                                            @[@"暗夜猎手",@"德邦总管",@"德玛西亚皇子",@"德玛西亚之力",@"德玛西亚之翼",@"圣锤之毅",@"光辉女郎",@"龙血武姬",@"琴瑟仙女",@"正义巨像",@"圣枪游侠",@"无双剑姬"],
                                            @[@"暴怒骑士",@"不祥之刃",@"策士统领",@"刀锋之影",@"放逐之刃",@"诡术妖姬",@"魔蛇之拥",@"诺克萨斯之手",@"荣耀行刑官",@"首领之傲",@"亡灵战神",@"猩红收割者"],
                                            @[@"瓦罗兰之盾",@"皎月女神",@"曙光女神",@"战争之王",@"暮光星灵"],
                                            @[@"暴走萝莉",@"风暴之怒",@"机械先驱",@"炼金术士",@"生化魔人",@"祖安之怒",@"时间刺客",@"瘟疫之源",@"蒸汽机器人",@"祖安狂人"],
                                            @[@"爆破鬼才",@"大发明家",@"发条魔灵",@"皮城女警",@"皮城执法官",@"青钢影",@"探险家",@"未来守护者"],
                                            @[@"冰晶凤凰",@"冰霜女巫",@"弗雷尔卓德之心",@"寒冰射手",@"巨魔之王",@"狂战士",@"雷霆咆哮",@"凛冬之怒",@"蛮族之王",@"兽灵行者",@"雪人骑士",@"山隐之焰"],
                                            @[@"法外狂徒",@"海兽祭祀",@"海洋之灾",@"卡牌大师",@"赏金猎人",@"深海泰坦",@"血港鬼影"],
                                            @[@"复仇之矛",@"寡妇制造者",@"魂锁典狱长",@"铁铠冥魂",@"牧魂人",@"扭曲树精",@"死亡颂唱者",@"战争之影",@"蜘蛛女皇",],
                                            @[@"荒漠屠夫",@"披甲龙龟",@"沙漠皇帝",@"沙漠死神",@"殇之木乃伊",@"水晶先锋",@"岩雀",@"远古巫灵",@"战争女神"],
                                            @[@"机械公敌",@"麦林炮手",@"仙灵女巫",@"邪恶小法师",@"迅捷斥候",@"英勇投弹手"],
                                            @[@"深渊巨口",@"虚空遁地兽",@"虚空行者",@"虚空恐惧",@"虚空掠夺者",@"虚空先知",@"虚空之眼",@"虚空之女"],
                                            @[@"暗裔剑魔",@"傲之追猎者",@"潮汐海灵",@"翠神",@"堕落天使",@"恶魔小丑",@"复仇焰魂",@"河流之王",@"黑暗之女",@"唤潮鲛姬",@"荆棘之兴",@"酒桶",@"狂野女猎手",@"符文法师",@"迷失之牙",@"末日使者",@"牛头酋长",@"熔岩巨兽",@"审判天使",@"时光守护者",@"武器大师",@"星界游神",@"永恒梦魇",@"永猎双子",@"铸星龙王"]
                                            ];
    self.filterTool.levelType = YYBaseFilterTypeDoubleLevel;
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
    self.filterTool.filterComplete = ^(NSArray *filters) {
        for (FilterSelectIndexModel *model in filters) {
            FilterSelectIndexModel *innermostModel = [YYFilterTool getInnermostIndexModelWith:model];
            NSLog(@"%@",innermostModel.filterName);
        }
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
    
}

- (IBAction)areaBtnClick:(id)sender {
    NSMutableArray *firstLevelElements = [NSMutableArray new];
    NSMutableArray *secondLevelElements = [NSMutableArray new];
    NSMutableArray *thirdLevelElements = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
        [firstLevelElements addObject:[NSString stringWithFormat:@"市%i",i]];
        NSMutableArray *elements = [NSMutableArray new];
        NSMutableArray *elementss = [NSMutableArray new];
        for (int j = 0; j < random()%30+1; j++) {
            [elements addObject:[NSString stringWithFormat:@"市%i县%i",i,j]];
            NSMutableArray *elementsss = [NSMutableArray new];
            for (int k = 0; k < random()%30+1; k++) {
                [elementsss addObject:[NSString stringWithFormat:@"市%i县%i镇%i",i,j,k]];
            }
            [elementss addObject:elementsss];
        }
        [secondLevelElements addObject:elements];
        [thirdLevelElements addObject:elementss];
    }
    
    self.filterTool.firstLevelElements = firstLevelElements;
    self.filterTool.secondLevelElements = secondLevelElements;
    self.filterTool.thirdLevelElement = thirdLevelElements;
    self.filterTool.levelType = YYBaseFilterTypeThreeLevel;
    self.filterTool.multiSelectionEnable = YES;
    self.filterTool.topConditionEnable = YES;
    
//    __weak typeof(self) weakSelf = self;
    self.filterTool.filterComplete = ^(NSArray *filters) {
        for (FilterSelectIndexModel *model in filters) {
            FilterSelectIndexModel *innermostModel = [YYFilterTool getInnermostIndexModelWith:model];
            NSLog(@"%@",innermostModel.filterName);
        }
    };
    
    [self.filterTool popFilterViewWithStartY:150 startAnimateComplete:nil closeAnimateComplete:^{
        NSLog(@"关闭回调");
    }];
}

- (YYFilterTool *)filterTool {
    if (!_filterTool) {
        _filterTool = [YYFilterTool shareInstance];
    }
    return _filterTool;
}


@end
