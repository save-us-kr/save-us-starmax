//
//  RunmefitSDK.h
//  RunmefitSDK
//
//  Created by 星迈 on 2021/11/19.
//

#import <Foundation/Foundation.h>

//! Project version number for RunmefitSDK.
FOUNDATION_EXPORT double RunmefitSDKVersionNumber;

//! Project version string for RunmefitSDK.
FOUNDATION_EXPORT const unsigned char RunmefitSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <RunmefitSDK/PublicHeader.h>


//MARK: 设备特征值
#define UUID_Service @"6E400001-B5A3-F393-E0A9-E50E24DCCA9D"
#define UUID_Write_Char @"6E400002-B5A3-F393-E0A9-E50E24DCCA9D"
#define UUID_Notify_Char @"6E400003-B5A3-F393-E0A9-E50E24DCCA9D"

//MARK: 解析完通知
#define Nof_Revice_Data_Key @"Nof_Revice_Data_Key"

static const NSString *ST_RevType_Key = @"ST_RevType_Key";///CMD
static const NSString *ST_ErrorType_Key = @"ST_ErrorType_Key";///ERROR

#import <RunmefitSDK/STNetManager.h>
#import <RunmefitSDK/STBlueToothData.h>
#import <RunmefitSDK/STBlueToothSender.h>

#import <RunmefitSDK/STMath.h>
#import <RunmefitSDK/STDeviceState.h>
#import <RunmefitSDK/STlUserInfo.h>
#import <RunmefitSDK/STlSportGoal.h>
#import <RunmefitSDK/STMessageNotice.h>
#import <RunmefitSDK/STHealthSwitch.h>
#import <RunmefitSDK/STIntervalTime.h>
#import <RunmefitSDK/STConfigMeasureHR.h>
#import <RunmefitSDK/STNoDisturb.h>
#import <RunmefitSDK/STAlarmInterval.h>
#import <RunmefitSDK/STAlarmClock.h>
#import <RunmefitSDK/STContacts.h>
#import <RunmefitSDK/STWeather.h>
#import <RunmefitSDK/STAlarmEvent.h>
#import <RunmefitSDK/STRealTimeSwitchs.h>
#import <RunmefitSDK/STSportConfig.h>

#import <RunmefitSDK/STBlueToothString.h>
