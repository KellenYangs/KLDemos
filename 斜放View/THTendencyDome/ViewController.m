//
//  ViewController.m
//  THTendencyDome
//
//  Created by 童浩 on 2018/8/16.
//  Copyright © 2018年 童小浩. All rights reserved.
//

#import "ViewController.h"
#import "THScrollTendencyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *imageS = [NSMutableArray array];
    for (int i = 0; i < 13; i ++) {
        [imageS addObject:[NSString stringWithFormat:@"image%d.jpg",i]];
    }
    THScrollTendencyView *thtend = [[THScrollTendencyView alloc]initWithFrame:CGRectMake(0, 120, k_mainSize.width, 430 * k_OnePx)];
    thtend.imageS = imageS;
    thtend.didBlock = ^(NSInteger index) {
        NSLog(@"%ld",index);
    };
    [self.view addSubview:thtend];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
