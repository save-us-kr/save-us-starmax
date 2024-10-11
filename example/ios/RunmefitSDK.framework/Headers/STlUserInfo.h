//
//  STlUserInfo.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/10.
//  🍎用户信息

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STlUserInfo : NSObject

/// 性别(默认0：女，1：男)
@property (nonatomic,assign) NSInteger sex;
/// 年龄 (0x06~0x64,默认 20)
@property (nonatomic,assign) NSInteger age;
/// 身高（单位 cm，默认 170)
@property (nonatomic,assign) NSInteger height;
/// 体重(单位 0.1kg，默认 600)
@property (nonatomic,assign) NSInteger weight;

@end

NS_ASSUME_NONNULL_END
