//
//  STBlueToothString.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/9/15.
//  🍎解析指令集

#ifndef STBlueToothString_h
#define STBlueToothString_h

///运动模式配置
static const NSString *ST_SportConfigKey_walk = @"ST_SportConfigKey_walk";/// 步行(室外)
static const NSString *ST_SportConfigKey_run = @"ST_SportConfigKey_run";/// 跑步(室外)
static const NSString *ST_SportConfigKey_ride = @"ST_SportConfigKey_ride";/// 骑行(室外)
static const NSString *ST_SportConfigKey_indoorRun = @"ST_SportConfigKey_indoorRun";/// 室内跑步
static const NSString *ST_SportConfigKey_freeTrain = @"ST_SportConfigKey_freeTrain";/// 自由训练
static const NSString *ST_SportConfigKey_football = @"ST_SportConfigKey_football";/// 足球
static const NSString *ST_SportConfigKey_basketball = @"ST_SportConfigKey_basketball";/// 篮球
static const NSString *ST_SportConfigKey_badminton = @"ST_SportConfigKey_badminton";/// 羽毛球
static const NSString *ST_SportConfigKey_ropeSkip = @"ST_SportConfigKey_ropeSkip";/// 跳绳
static const NSString *ST_SportConfigKey_climb = @"ST_SportConfigKey_climb";/// 登山
static const NSString *ST_SportConfigKey_happyBike = @"ST_SportConfigKey_happyBike";/// 动感单车
static const NSString *ST_SportConfigKey_yoga = @"ST_SportConfigKey_yoga";/// 瑜伽
static const NSString *ST_SportConfigKey_onFoot = @"ST_SportConfigKey_onFoot";/// 徒步
static const NSString *ST_SportConfigKey_fastWalking = @"ST_SportConfigKey_fastWalking";/// 健走
static const NSString *ST_SportConfigKey_ellipticalMachine = @"ST_SportConfigKey_ellipticalMachine";/// 椭圆机
static const NSString *ST_SportConfigKey_strengthTraining = @"ST_SportConfigKey_strengthTraining";/// 力量训练

///事件
static const NSString *ST_EvensKey = @"ST_EvensKey";///事件
static const NSString *ST_EvenYearKey = @"ST_EvenYearKey";///年
static const NSString *ST_EvenMonthKey = @"ST_EvenMonthKey";///月
static const NSString *ST_EvenDayKey = @"ST_EvenDayKey";///日
static const NSString *ST_EvenTypeKey = @"ST_EvenTypeKey";///提醒类型
static const NSString *ST_EvenCycleTypeKey = @"ST_EvenCycleTypeKey";///重复类型
static const NSString *ST_EvenCycleValueKey = @"ST_EvenCycleValueKey";///周重复
static const NSString *ST_EvenContentKey = @"ST_EvenContentKey";///内容

///提醒
static const NSString *ST_AlarmOpenKey = @"ST_AlarmOpenKey";///提醒开关
static const NSString *ST_AlarmIntervalKey = @"ST_AlarmIntervalKey";///提醒间隔(单位分钟)

///闹钟
static const NSString *ST_ClocksKey = @"ST_ClocksKey";///闹钟
static const NSString *ST_ClockOpenKey = @"ST_ClockOpenKey";///开关
static const NSString *ST_ClockTypeKey = @"ST_ClockTypeKey";///类型
static const NSString *ST_ClockHourKey = @"ST_ClockHourKey";///小时
static const NSString *ST_ClockMinsKey = @"ST_ClockMinsKey";///分钟
static const NSString *ST_ClockCycleKey = @"ST_ClockCycleKey";///周期(6-0)

///勿扰
static const NSString *ST_NoDisturbOpenKey = @"ST_NoDisturbOpenKey";///开关
static const NSString *ST_NoDisturbAllDayKey = @"ST_NoDisturbAllDayKey";///是否全天勿扰

