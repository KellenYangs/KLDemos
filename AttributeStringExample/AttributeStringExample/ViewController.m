//
//  ViewController.m
//  AttributeStringExample
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KLAttributedStringBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[KLAttributedStringBuilder builderWith:@"1231312"].lastRange setFont:[UIFont fontWithName:@"" size:12]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
