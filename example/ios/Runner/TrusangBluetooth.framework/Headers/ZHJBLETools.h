//
//  ZHJBLETools.h
//  KeepHealth
//
//  Created by wangjun on 2019/4/20.
//  Copyright © 2019 zhihuiju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHJBLETools : NSObject
/**
 倒序mac地址
 */
+ (NSString *)invertedOrderMacWithData:(NSData *)data;

/**
 正序mac地址
 */
+ (NSString *)positiveSequenceMacWithData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
