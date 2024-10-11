//
//  STWeather.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  🍎天气详情

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STWeather : NSObject

/// 温度
@property (nonatomic, copy) NSString * _Nonnull temp;
/// 最低温度
@property (nonatomic, copy) NSString * _Nonnull tempMin;
/// 最高温度
@property (nonatomic, copy) NSString * _Nonnull tempMax;
/// 天气状态代号
/**
 1、小雨，2、中雨，3、大雨，4、阴天，5、多云，6、晴，7、雾霾，8、台风，9、雷雨，10、冰雹
 11、小雪，12、中雪，13、大雪，14、雨夹雪15、沙尘暴，16、学加冰雹，17、狂风，18、大风，19、小风，20、龙卷风，21、热带风暴，22，雷暴，23，猛烈雷暴，24、未知
 */
@property (nonatomic, copy) NSString * _Nonnull conditionCode;
/// 单位,0摄氏，1华氏
@property (nonatomic, assign) BOOL unit;

/// 风速
@property (nonatomic, copy) NSString *windSpeed;
/// 湿度（相对湿度，百分比数值）
@property (nonatomic, copy) NSString *humidity;
/// 能见度，默认单位：公里
@property (nonatomic, copy) NSString *vis;
/// 紫外线强度
@property (nonatomic, copy) NSString *uvIndex;
///空气质量（1优，2良，3差）
@property (nonatomic, copy) NSString *AQI;

///日出时分(15:21)
@property (nonatomic, copy) NSString *sunrise;
///日落时分(04:20)
@property (nonatomic, copy) NSString *sunset;
///月出时分(15:21)
@property (nonatomic, copy) NSString *moonrise;
///月落时分(04:20)
@property (nonatomic, copy) NSString *moonset;

@end

NS_ASSUME_NONNULL_END
