//
//  STHealthSwitch.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/10.
//  🍎健康数据检测开关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STHealthSwitch : NSObject

/// 心率总开关：1开0关
@property (nonatomic,assign) BOOL isHR;
/// 血压总开关：1开0关
@property (nonatomic,assign) BOOL isBP;
/// 血氧总开关：1开0关
@property (nonatomic,assign) BOOL isBO;
/// 压力总开关：1开0关
@property (nonatomic,assign) BOOL isPP;
/// 温度总开关：1开0关
@property (nonatomic,assign) BOOL isTP;
/// 血糖总开关：1开0关
@property (nonatomic,assign) BOOL isBS;

@end

NS_ASSUME_NONNULL_END
