
//
//  KLViewController.m
//  Test-KL
//
//  Created by bcmac3 on 16/4/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLViewController.h"
#import "NetworkTools.h"

@interface KLViewController ()

@end

@implementation KLViewController


/*
 // 结束之前的所有请求
 [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
 
 // 取消所有任务
 //    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
 [self.manager invalidateSessionCancelingTasks:YES];
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"取消-----------");
    
    // 能不这样写就别这样写   会是之后的请求都无效
    [[NetworkTools sharedNetworkTools] invalidateSessionCancelingTasks:YES];
}

- (IBAction)setPost:(id)sender {
    NSLog(@"-------------Start");
    [self post];
}

#define prolist @"product/proList"

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
