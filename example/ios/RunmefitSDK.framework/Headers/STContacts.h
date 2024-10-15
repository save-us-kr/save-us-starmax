//
//  STContacts.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/11.
//  🍎联系人

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STContacts : NSObject

/// 是否紧急联系人
@property(nonatomic,assign) BOOL isSOS;

/// 姓名
@property (nonatomic, copy) NSString * _Nonnull name;
/// 电话
@property (nonatomic, copy) NSString * _Nonnull phone;

@end

NS_ASSUME_NONNULL_END
