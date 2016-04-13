//
//  ViewController.m
//  链式编程(计算器)
//
//  Created by bcmac3 on 16/4/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int num =  [NSObject makeCaculator:^(CaculatorMaker *maker){
        maker.add(10);
        maker.add(20);
    }];
    NSLog(@"%zd", num);
    
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    NSLog(@"%ld", [maker.add(10).add(20) result]);
    
   
    
}

@end
