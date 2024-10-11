//
//  STBlueToothSender.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/2.
//  🍎发送指令集

#import <Foundation/Foundation.h>

#import <RunmefitSDK/STMath.h>
#import <RunmefitSDK/STDeviceState.h>
#import <RunmefitSDK/STlUserInfo.h>
#import <RunmefitSDK/STlSportGoal.h>
#import <RunmefitSDK/STMessageNotice.h>
#import <RunmefitSDK/STHealthSwitch.h>
//#import <RunmefitSDK/STIntervalTime.h>
#import <RunmefitSDK/STConfigMeasureHR.h>
#import <RunmefitSDK/STNoDisturb.h>
#import <RunmefitSDK/STAlarmInterval.h>
#import <RunmefitSDK/STAlarmClock.h>
#import <RunmefitSDK/STContacts.h>
#import <RunmefitSDK/STWeather.h>
#import <RunmefitSDK/STAlarmEvent.h>
#import <RunmefitSDK/STRealTimeSwitchs.h>
#import <RunmefitSDK/STSportConfig.h>

//#import <RunmefitSDK/STBlueToothString.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 进入拍照
    STlPhotoContrlStart = 0x01,
    /// 退出拍照
    STlPhotoContrlEnd = 0x02,
    /// 点击拍照
    STlPhotoContrlTakePhoto = 0x03,
    
}STlPhotoContrl;


typedef enum : NSUInteger {
    ST_History_Sport       =   0x61,     //同步运动
    ST_History_Step        =   0x62,     //同步记步/睡眠
    ST_History_HR          =   0x63,     //同步心率
    ST_History_BP          =   0x64,     //同步血压
    ST_History_BQ          =   0x65,     //同步血氧
    ST_History_Pressure    =   0x66,     //同步压力
    ST_History_Met         =   0x67,     //同步梅脱
    ST_History_Temp        =   0x68,     //同步温度
    ST_History_Mai         =   0x6E,     //同步Mai
    ST_History_Sugar       =   0xF2

}STHistoryCmd;


typedef enum : NSUInteger {
    ST_WorldClock_Beijing       =  1, //北京(GMT+8)
    ST_WorldClock_Washington    =  2, //华盛顿(GMT-5)
    ST_WorldClock_London        =  3, //伦敦(GMT+0)
    ST_WorldClock_Paris         =  4, //巴黎(GMT+1)
    ST_WorldClock_NewYork       =  5, //纽约(GMT-5)
    ST_WorldClock_Tokyo         =  6, //东京(GMT+9)
    ST_WorldClock_Shanghai      =  7, //上海(GMT+8)
    ST_WorldClock_Mumbai        =  8, //孟买(GMT+5:30)
    ST_WorldClock_Sydney        =  9, //悉尼(GMT+11)
    
    ST_WorldClock_LosAngeles    =  10, //洛杉矶(GMT-8)
    ST_WorldClock_Moscow        =  11, //莫斯科(GMT+3)
    ST_WorldClock_Berlin        =  12, //柏林(GMT+1)
    ST_WorldClock_Rome          =  13, //罗马(GMT+1)
    ST_WorldClock_Istanbul      =  14, //伊斯坦布尔(GMT+3)
    ST_WorldClock_Cairo         =  15, //开罗(GMT+2)
    ST_WorldClock_Nanjing       =  16, //南京(GMT+8)
    ST_WorldClock_Vancouver     =  17, //温哥华(GMT-8)
    ST_WorldClock_Chicago       =  18, //芝加哥(GMT-6)
    ST_WorldClock_RioDeJaneiro  =  19, //里约热内卢(GMT-3)
    ST_WorldClock_Amsterdam     =  20, //阿姆斯特丹(GMT+1)
    ST_WorldClock_Singapore     =  21, //新加坡(GMT+8)
    ST_WorldClock_Seoul         =  22, //首尔(GMT+9)
    ST_WorldClock_Melbourne     =  23, //墨尔本(GMT+11)
    ST_WorldClock_NewDelhi      =  24, //新德里(GMT+5:30)
    ST_WorldClock_Canberra      =  25, //堪培拉(GMT+11)
    ST_WorldClock_Brasilia      =  26, //巴西利亚(GMT-3)
    ST_WorldClock_MexicoCity    =  27, //墨西哥城(GMT-6)
    ST_WorldClock_HongKong      =  28, //香港(GMT+8)
    ST_WorldClock_Stockholm     =  29, //斯德哥尔摩(GMT+1)
    ST_WorldClock_Barcelona     =  30, //巴塞罗那(GMT+1)
    ST_WorldClock_Munich        =  31, //慕尼黑(GMT+1)

}STWorldClockCmd;


