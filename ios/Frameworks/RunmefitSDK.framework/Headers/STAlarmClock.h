//
//  STAlarmClock.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  🍎闹钟

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /// 默认
    STAlarmClockTypeDefault = 0x00,
    /// 喝水
    STAlarmClockTypeDrink = 0x01,
    /// 吃药
    STAlarmClockTypeTakeMedicine = 0x02,
    /// 吃饭
    STAlarmClockTypeEat = 0x03,
    /// 运动
    STAlarmClockTypeSport = 0x04,
    /// 睡觉
    STAlarmClockTypeSleep = 0x05,
    /// 起床
    STAlarmClockTypeAwake = 0x06,
    /// 约会
    STAlarmClockTypeDate = 0x07,
    /// 聚会
    STAlarmClockTypeParty = 0x08,
    /// 会议
    STAlarmClockTypeMeeting = 0x09,
    
}STAlarmClockType;


NS_ASSUME_NONNULL_BEGIN

@interface STAlarmClock : NSObject

/// 闹钟开关
@property(nonatomic,assign) BOOL isOpen;
/// 小时
@property(nonatomic,assign) NSInteger hour;
/// 分钟
@property(nonatomic,assign) NSInteger minute;
/// 类型
@property(nonatomic,assign) STAlarmClockType type;

/// 周期(每天默认都是false+(6-0)+(每周日-每周六))
@property (nonatomic, copy) NSArray<NSNumber *> * _Nonnull cycle;

@end

NS_ASSUME_NONNULL_END
