//
//  Person.m
//  KL_RunTimeUse
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+ (void)load {
    NSLog(@"%s", __func__);
    [self getIvars];
    [self getProperties];
}

//+ (void)initialize
//{
//    NSLog(@"%s", __func__);
//    [self getIvars];
//    [self getProperties];
//}

+ (void)getIvars
{
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}

+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字, 类型
        NSLog(@"%s   <---->   %s", property_getName(property), property_getAttributes(property));
    }
    
    free(properties);
}

+ (void)getMethod {
    unsigned int count = 0;
    
    Method *meth = class_copyMethodList([self class], &count);
    
    for(int i = 0; i < count; i++) {
        Method thisIvar = meth[i];
        
        SEL sel = method_getName(thisIvar);
        const char *name = sel_getName(sel);
        
        NSLog(@"zp method :%s", name);
    }
    free(meth);
}


@end
