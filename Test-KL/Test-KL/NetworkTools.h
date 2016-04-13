//
//  NetworkTools.h
//  Test-KL
//
//  Created by bcmac3 on 16/4/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;

@end
