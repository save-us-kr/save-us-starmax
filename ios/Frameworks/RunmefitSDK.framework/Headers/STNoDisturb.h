//
//  STNoDisturb.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  🍎勿扰

#import <Foundation/Foundation.h>
#import <RunmefitSDK/STIntervalTime.h>

NS_ASSUME_NONNULL_BEGIN

@interface STNoDisturb : NSObject

/// 是否定时勿扰
@property(nonatomic,assign) BOOL isOpen;
/// 是否全天勿扰
@property(nonatomic,assign) BOOL isAllDay;

/// 时间段
@property(nonatomic,strong) STIntervalTime *intervalTime;

@end

NS_ASSUME_NONNULL_END
