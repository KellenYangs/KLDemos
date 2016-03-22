//
//  ViewController.m
//  KLPlaceholderTextViewByDrawRect
//
//  Created by bcmac3 on 16/3/21.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KLPlaceholderTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KLPlaceholderTextView *textView = [[KLPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
