//
//  STNetManager.h
//  RunmefitSDK
//
//  Created by 星迈 on 2021/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**成功的block
 @param dataDict 返回的数据
 @param respCode 返回的请求码
 */
typedef void(^SucceedBlock)(NSDictionary *dataDict, NSInteger respCode);

/**失败的block
 @param error 错误信息
 */
typedef void(^Failed)(NSError *error);


@interface STNetManager : NSObject

#pragma mark - 单例初始化

+ (STNetManager *)shared;

#pragma mark - 操作

//表盘列表
- (void)getDialsListWithModel:(nullable NSString *)model
                      succeed:(SucceedBlock)succeed
                       failed:(Failed)failed;

//表盘分类列表
- (void)getCategoryDialsListWithModel:(nullable NSString *)model
                                 lang:(nullable NSString *)lang
                              succeed:(SucceedBlock)succeed
                               failed:(Failed)failed;

//字库列表
- (void)getLangListWithModel:(nullable NSString *)model
                        lang:(nullable NSString *)lang
                     succeed:(SucceedBlock)succeed
                      failed:(Failed)failed;

//字库版本信息
- (void)getLangInfoWithModel:(nullable NSString *)model
                     version:(nullable NSString *)version
                        lang:(nullable NSString *)lang
                     succeed:(SucceedBlock)succeed
                      failed:(Failed)failed;

//固件版本信息
- (void)getFirmwareInfoWithModel:(nullable NSString *)model
                         version:(nullable NSString *)version
                         factory:(BOOL)factory
                         succeed:(SucceedBlock)succeed
                          failed:(Failed)failed;

//UI版本信息
- (void)getUisInfoWithModel:(nullable NSString *)model
                    version:(nullable NSString *)version
                    factory:(BOOL)factory
                    succeed:(SucceedBlock)succeed
                     failed:(Failed)failed;

//下载文件
- (void)requestDownloadWithUrlstring:(NSString *)urlStr
                            progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                         destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                   completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
