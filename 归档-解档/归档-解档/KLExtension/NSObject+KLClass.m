//
//  NSObject+KLClass.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "NSObject+KLClass.h"
#import "KLFoundation.h"
#import <objc/runtime.h>

static const char KLAllowedPropertyNamesKey = '\0';
static const char KLIgnoredPropertyNamesKey = '\0';
static const char KLAllowedCodingPropertyNamesKey = '\0';
static const char KLIgnoredCodingPropertyNamesKey = '\0';

static NSMutableDictionary *allowedPropertyNamesDict_;
static NSMutableDictionary *ignoredPropertyNamesDict_;
static NSMutableDictionary *allowedCodingPropertyNamesDict_;
static NSMutableDictionary *ignoredCodingPropertyNamesDict_;

@implementation NSObject (KLClass)

+ (void)load {
    allowedPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredPropertyNamesDict_ = [NSMutableDictionary dictionary];
    allowedCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
}

+ (NSMutableDictionary *)dictForKey:(const void *)key {
    if (key == &KLAllowedPropertyNamesKey) return allowedPropertyNamesDict_;
    if (key == &KLIgnoredPropertyNamesKey) return ignoredPropertyNamesDict_;
    if (key == &KLAllowedCodingPropertyNamesKey) return allowedCodingPropertyNamesDict_;
    if (key == &KLIgnoredCodingPropertyNamesKey) return ignoredCodingPropertyNamesDict_;
    return nil;
}

+ (void)kl_enumerateClasses:(KLClassesEnumeration)enumeration
{
    // 1.没有block就直接返回
    if (enumeration == nil) return;
    
    // 2.停止遍历的标记
    BOOL stop = NO;
    
    // 3.当前正在遍历的类
    Class c = self;
    
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        enumeration(c, &stop);
        
        // 4.2.获得父类
        c = class_getSuperclass(c);
        
        if ([KLFoundation isClassFromFoundation:c]) break;
    }
}

@end
