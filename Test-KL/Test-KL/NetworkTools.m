//
//  NetworkTools.m
//  Test-KL
//
//  Created by bcmac3 on 16/4/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

static NSString * const KLBaseURLString = @"http://192.168.0.222/TJH/";

+ (instancetype)sharedNetworkTools {
    static NetworkTools *_m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _m = [[NetworkTools alloc] initWithBaseURL:[NSURL URLWithString:KLBaseURLString]];
        [_m.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil]];
    });
    return _m;
}

@end
