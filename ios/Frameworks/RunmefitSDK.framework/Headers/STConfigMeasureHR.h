//
//  STConfigMeasureHR.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/10.
//  🍎心率检测间隔和范围

#import <Foundation/Foundation.h>
#import <RunmefitSDK/STIntervalTime.h>

NS_ASSUME_NONNULL_BEGIN

@interface STConfigMeasureHR : NSObject

/// 时间段
@property (nonatomic,strong) STIntervalTime *intervalTime;

/// 检测周期(以分钟为单位)
@property (nonatomic,assign) NSInteger interval;
/// 静态心率高报警阈值
@property (nonatomic,assign) NSInteger thresholdHR;

@end

NS_ASSUME_NONNULL_END
