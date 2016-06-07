//
//  NSObject+kl_Properties.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (kl_Properties)

/**
 *  获取一个类所有的成员变量及类型
 *
 *  @return @[@{@"name":@"xxx", @"type":@"xxxx"}...]
 */
- (NSArray *)kl_allProperty;

@end
