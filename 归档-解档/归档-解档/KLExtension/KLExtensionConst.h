//
//  KLExtensionConst.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#ifndef __KLExtensionConst__H
#define __KLExtensionConst__H

#import <Foundation/Foundation.h>

// 过期
#define KLExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 日志输出
#ifdef DEBUG
#define KLExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define KLExtensionLog(...)
#endif

#define KLExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define KLExtensionAssert(condition) KLExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define KLExtensionAssertParamNotNil2(param, returnValue) \
KLExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define KLExtensionAssertParamNotNil(param) KLExtensionAssertParamNotNil2(param, )

/**
 * 打印所有的属性
 */
#define KLLogAllIvars \
-(NSString *)description \
{ \
return [self kl_keyValues].description; \
}
#define KLExtensionLogAllProperties KLLogAllIvars

/**
 *  类型（属性类型）
 */
extern NSString *const KLPropertyTypeInt;
extern NSString *const KLPropertyTypeShort;
extern NSString *const KLPropertyTypeFloat;
extern NSString *const KLPropertyTypeDouble;
extern NSString *const KLPropertyTypeLong;
extern NSString *const KLPropertyTypeLongLong;
extern NSString *const KLPropertyTypeChar;
extern NSString *const KLPropertyTypeBOOL1;
extern NSString *const KLPropertyTypeBOOL2;
extern NSString *const KLPropertyTypePointer;

extern NSString *const KLPropertyTypeIvar;
extern NSString *const KLPropertyTypeMethod;
extern NSString *const KLPropertyTypeBlock;
extern NSString *const KLPropertyTypeClass;
extern NSString *const KLPropertyTypeSEL;
extern NSString *const KLPropertyTypeId;

#endif