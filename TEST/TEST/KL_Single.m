//
//  KL_Single.m
//  TEST
//
//  Created by bcmac3 on 16/5/13.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KL_Single.h"

@implementation KL_Single

+ (instancetype)sharedSingle {
    static KL_Single *_s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s = [[KL_Single alloc] init];
    });
    return _s;
}

@end
