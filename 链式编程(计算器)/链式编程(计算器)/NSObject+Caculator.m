//
//  NSObject+Caculator.m
//  链式编程(计算器)
//
//  Created by bcmac3 on 16/4/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+ (NSInteger)makeCaculator:(void(^)(CaculatorMaker *maker))block {
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    block(maker);
    
    return [maker result];
}

@end
