//
//  SYAES.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYAES.h"
#import "NSData+CommonCrypto.h"
#import "GTMBase64.h"

@implementation SYAES

+ (NSString *)encryptUseAES:(NSString *)message key:(NSString *)password {
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *base64EncodedString = [GTMBase64 stringByEncodingData:encryptedData];
//    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)decryptUseAES:(NSString *)base64EncodedString key:(NSString *)password {
    NSData *encryptedData = [GTMBase64 decodeString:base64EncodedString];
//    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

@end
