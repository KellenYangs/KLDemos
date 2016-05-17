//
//  ViewController.m
//  Test-KL
//
//  Created by bcmac3 on 16/4/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTools.h"
#import "KLNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

#define prolist @"product/proList"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [KLNetworking updateBaseUrl:@"http://192.168.0.222/TJH/"];
    [KLNetworking enableInterfaceDebug:YES];
    [KLNetworking cacheGetRequest:NO shoulCachePost:NO];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sort"] = @"0";
    params[@"schedule"] = @"1";
    params[@"orderBy"]  = @"1";
    params[@"search"]   = @"";
    params[@"currentPage"] = @"1";
    params[@"pageSize"] = @"10";
    
    [KLNetworking postWithUrl:prolist refreshCache:NO params:params success:^(id response) {
        NSLog(@"加载成功");
    } fail:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
    [KLNetworking cancelRequestWithURL:prolist];
    
    [KLNetworking postWithUrl:prolist refreshCache:NO params:params success:^(id response) {
        NSLog(@"加载成功");
    } fail:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    [KLNetworking cancelAllRequest];
    
    [KLNetworking postWithUrl:prolist refreshCache:NO params:params success:^(id response) {
        NSLog(@"加载成功");
    } fail:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
}

- (IBAction)setPOST:(id)sender {
    NSLog(@"-------------Start");
    [self post];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"取消-----------");
     [[[NetworkTools sharedNetworkTools] tasks] makeObjectsPerformSelector:@selector(cancel)];
}


- (void)post {
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sort"] = @"0";
    params[@"schedule"] = @"1";
    params[@"orderBy"]  = @"1";
    params[@"search"]   = @"";
    params[@"currentPage"] = @"1";
    params[@"pageSize"] = @"10";
    
    [[NetworkTools sharedNetworkTools] POST:prolist parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"加载成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@", error);
    }];
}

@end