///联系人
static const NSString *ST_ContactsKey = @"ST_ContactsKey";///联系人
static const NSString *ST_ContactSOSKey = @"ST_ContactSOSKey";///isSOS
static const NSString *ST_ContactNameKey = @"ST_ContactNameKey";///姓名
static const NSString *ST_ContactPhoneKey = @"ST_ContactPhoneKey";///电话

//心率检测间隔和范围
static const NSString *ST_StartHourKey = @"ST_StartHourKey";///开始小时
static const NSString *ST_StartMinsKey = @"ST_StartMinsKey";///开始分钟
static const NSString *ST_EndHourKey = @"ST_EndHourKey";///结束小时
static const NSString *ST_EndMinsKey = @"ST_EndMinsKey";///结束分钟
static const NSString *ST_IntervalKey = @"ST_IntervalKey";///检测周期(以分钟为单位)
static const NSString *ST_ThresholdKey = @"ST_ThresholdKey";///静态心率高报警阈值

//健康数据检测开关
static const NSString *ST_SwitchHRKey = @"ST_SwitchHRKey";///心率总开关：1开0关
static const NSString *ST_SwitchBPKey = @"ST_SwitchBPKey";///血压总开关：1开0关
static const NSString *ST_SwitchBOKey = @"ST_SwitchBOKey";///血氧总开关：1开0关
static const NSString *ST_SwitchPPKey = @"ST_SwitchPPKey";///压力总开关：1开0关
static const NSString *ST_SwitchTPKey = @"ST_SwitchTPKey";///温度总开关：1开0关
static const NSString *ST_SwitchBSKey = @"ST_SwitchBSKey";///血糖总开关：1开0关

//第三方通知
static const NSString *ST_NotiAllKey = @"ST_NotiAllKey";///总开关

static const NSString *ST_NotiIncominglKey = @"ST_NotiIncominglKey";///来电
static const NSString *ST_NotiSmsKey = @"ST_NotiSmsKey";///短信
static const NSString *ST_NotiEmailKey = @"ST_NotiEmailKey";///邮件
static const NSString *ST_NotiTwitterKey = @"ST_NotiTwitterKey";///Twitter
static const NSString *ST_NotiFacebookKey = @"ST_NotiFacebookKey";///Facebook
static const NSString *ST_NotiWhatsappKey = @"ST_NotiWhatsappKey";///WhatsApp
static const NSString *ST_NotiLineKey = @"ST_NotiLineKey";///Line
static const NSString *ST_NotiSkypeKey = @"ST_NotiSkypeKey";///Skype
static const NSString *ST_NotiQqKey = @"ST_NotiQqKey";///qq
static const NSString *ST_NotiWechatKey = @"ST_NotiWechatKey";///微信
static const NSString *ST_NotiInstagramKey = @"ST_NotiInstagramKey";///Instagram
static const NSString *ST_NotiLinkedinKey = @"ST_NotiLinkedinKey";///LinkedIn
static const NSString *ST_NotiMessagerKey = @"ST_NotiMessagerKey";///Messenger
static const NSString *ST_NotiVkKey = @"ST_NotiVkKey";///VK
static const NSString *ST_NotiViberKey = @"ST_NotiViberKey";///Viber
static const NSString *ST_NotiTelegramKey = @"ST_NotiTelegramKey";///Telegram
static const NSString *ST_NotiKakaoTalkKey = @"ST_NotiKakaoTalkKey";///KakaoTalk
static const NSString *ST_NotiOtherKey = @"ST_NotiOtherKey";///其他

//运动目标
static const NSString *ST_TargetStepKey = @"ST_TargetStepKey";///计步目标
static const NSString *ST_TargetCalorieKey = @"ST_TargetCalorieKey";///热量目标(千卡)
static const NSString *ST_TargetDistanceKey = @"ST_TargetDistanceKey";///距离目标(千米)

