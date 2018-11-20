//
//  SYAES.h
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYAES : NSObject
// 加密方法
+ (NSString *)encryptUseAES:(NSString *)message key:(NSString *)password;
// 解密方法
+ (NSString *)decryptUseAES:(NSString *)base64EncodedString key:(NSString *)password;
@end
