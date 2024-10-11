//
//  STAlarmInterval.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  🍎久坐/喝水提醒

#import <Foundation/Foundation.h>
#import <RunmefitSDK/STIntervalTime.h>

NS_ASSUME_NONNULL_BEGIN

@interface STAlarmInterval : NSObject

/// 开关
@property(nonatomic,assign) BOOL isOpen;

/// 时间段
@property(nonatomic,strong) STIntervalTime *intervalTime;

/// 提醒间隔(单位分钟)
@property(nonatomic,assign) NSInteger interval;

@end

NS_ASSUME_NONNULL_END
