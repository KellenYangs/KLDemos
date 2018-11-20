//
//  SYDES3.h
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDES3 : NSObject
// 加密方法
+ (NSString *)encryptUseDES:(NSString *)plainText  key:(NSString *)key;
// 解密方法
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
@end
