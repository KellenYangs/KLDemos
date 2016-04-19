//
//  ViewController.m
//  生成验证码
//
//  Created by bcmac3 on 16/4/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KLCaptchaView.h"

@interface ViewController ()
@property (strong, nonatomic) KLCaptchaView *yzmView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KLCaptchaView *yzmView = [KLCaptchaView captchaViewWithFrame:CGRectMake(150, 100, 150, 30) count:6];
    yzmView.count = 4;
    [self.view addSubview:yzmView];
    self.yzmView = yzmView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@", self.yzmView.code);
}

@end
