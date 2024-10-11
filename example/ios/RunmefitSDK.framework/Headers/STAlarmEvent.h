//
//  STAlarmEvent.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/12/8.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /// 重要
    STEventTypeImportance = 1,
    /// 工作
    STEventTypeWork = 2,
    /// 生活
    STEventTypeLive = 3,
    /// 其他
    STEventTypeOther = 4,
    
}STAlarmEventType;


NS_ASSUME_NONNULL_BEGIN

@interface STAlarmEvent : NSObject

@property(nonatomic,assign) NSInteger year;
@property(nonatomic,assign) NSInteger month;
@property(nonatomic,assign) NSInteger day;
@property(nonatomic,assign) NSInteger hour;
@property(nonatomic,assign) NSInteger minute;

@property(nonatomic,assign) STAlarmEventType type;

@property(nonatomic,assign) NSInteger contentLen;
/// 提醒内容（Unicode编码，n最大254字节-127个字符）
@property (nonatomic, copy) NSString *content;
/// 重复类型（1、单次2：天3,：周4：月5：年）
@property(nonatomic,assign) NSInteger cycleType;
/// 周重复值（bit0周一）
@property (nonatomic, copy) NSArray<NSNumber *> *cycle;

@end

NS_ASSUME_NONNULL_END
