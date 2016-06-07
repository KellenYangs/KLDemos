//
//  KLArchiver.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+kl_Archiver.h"

#define KLArchiver_SonPath(FATHER_CLASS,FATHER_NAME,SON_CLASS,SON_NAME) \
[NSString stringWithFormat:@"%@_%@_%@_%@",FATHER_CLASS,FATHER_NAME,SON_CLASS,SON_NAME]

@interface KLArchiver : NSObject

/**
 *  清除所有归档
 */
+ (void)clearAll;

/**
 *  清除一个类别的归档
 *
 *  @param className 类别的名字
 */
+ (void)clear:(NSString *)className;

/**
 *  清除一个(className = 类别)&&(name = 归档对象的名字)的归档
 *
 *  @param className 类别的名字
 *  @param name      归档对象的名字
 */
+ (void)clear:(NSString *)className andName:(NSString *)name;

@end
