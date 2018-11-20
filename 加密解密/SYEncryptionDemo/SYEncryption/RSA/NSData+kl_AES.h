//
//  NSData+AES.h
//  SecurityTest
//
//  Created by bcmac3 on 16/5/10.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (kl_AES)

/** 
 *  AES-将string转成带密码的data
 */
+ (NSData*)encryptAESData:(NSString*)string;
/** 
 *  AES-将带密码的data转成string 
 */
+ (NSString*)decryptAESData:(NSData*)data;

@end
