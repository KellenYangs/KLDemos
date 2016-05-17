//
//  ViewController.m
//  TEST
//
//  Created by bcmac3 on 16/5/6.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KL_Single.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KL_Single *s = [KL_Single sharedSingle];
//    s.name = @"xixi";
//    s.age = @"16";
    
    NSLog(@"%@--%@", s.name, s.age);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"%@  --- %@", paths, [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/KLNetworkingCaches"]);
    
    
    NSURL *URL = [NSURL URLWithString:@"http://103.242.168.151:81/TJH/product/proList"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", response);
    }];
    
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
