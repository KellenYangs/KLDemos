//
//  SecurityUtil.h
//  SecurityTest
//
//  Created by bcmac3 on 16/5/10.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

#pragma mark - base64
/**	Base64-对string进行Base64加密 */
+ (NSString*)encodeBase64String:(NSString *)input;
/**	Base64-Base64加密的string进行解密 */
+ (NSString*)decodeBase64String:(NSString *)input;
/** Base64-将string转成带密码的data */
+ (NSString*)encodeBase64Data:(NSData *)data;
/** Base64-将带密码的data转成string */
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
/** AES-将string转成带密码的data */
+ (NSData*)encryptAESData:(NSString*)string;
/** AES-将带密码的data转成string */
+ (NSString*)decryptAESData:(NSData*)data;

#pragma mark - MD5加密
/**	对string进行md5加密 */
+ (NSString*)encryptMD5String:(NSString*)string;

@end
