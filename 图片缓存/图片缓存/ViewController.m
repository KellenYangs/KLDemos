//
//  ViewController.m
//  图片缓存
//
//  Created by bcmac3 on 16/5/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import <YYWebImage/YYWebImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgv =  [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    imgv.backgroundColor = [UIColor orangeColor];
//    imgv.yy_imageURL = [NSURL URLWithString:@"http://7xsuaf.com1.z0.glb.clouddn.com/2015-10-25/数组1.jpeg"];
    [imgv yy_setImageWithURL:[NSURL URLWithString:@"http://github.com/logo.png"] options:YYWebImageOptionProgressive];
    [self.view addSubview:imgv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