//用户信息
static const NSString *ST_UserGenderKey = @"ST_UserGenderKey";///性别 0：女，1：男
static const NSString *ST_UserAgeKey = @"ST_UserAgeKey";///年龄
static const NSString *ST_UserHeightKey = @"ST_UserHeightKey";///身高（单位1 CM）
static const NSString *ST_UserWeightKey = @"ST_UserWeightKey";///体重（单位0.1 KG）

//时间时区
static const NSString *ST_YearKey = @"ST_YearKey";
static const NSString *ST_MonthKey = @"ST_MonthKey";
static const NSString *ST_DayKey = @"ST_DayKey";
static const NSString *ST_HourKey = @"ST_HourKey";
static const NSString *ST_MinuteKey = @"ST_MinuteKey";
static const NSString *ST_SecondKey = @"ST_SecondKey";
static const NSString *ST_ZoneKey = @"ST_ZoneKey";

//绑定设备
static const NSString *ST_DeviceBindKey = @"ST_DeviceBindKey";

//查找设备
static const NSString *ST_FindDeviceKey = @"ST_FindDeviceKey";

//获取固件版本号
static const NSString *ST_GetVersionNumberKey = @"ST_GetVersionNumberKey";

//获取固件UI版本号
static const NSString *ST_GetUIVersionNumberKey = @"ST_GetUIVersionNumberKey";

//获取设备MTU
static const NSString *ST_GetDeviceMtuKey = @"ST_GetDeviceMtuKey";

//获取设备宽
static const NSString *ST_GetDeviceWidthKey = @"ST_GetDeviceWidthKey";

//获取设备高
static const NSString *ST_GetDeviceHeightKey = @"ST_GetDeviceHeightKey";

//获取设备形状(0：圆屏，1：方屏)
static const NSString *ST_GetDeviceShapeKey = @"ST_GetDeviceShapeKey";

//获取设备型号
static const NSString *ST_GetDeviceModelKey = @"ST_GetDeviceModelKey";

//是否需要强制升级UI
static const NSString *ST_ForcedUpgradeUIKey = @"ST_ForcedUpgradeUIKey";

//是否支持差分升级
static const NSString *ST_DifferentialUpgradeKey = @"ST_DifferentialUpgradeKey";

//是否支持血糖功能
static const NSString *ST_SupportBloodSugarKey = @"ST_SupportBloodSugarKey";

//获取电量百分比
static const NSString *ST_GetElectricityKey = @"ST_GetElectricityKey";

//获取充电状态(1:充电中)
static const NSString *ST_GetElectricityStateKey = @"ST_GetElectricityStateKey";

//拍照控制(1：进入拍照，2：退出拍照，3：点击拍照)
static const NSString *ST_PhotoGraphModeKey = @"ST_PhotoGraphModeKey";

#pragma mark - 设备状态

//时间格式设置(0：24小时制，1：12小时制)
static const NSString *ST_HourSystemKey = @"ST_HourSystemKey";

//单位制选择(0：公制，1：英制)
static const NSString *ST_UnitKey = @"ST_UnitKey";

//温度制选择(0：摄氏，1：华氏)
static const NSString *ST_TemperatureUnitKey = @"ST_TemperatureUnitKey";

//手表语言(0：英语1：中文)
static const NSString *ST_LanguageDataKey = @"ST_LanguageDataKey";

//背光时长(秒为单位)
static const NSString *ST_BrightDurationKey = @"ST_BrightDurationKey";

//屏幕亮度(百分比)
static const NSString *ST_BrightnessKey = @"ST_BrightnessKey";

//抬手亮开关
static const NSString *ST_TrunWristKey = @"ST_TrunWristKey";

