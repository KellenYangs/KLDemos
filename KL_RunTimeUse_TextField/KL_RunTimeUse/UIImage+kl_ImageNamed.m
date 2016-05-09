//
//  UIImage+kl_ImageNamed.m
//  KL_RunTimeUse
//
//  Created by bcmac3 on 16/5/9.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "UIImage+kl_ImageNamed.h"
#import <objc/runtime.h>

@implementation UIImage (kl_ImageNamed)
// 利用关联添加属性

char testKey;

- (void)setTest:(NSString *)test {
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &testKey, test, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)test {
    return objc_getAssociatedObject(self, &testKey);
}


+ (void)load {
    // 获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(kl_imageNamed:));
    // 开始交换方法实现
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)kl_imageNamed:(NSString *)name {
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        // 如果系统版本是7.0以上，使用另外一套文件名结尾是‘_os7’的扁平化图片
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage kl_imageNamed:name];
}

@end