NS_ASSUME_NONNULL_BEGIN

@interface STBlueToothSender : NSObject

#pragma mark - 简单设置类

//绑定设备
+ (NSData *)writeDeviceBind;

//设备状态
+ (NSData *)readDeviceState;
+ (NSData *)writeDeviceState:(STDeviceState *)model;

//查找设备
+ (NSData *)writeFindDevice;

//停止查找设备
+ (NSData *)writeEndFindDevice;

//拍照控制
+ (NSData *)writePhotoContrl:(STlPhotoContrl)contrl;

//获取电池电量
+ (NSData *)readDeviceBattery;

//获取设备版本信息
+ (NSData *)readDeviceVersion;

//时间时区
+ (NSData *)readDeviceDateTime;
+ (NSData *)writeDeviceDateTime;

//用户信息
+ (NSData *)readUserInfo;
+ (NSData *)writeUserInfo:(STlUserInfo *)model;

//一天运动目标
+ (NSData *)readSportGoal;
+ (NSData *)writeSportGoal:(STlSportGoal *)model;

//蓝牙系统配对
+ (NSData *)writeDevicePair;

//消息推送开关
+ (NSData *)readMessageNotice;
+ (NSData *)writeMessageNotice:(STMessageNotice *)model;

//获取当前设备展示数据
+ (NSData *)readCurrentHealth;

//健康数据检测开关
+ (NSData *)readHealthSwitch;
+ (NSData *)writeHealthSwitch:(STHealthSwitch *)model;

//恢复出厂设置
+ (NSData *)writeFactorySetting;

#pragma mark - 复杂设置类

//心率检测间隔和范围
+ (NSData *)readConfigMeasureHR;
+ (NSData *)writeConfigMeasureHR:(STConfigMeasureHR *)model;

//常用联系人
+ (NSData *)readCommonContacts;
+ (NSData *)writeCommonContacts:(NSArray<STContacts *> *)modelArr;

//紧急联系人
+ (NSData *)readSosContacts;
+ (NSData *)writeSosContacts:(NSArray<STContacts *> *)modelArr;

//勿扰
+ (NSData *)readNoDisturb;
+ (NSData *)writeNoDisturb:(STNoDisturb *)model;

//闹钟
+ (NSData *)readAlarmClocks;
+ (NSData *)writeAlarmClocks:(NSArray<STAlarmClock *> *)modelArr;

//久坐提醒
+ (NSData *)readSedentaryAlarmInterval;
+ (NSData *)writeSedentaryAlarmInterval:(STAlarmInterval *)model;

//喝水提醒
+ (NSData *)readDrinkWaterAlarmInterval;
+ (NSData *)writeDrinkWaterAlarmInterval:(STAlarmInterval *)model;

//推送天气
+ (NSData *)writeWeather:(NSArray<STWeather *> *)modelArr;

//事件提醒
+ (NSData *)readAlarmEvens;
//+ (NSArray<NSData *> *)writeAlarmEvens:(NSArray<STAlarmEvent *> *)modelArr DeviceMtu:(NSUInteger)deviceMtu;