#pragma mark - 获取实时数据开关
static const NSString *ST_GetRealTimeGsensorOnKey = @"ST_GetRealTimeGsensorOnKey";///gsensor
static const NSString *ST_GetRealTimeSdcOnKey = @"ST_GetRealTimeSdcOnKey";///计步、卡路里、距离
static const NSString *ST_GetRealTimeHrOnKey = @"ST_GetRealTimeHrOnKey";///心率
static const NSString *ST_GetRealTimeBpOnKey = @"ST_GetRealTimeBpOnKey";///血压
static const NSString *ST_GetRealTimeBqOnKey = @"ST_GetRealTimeBqOnKey";;///血氧
static const NSString *ST_GetRealTimeTpOnKey = @"ST_GetRealTimeTpOnKey";///温度
static const NSString *ST_GetRealTimeBsOnKey = @"ST_GetRealTimeBsOnKey";///血糖

#pragma mark - 获取当前

//Gsensor数据
static const NSString *ST_GetGsensorInfoKey = @"ST_GetGsensorInfoKey";

static const NSString *ST_GetCurrentValueX_GsensorKey = @"ST_GetCurrentValueX_GsensorKey";
static const NSString *ST_GetCurrentValueY_GsensorKey = @"ST_GetCurrentValueY_GsensorKey";
static const NSString *ST_GetCurrentValueZ_GsensorKey = @"ST_GetCurrentValueZ_GsensorKey";

//获取当前数据总计步
static const NSString *ST_GetCurrentValueStepKey = @"ST_GetCurrentValueStepKey";

//获取当前数据总卡路里(卡)
static const NSString *ST_GetCurrentValueCalorieKey = @"ST_GetCurrentValueCalorieKey";

//获取当前数据总距离(m)
static const NSString *ST_GetCurrentValueDistanceKey = @"ST_GetCurrentValueDistanceKey";

//获取当前数据总睡眠时间(分钟)
static const NSString *ST_GetCurrentValueSleepKey = @"ST_GetCurrentValueSleepKey";

//获取当前数据总深睡时间(分钟)
static const NSString *ST_GetCurrentValueDeepSleepKey = @"ST_GetCurrentValueDeepSleepKey";

//获取当前数据总浅睡时间(分钟)
static const NSString *ST_GetCurrentValueLightSleepKey = @"ST_GetCurrentValueLightSleepKey";

//获取当前数据心率
static const NSString *ST_GetCurrentValueHRKey = @"ST_GetCurrentValueHRKey";

//获取当前数据高压
static const NSString *ST_GetCurrentValueHeightBPKey = @"ST_GetCurrentValueHeightBPKey";

//获取当前数据低压
static const NSString *ST_GetCurrentValueLowBPKey = @"ST_GetCurrentValueLowBPKey";

//获取当前数据血氧
static const NSString *ST_GetCurrentValueBOKey = @"ST_GetCurrentValueBOKey";

//获取当前数据压力
static const NSString *ST_GetCurrentValueHPKey = @"ST_GetCurrentValueHPKey";

//获取当前数据梅脱
static const NSString *ST_GetCurrentValueMETKey = @"ST_GetCurrentValueMETKey";

//获取当前数据MAI
static const NSString *ST_GetCurrentValueMAIKey = @"ST_GetCurrentValueMAIKey";

//获取当前数据温度
static const NSString *ST_GetCurrentValueTemperatureKey = @"ST_GetCurrentValueTemperatureKey";

//当前血糖
static const NSString *ST_GetCurrentValueSugarKey = @"ST_GetCurrentValueSugarKey";

//是否佩戴
static const NSString *ST_GetCurrentStateWearKey = @"ST_GetCurrentStateWearKey";///-1:未知；0:未戴；1:已戴

#pragma mark - 获取历史

//获取数据有效日期列表
static const NSString *ST_GetRecordValidDateKey = @"ST_GetRecordValidDateKey";

//获取历史日期yyyyMMdd
static const NSString *ST_GetRecordDateTimeKey = @"ST_GetRecordDateTimeKey";

