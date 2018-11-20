//
//  SYDES3.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYDES3.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation SYDES3

const Byte iv[] = {0,1,2,3,4,5,6,7};

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key {
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySize3DES,
                                          iv,
                                          [textData bytes],
                                          [textData length],
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    return ciphertext;
}

+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key {
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySize3DES,
                                          iv,
                                          [cipherdata bytes],
                                          [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

@end
