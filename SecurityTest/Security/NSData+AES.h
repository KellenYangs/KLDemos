//
//  NSData+AES.h
//  SecurityTest
//
//  Created by bcmac3 on 16/5/10.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSData (AES)

/** AES加密 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;
/** AES解密 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