//获取历史采样间隔(mins)
static const NSString *ST_GetRecordIntervalKey = @"ST_GetRecordIntervalKey";

//获取历史数据
static const NSString *ST_GetRecordValueDataKey = @"ST_GetRecordValueDataKey";

//获取历史数据运动类型(1计步、2睡眠)
static const NSString *ST_GetRecordTypeStepOrSleepKey = @"ST_GetRecordTypeStepOrSleepKey";

//获取历史数据计步
static const NSString *ST_GetRecordValueStepKey = @"ST_GetRecordValueStepKey";

//获取历史数据卡路里(卡)
static const NSString *ST_GetRecordValueCalorieKey = @"ST_GetRecordValueCalorieKey";

//获取历史数据距离(m)
static const NSString *ST_GetRecordValueDistanceKey = @"ST_GetRecordValueDistanceKey";

//获取历史数据睡眠(1 开始入睡 2 浅睡 3 深睡 4 清醒)
static const NSString *ST_GetRecordValueSleepKey = @"ST_GetRecordValueSleepKey";

//同步运动数据
static const NSString *ST_GetSportRecordDurationKey = @"ST_GetSportRecordDurationKey";///运动时长（s）
static const NSString *ST_GetSportRecordTypeKey = @"ST_GetSportRecordTypeKey";///运动类型
static const NSString *ST_GetSportRecordStepKey = @"ST_GetSportRecordStepKey";///步数
static const NSString *ST_GetSportRecordDistanceKey = @"ST_GetSportRecordDistanceKey";///距离（m）
static const NSString *ST_GetSportRecordSpeedKey = @"ST_GetSportRecordSpeedKey";///速度（m/s）
static const NSString *ST_GetSportRecordCaloriesKey = @"ST_GetSportRecordCaloriesKey";///卡路里
static const NSString *ST_GetSportRecordPaceKey = @"ST_GetSportRecordPaceKey";///配速
static const NSString *ST_GetSportRecordStrideKey = @"ST_GetSportRecordStrideKey";///步频
static const NSString *ST_GetSportRecordHRLengthKey = @"ST_GetSportRecordHRLengthKey";///心率长度
static const NSString *ST_GetSportRecordHRDetailsKey = @"ST_GetSportRecordHRDetailsKey";///心率数据

#pragma mark - 获取表盘信息

//获取表盘信息列表
static const NSString *ST_GetDialInfoKey = @"ST_GetDialInfoKey";

//当前显示表盘
static const NSString *ST_GetDialUsedKey = @"ST_GetDialUsedKey";
//表盘Id
static const NSString *ST_GetDialIdKey = @"ST_GetDialIdKey";
//表盘颜色值
static const NSString *ST_GetDialRGBKey = @"ST_GetDialRGBKey";
//表盘位置
static const NSString *ST_GetDialModeKey = @"ST_GetDialModeKey";

#pragma mark - 获取语言信息

//获取语言信息列表
static const NSString *ST_GetLangInfoKey = @"ST_GetLangInfoKey";

//当前显示语言
static const NSString *ST_GetLangUsedKey = @"ST_GetLangUsedKey";
//语言Id
static const NSString *ST_GetLangIdKey = @"ST_GetLangIdKey";
//语言版本号
static const NSString *ST_GetLangVersionKey = @"ST_GetLangVersionKey";

#pragma mark - GTS7系列新增

//时间时钟
static const NSString *ST_WorldClockListKey = @"ST_WorldClockListKey";
//推送应用
static const NSString *ST_FunIdListKey = @"ST_FunIdListKey";
//脱腕密码
static const NSString *ST_WristCodeKey = @"ST_WristCodeKey";
//健康类型
static const NSString *ST_HealthMeasureIdKey = @"ST_HealthMeasureIdKey";
//健康数值
static const NSString *ST_HealthMeasureValueKey = @"ST_HealthMeasureValueKey";

#endif /* STBlueToothString_h */
