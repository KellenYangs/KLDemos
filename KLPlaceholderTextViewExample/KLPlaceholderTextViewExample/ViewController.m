//
//  ViewController.m
//  KLPlaceholderTextViewExample
//
//  Created by bcmac3 on 16/3/22.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KLPlaceholderTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KLPlaceholderTextView *textView = [[KLPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"我们将要决赛哦你啥的就懒得发无情刻进去理科女卡刷卡机健康违法和清洁可融合科技生了健康爱是e";
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
