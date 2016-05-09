//
//  ViewController.m
//  KL_RunTimeUse
//
//  Created by bcmac3 on 16/3/22.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+kl_ImageNamed.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *img = [[UIImage alloc] init];
    img.test = @"123";
    NSLog(@"%@", img.test);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
