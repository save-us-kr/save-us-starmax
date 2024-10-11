//
//  STIntervalTime.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  时间段

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STIntervalTime : NSObject

/// 开始小时
@property (nonatomic,assign) NSInteger startHour;
/// 开始分钟
@property (nonatomic,assign) NSInteger startMins;
/// 结束小时
@property (nonatomic,assign) NSInteger endHour;
/// 结束分钟
@property (nonatomic,assign) NSInteger endMins;

@end

NS_ASSUME_NONNULL_END
