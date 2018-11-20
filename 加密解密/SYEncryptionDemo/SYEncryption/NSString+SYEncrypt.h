//
//  NSString+SYEncrypt.h
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (SYEncrypt)

- (NSString *)do16MD5;
- (NSString *)do32MD5;

- (NSString *)doSha1;

@end
NS_ASSUME_NONNULL_END
