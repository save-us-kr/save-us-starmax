//
//  STlSportGoal.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/10.
//  🍎一天运动目标

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STlSportGoal : NSObject

/// 计步目标
@property (nonatomic,assign) NSInteger step;
/// 卡路里目标(单位大卡)
@property (nonatomic,assign) NSInteger calories;
/// 距离目标(单位 KM)
@property (nonatomic,assign) NSInteger distance;

@end

NS_ASSUME_NONNULL_END
