//
//  NSObject+kl_Archiver.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (kl_Archiver)

/**
 *  通过自定的名字归档
 *
 *  @param name 名字
 *
 *  @return 是否成功
 */
- (BOOL)kl_archiveToName:(NSString *)name;

/**
 *  通过之前归档的名字解归档
 *
 *  @param name 名字
 *
 *  @return 解归档的对象
 */
+ (id)kl_unArchiveToName:(NSString *)name;

/**
 *  获取对象中包含的对象的归档
 *
 *  @param name  子对象地址,可用klArchiver_SonPath宏
 *
 *  @return 对象中包含的对象
 */
+ (id)kl_unArchiveSonEntityToName:(NSString *)name;

@end
