//
//  STBlueToothData.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/2.
//  🍎解析指令集

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

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

#import <RunmefitSDK/STBlueToothString.h>
#import <RunmefitSDK/STBlueToothSender.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum:NSUInteger {
    RES_Correct     =   0x00,           /* 命令正确 */
    RES_CmdError    =   0x01,           /* 命令码错误 */
    RES_CrcError    =   0x02,           /* 校验码错误 */
    RES_LenError    =   0x03,           /* 数据长度错误 */
    RES_Invalid     =   0x04,           /* 数据无效 */
    RES_Time_Out    =   0x05,           /* 数据超时 */
    
}ERROR_TYPE;


typedef enum : NSUInteger {
    REV_Device_Bind         =   0x81,     //绑定设备
    REV_Device_State        =   0x02,     //设备状态(获取)
    SET_Device_State        =   0x82,     //设备状态(设置)
    REV_Device_Lost         =   0x03,     //查找设备
    REV_Device_Camera       =   0x04,     //拍照控制
    REV_Device_Battery      =   0x86,     //获取电池电量
    REV_Device_Version      =   0x87,     //获取设备版本信息
    REV_Update_Time         =   0x08,     //时间时区(获取)
    SET_Update_Time         =   0x88,     //时间时区(设置)
    REV_User_Info           =   0x09,     //用户信息(获取)
    SET_User_Info           =   0x89,     //用户信息(设置)
    REV_Goal_Sport          =   0x0A,     //一天运动目标(获取)
    SET_Goal_Sport          =   0x8A,     //一天运动目标(设置)
    REV_Device_Pair         =   0x8B,     //蓝牙系统配对
    REV_State_Notification  =   0x0C,     //消息推送开关(获取)
    SET_State_Notification  =   0x8C,     //消息推送开关(设置)
    REV_Health_Current      =   0x8D,     //获取当前设备运动数据
    REV_Health_Switch       =   0x0E,     //健康数据检测开关(获取)
    SET_Health_Switch       =   0x8E,     //健康数据检测开关(设置)
    SET_Factory_Setting     =   0x8F,     //恢复出厂设置

    REV_Interval_HR         =   0x31,     //心率检测间隔(获取)
    SET_Interval_HR         =   0xB1,     //心率检测间隔(设置)
    REV_Contact_Common      =   0x32,     //常用联系人(获取)
    SET_Contact_Common      =   0xB2,     //常用联系人(设置)
    REV_Contact_SOS         =   0x33,     //紧急联系人(获取)
    SET_Contact_SOS         =   0xB3,     //紧急联系人(设置)
    REV_Remind_NoDisturb    =   0x34,     //勿扰(获取)
    SET_Remind_NoDisturb    =   0xB4,     //勿扰(设置)
    REV_Remind_AlarmClock   =   0x35,     //闹钟(获取)
    SET_Remind_AlarmClock   =   0xB5,     //闹钟(设置)
    REV_Remind_Sedentary    =   0x36,     //久坐提醒(获取)
    SET_Remind_Sedentary    =   0xB6,     //久坐提醒(设置)
    REV_Remind_DrinkWater   =   0x37,     //喝水提醒(获取)
    SET_Remind_DrinkWater   =   0xB7,     //喝水提醒(设置)
    SET_Info_Weather        =   0xB9,     //推送天气
    SET_New_Info_Weather    =   0xbd,     //推送天气(7天)
    REV_Alarm_Even          =   0x3B,     //事件提醒(获取)
    SET_Alarm_Even          =   0xBB,     //事件提醒(设置)
    REV_Sport_Config        =   0x3C,     //运动模式配置(获取)
    SET_Sport_Config        =   0xBC,     //运动模式配置(设置)

    REV_History_Sport       =   0xE1,     //同步运动
    REV_History_Step        =   0xE2,     //同步记步/睡眠
    REV_History_HR          =   0xE3,     //同步心率
    REV_History_BP          =   0xE4,     //同步血压
    REV_History_BQ          =   0xE5,     //同步血氧
    REV_History_Pressure    =   0xE6,     //同步压力
    REV_History_Met         =   0xE7,     //同步梅脱
    REV_History_Temp        =   0xE8,     //同步温度
    REV_History_ValidDate   =   0xE9,     //获取有效日期列表
    
    REV_Bin_File_Info       =   0xEA,     //发送文件信息
    REV_Bin_File            =   0xEB,     //文件传输
    
    REV_Dial_Info           =   0xEC,     //获取表盘信息
    SET_Dial_Current        =   0xED,     //切换当前显示表盘
    REV_History_Mai         =   0xEE,     //同步Mai
    
    SET_RealTime_Switch     =   0x70,     //实时数据开关(设置)
    REV_RealTime_Switch     =   0xF1,     //实时数据开关(获取)
    REV_RealTime_DATA       =   0x71,     //实时数据上发(获取)
    
    REV_History_Sugar       =   0xF2,     //同步血糖
    
    REV_Time_Era            =   0x13,     //单独时区(获取)
    SET_Time_Era            =   0x93,     //单独时区(设置)
    REV_World_Clock         =   0x3f,     //世界时钟(获取)
    SET_World_Clock         =   0xbf,     //世界时钟(设置)
    REV_Fun_List            =   0x3e,     //推送应用(获取)
    SET_Fun_List            =   0xbe,     //推送应用(设置)
    REV_Wrist_Code          =   0x40,     //脱腕密码(获取)
    SET_Wrist_Code          =   0xc0,     //脱腕密码(设置)
    REV_Women_Health        =   0x41,     //女性健康(获取)
    SET_Women_Health        =   0xc1,     //女性健康(设置)
    REV_Health_Measure      =   0xc2,     //获取健康测量
    
}REV_TYPE;


typedef enum:NSUInteger {
    RES_START      =   0x80,           /* 129  开始 */
    RES_DONE       =   0x81,           /* 132  4K完成 */
    RES_FINAL      =   0x82,           /* 133  全部完成 */
    RES_TIMEOUT    =   0x83,           /* 134  超时 */
}PROGRESS_TYPE;


typedef void(^ProgressBlock)(PROGRESS_TYPE type,float progress);

@interface STBlueToothData : NSObject

@property (nonatomic, copy) ProgressBlock progressBlock;

+ (instancetype)sharedInstance;

//监听蓝牙回调数据 블루투스 콜백 데이터 듣기
-(void)notifyRunmefit:(CBPeripheral *)peripheral
       WriteCharacter:(CBCharacteristic *)writeCharacter
       Characteristic:(CBCharacteristic *)characteristic
                Error:(NSError *)error
             Complete:(void(^)(NSError *error,REV_TYPE revType, ERROR_TYPE errorType,id responseObject))complete;

//写入bin文件数据 bin 파일 데이터 쓰기
- (void)writeBinFileInfo:(nonnull NSData *)info
                    Data:(nonnull NSData *)data
       BlockReadInterval:(NSUInteger)blockReadInterval
              Peripheral:(nonnull CBPeripheral *)peripheral
          Characteristic:(nonnull CBCharacteristic *)characteristic
                Progress:(ProgressBlock)progress;

//事件提醒(设置) 이벤트 알림 (설정)
- (void)writeAlarmEvens:(NSArray<STAlarmEvent *> *)modelArr
      BlockReadInterval:(NSUInteger)blockReadInterval
             Peripheral:(nonnull CBPeripheral*)peripheral
         Characteristic:(nonnull CBCharacteristic*)characteristic;

@end

NS_ASSUME_NONNULL_END