//运动模式配置
+ (NSData *)readSportConfig;
+ (NSData *)writeSportConfig:(STSportConfig *)sportConfig;

#pragma mark - 数据同步类

//同步运动数据(是否重发  1：重发，0：不重发)
+ (NSData *)readSportModeHistory:(BOOL)resend;

//同步计步/卡路里/距离/睡眠数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readStepAndSleepHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步心率数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readHeartRateHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步血压数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readBloodPressureHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步血氧数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readBloodOxygenHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步压力数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readPhysicalPressureHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步梅脱数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readMetsHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步温度数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readTemperatureHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步Mai数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readMaiHistoryWithDate:(NSString * _Nonnull)dateStr;

//同步血糖数据
///
/// 获取某一天的历史记录数据
/// \param dateStr 日期yyyyMMdd
///
+ (NSData *)readSugarHistoryWithDate:(NSString * _Nonnull)dateStr;

//获取数据有效日期列表(对应数据类型)
+ (NSData *)readHistoryValidDate:(STHistoryCmd)cmd;

#pragma mark - 表盘设置类

//获取表盘信息
+ (NSData *)readDeviceDialInfo;

//切换当前显示表盘
+ (NSData *)writeCurrentDeviceDial:(int)Id;

#pragma mark - UIImage转RGB565
+ (NSData *)getRGB656DataWith:(UIImage*)image;

//RGB888转RGB565数组
+ (NSData *)getRGB656DataWithR:(unsigned char)r G:(unsigned char)g B:(unsigned char)b;

#pragma mark - 实时上报
//实时数据开关(获取)
+ (NSData *)readRealTimeSwitchs;

//实时数据开关(设置)
+ (NSData *)writeRealTimeSwitchs:(STRealTimeSwitchs *)model;

//自定义推送消息(设置)
+ (NSData *)writePushMessageTitle:(NSString *)title Message:(NSString *)message;

#pragma mark - GTS7以上系列
//单独时区0x13(获取)
+ (NSData *)readDeviceEra;
//单独时区0x13(设置)
+ (NSData *)writeDeviceEra;


//世界时钟0x3f(获取)
+ (NSData *)readDeviceWorldClock;
//世界时钟0x3f(设置)
/// \param worldClockArr 对应城市ID数组：STWorldClockCmd
+ (NSData *)writeDeviceWorldClock:(NSArray *)worldClockArr;


//推送应用0x3e(获取)
+ (NSData *)readDeviceFunId;
//推送应用0x3e(设置)
/// \param funIdArr 对应应用ID数组：
/**
 1、呼吸训练  2、梅脱  3、语音助手
 4、计时器  5、秒表  6、计算器
 7、闹钟  8、手电筒 9、查找手机
 10、世界时钟  11、番茄钟
 12、女性健康
 */
+ (NSData *)writeDeviceFunId:(NSArray *)funIdArr;


//脱腕密码0x40(获取)
+ (NSData *)readDeviceWristCode;
//脱腕密码0x40(设置)
/// \param codeString 数字密码字符串
/// \param on 锁定开关
+ (NSData *)writeDeviceWristCode:(NSString *)codeString On:(BOOL)on;


//女性健康0x41(获取)
+ (NSData *)readDeviceWomenHealth;
//女性健康0x41(设置)
/// \param days 月经天数：如6天
/// \param cycle 月经周期：如30天
/// \param lastDateStr 上次经期日期：yyyyMMdd
+ (NSData *)writeDeviceWomenHealth:(int)days Cycle:(int)cycle LastDate:(NSString *)lastDateStr;


//推送天气(7天)0x3d
+ (NSData *)writeWeatherCity:(NSString *)city ModelArr:(NSArray<STWeather *> *)modelArr;


//健康测量0x42(设置)
+ (NSData *)writeDeviceHealthMeasure:(Byte)Id On:(BOOL)on;

@end

NS_ASSUME_NONNULL_END
