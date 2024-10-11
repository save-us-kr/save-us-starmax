//
//  STMath.h
//  RunmefitSDK
//
//  Created by 星迈 on 2022/8/2.
//  🍎字节数学

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STMath : NSObject

//MARK: 8位和byte
+ (Byte)bitsToByte:(unsigned char *)bit;
+ (NSData *)byteToBits:(Byte)byte;

//MARK: byte高低4位
+ (int)getHeight4:(Byte)byte;
+ (int)getLow4:(Byte)byte;

//MARK: float和byte数组
+ (NSData *)floatToByte:(float)value;
+ (float)ByteToFloat:(unsigned char *)b;

//MARK: short和byte数组
+ (NSData *)shortToBytes:(short)value;
+ (short)bytesToShort:(Byte*)pByte;

//MARK: int和byte数组
+ (NSData *)intToBytes:(int)value;
+ (int)bytesToInt:(Byte*)pByte;

//MARK: data和byte数组
+ (Byte *)dataToByte:(NSData *)data;
+ (NSData *)byteToData:(Byte *)pByte Len:(NSUInteger)len;

//MARK: crc码
+ (NSData *)getCrcData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
