//
//  STSportConfig.h
//  RunmefitSDK
//
//  Created by 星迈 on 2023/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STSportConfig : NSObject

/// 步行(室外)
@property (nonatomic,assign) BOOL walk;
/// 跑步(室外)
@property (nonatomic,assign) BOOL run;
///// 游泳
//@property (nonatomic,assign) BOOL swim;
/// 骑行(室外)
@property (nonatomic,assign) BOOL ride;
/// 室内跑步
@property (nonatomic,assign) BOOL indoorRun;
/// 自由训练
@property (nonatomic,assign) BOOL freeTrain;
/// 足球
@property (nonatomic,assign) BOOL football;
/// 篮球
@property (nonatomic,assign) BOOL basketball;
/// 羽毛球
@property (nonatomic,assign) BOOL badminton;
/// 跳绳
@property (nonatomic,assign) BOOL ropeSkip;
///// 俯卧撑
//@property (nonatomic,assign) BOOL pushUps;
///// 仰卧起坐
//@property (nonatomic,assign) BOOL sitUps;
/// 登山
@property (nonatomic,assign) BOOL climb;
///// 网球
//@property (nonatomic,assign) BOOL tennis;
///// 高强度训练
//@property (nonatomic,assign) BOOL HIT;
///// 室内骑行
//@property (nonatomic,assign) BOOL indoorBike;
///// 健身
//@property (nonatomic,assign) BOOL fitness;
///// 橄榄球
//@property (nonatomic,assign) BOOL rugby;
///// 高尔夫球
//@property (nonatomic,assign) BOOL golf;
/// 动感单车
@property (nonatomic,assign) BOOL happyBike;
///// 举重
//@property (nonatomic,assign) BOOL weightlift;
///// 轮滑
//@property (nonatomic,assign) BOOL rollerSkate;
///// 跳舞
//@property (nonatomic,assign) BOOL dance;
/// 瑜伽
@property (nonatomic,assign) BOOL yoga;
///// 室内步行
//@property (nonatomic,assign) BOOL indoorWalk;
/// 徒步
@property (nonatomic,assign) BOOL onFoot;
///// 棒球
//@property (nonatomic,assign) BOOL baseball;
///// 滑板
//@property (nonatomic,assign) BOOL skateboard;
///// 冰球
//@property (nonatomic,assign) BOOL iceHockey;
///// 滑雪
//@property (nonatomic,assign) BOOL skiing;
///// 赛车
//@property (nonatomic,assign) BOOL racingCar;
/// 健走
@property (nonatomic,assign) BOOL fastWalking;
/// 椭圆机
@property (nonatomic,assign) BOOL ellipticalMachine;
/// 力量训练
@property (nonatomic,assign) BOOL strengthTraining;
///// 划船机
//@property (nonatomic,assign) BOOL rowingMachine;
///// 平板支撑
//@property (nonatomic,assign) BOOL plankExercise;
///// 开合跳
//@property (nonatomic,assign) BOOL jumpingMovement;
///// 波比跳
//@property (nonatomic,assign) BOOL bobbyJump;
///// 深蹲
//@property (nonatomic,assign) BOOL squatMovement;
///// 高抬腿运动
//@property (nonatomic,assign) BOOL highLegLiftExercise;
///// 臂力训练
//@property (nonatomic,assign) BOOL armStrengthTraining;
///// 腿部训练
//@property (nonatomic,assign) BOOL legTraining;
///// 踏步机
//@property (nonatomic,assign) BOOL stepper;
///// 漫步器
//@property (nonatomic,assign) BOOL walker;
///// 健身操
//@property (nonatomic,assign) BOOL aerobics;
///// 团体操
//@property (nonatomic,assign) BOOL groupGymnastics;
///// 普拉提
//@property (nonatomic,assign) BOOL pilates;
///// Cross fit
//@property (nonatomic,assign) BOOL crossFit;
///// 功能性训练
//@property (nonatomic,assign) BOOL functionalTraining;
///// 体能训练
//@property (nonatomic,assign) BOOL physicaTraining;
///// 跆拳道
//@property (nonatomic,assign) BOOL taekwondo;
///// 拳击
//@property (nonatomic,assign) BOOL boxing;
///// 自由搏击
//@property (nonatomic,assign) BOOL freeSparring;
///// 空手道
//@property (nonatomic,assign) BOOL karate;
///// 击剑
//@property (nonatomic,assign) BOOL fencing;
///// 核心训练
//@property (nonatomic,assign) BOOL coreTraining;
///// 搏击操
//@property (nonatomic,assign) BOOL fightTraining;
///// 剑道
//@property (nonatomic,assign) BOOL kendo;
///// 单杠
//@property (nonatomic,assign) BOOL horizontalBar;
///// 双杠
//@property (nonatomic,assign) BOOL parallelBars;
///// 肚皮舞
//@property (nonatomic,assign) BOOL bellyDance;
///// 爵士舞
//@property (nonatomic,assign) BOOL jazz;
///// 拉丁舞
//@property (nonatomic,assign) BOOL latinDance;
///// 芭蕾
//@property (nonatomic,assign) BOOL ballet;
///// 街舞
//@property (nonatomic,assign) BOOL streetDance;
///// 广场舞
//@property (nonatomic,assign) BOOL squareDance;
///// 武术
//@property (nonatomic,assign) BOOL martialArts;
///// 太极拳
//@property (nonatomic,assign) BOOL taiChi;
///// 呼啦圈
//@property (nonatomic,assign) BOOL hulaHoop;
///// 飞盘
//@property (nonatomic,assign) BOOL frisbee;
///// 飞镖
//@property (nonatomic,assign) BOOL darts;
///// 射箭
//@property (nonatomic,assign) BOOL archery;
///// 骑马
//@property (nonatomic,assign) BOOL horseRiding;
///// 对战游戏
//@property (nonatomic,assign) BOOL battleGame;
///// 放风筝
//@property (nonatomic,assign) BOOL flyKite;
///// 拔河
//@property (nonatomic,assign) BOOL tugOfWar;
///// 秋千
//@property (nonatomic,assign) BOOL swing;
///// 爬楼
//@property (nonatomic,assign) BOOL climbStairs;
///// 障碍赛
//@property (nonatomic,assign) BOOL obstacleCourse;
///// 钓鱼
//@property (nonatomic,assign) BOOL fishing;
///// 乒乓球
//@property (nonatomic,assign) BOOL pingpong;
///// 台球
//@property (nonatomic,assign) BOOL billiards;
///// 保龄球
//@property (nonatomic,assign) BOOL bowling;
///// 排球
//@property (nonatomic,assign) BOOL volleyball;
///// 毽球
//@property (nonatomic,assign) BOOL shuttlecock;
///// 手球
//@property (nonatomic,assign) BOOL handball;
///// 垒球
//@property (nonatomic,assign) BOOL softball;
///// 板球
//@property (nonatomic,assign) BOOL cricketBall;
///// 沙滩足球
//@property (nonatomic,assign) BOOL beachFootball;
///// 门球
//@property (nonatomic,assign) BOOL croquet;
///// 曲棍球
//@property (nonatomic,assign) BOOL hockey;
///// 壁球
//@property (nonatomic,assign) BOOL squash;
///// 藤球
//@property (nonatomic,assign) BOOL sepakTakraw;
///// 躲避球
//@property (nonatomic,assign) BOOL dodgeBall;
///// 滑冰
//@property (nonatomic,assign) BOOL skate;
///// 冰壶
//@property (nonatomic,assign) BOOL curling;
///// 雪车
//@property (nonatomic,assign) BOOL snowCar;
///// 雪橇
//@property (nonatomic,assign) BOOL sled;
///// 冬季两项
//@property (nonatomic,assign) BOOL biathlon;
///// 攀岩
//@property (nonatomic,assign) BOOL rockClimbing;
///// 蹦极
//@property (nonatomic,assign) BOOL bungeeJumping;
///// 跑酷
//@property (nonatomic,assign) BOOL parkour;
///// BMX
//@property (nonatomic,assign) BOOL BMX;
///// 定向越野
//@property (nonatomic,assign) BOOL orienteering;
///// 跳伞
//@property (nonatomic,assign) BOOL parachute;

@end

NS_ASSUME_NONNULL_END
