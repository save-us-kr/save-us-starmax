//
//  STMessageNotice.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/10.
//  🍎第三方通知开关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STMessageNotice : NSObject

@property (nonatomic,assign) BOOL isAll;

@property (nonatomic,assign) BOOL isIncoming;
@property (nonatomic,assign) BOOL isSms;
@property (nonatomic,assign) BOOL isEmail;
@property (nonatomic,assign) BOOL isTwitter;
@property (nonatomic,assign) BOOL isFacebook;
@property (nonatomic,assign) BOOL isWhatsapp;
@property (nonatomic,assign) BOOL isLine;
@property (nonatomic,assign) BOOL isSkype;
@property (nonatomic,assign) BOOL isQq;
@property (nonatomic,assign) BOOL isWechat;
@property (nonatomic,assign) BOOL isInstagram;
@property (nonatomic,assign) BOOL isLinkedin;
@property (nonatomic,assign) BOOL isMessager;
@property (nonatomic,assign) BOOL isVk;
@property (nonatomic,assign) BOOL isViber;
@property (nonatomic,assign) BOOL isTelegram;
@property (nonatomic,assign) BOOL isKakaoTalk;
@property (nonatomic,assign) BOOL isOther;

@end

NS_ASSUME_NONNULL_END
