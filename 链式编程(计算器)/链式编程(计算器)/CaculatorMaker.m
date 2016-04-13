//
//  CaculatorMaker.m
//  链式编程(计算器)
//
//  Created by bcmac3 on 16/4/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(NSInteger number))add {
    return ^(NSInteger number){
        _result += number;
        return self;
    };
}
@end
