//
//  STRealTimeSwitchs.h
//  RunmefitSDK
//
//  Created by 星迈 on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STRealTimeSwitchs : NSObject

@property(nonatomic,assign) BOOL gsensor;///gsensor实时数据
@property(nonatomic,assign) BOOL sdc;///计步、卡路里、距离实时数据
@property(nonatomic,assign) BOOL hr;///心率实时数据
@property(nonatomic,assign) BOOL bp;///血压实时数据
@property(nonatomic,assign) BOOL bq;///血氧实时数据
@property(nonatomic,assign) BOOL tp;///温度实时数据
@property(nonatomic,assign) BOOL bs;///血糖实时数据

@end

NS_ASSUME_NONNULL_END
