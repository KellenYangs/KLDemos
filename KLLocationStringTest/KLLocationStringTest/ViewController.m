//
//  ViewController.m
//  KLLocationStringTest
//
//  Created by bcmac3 on 16/8/31.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"页面一", nil);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.userInteractionEnabled = YES;
    label.backgroundColor = [UIColor orangeColor];
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    label.text = NSLocalizedString(@"Login", nil);
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginEvent)]];


}

- (void)loginEvent {
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 self.view.backgroundColor = [UIColor orangeColor];
 self.title = NSLocalizedString(@"页面二", nil);

 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
 label.userInteractionEnabled = YES;
 label.backgroundColor = [UIColor whiteColor];
 label.center = self.view.center;
 label.textAlignment = NSTextAlignmentCenter;
 label.font = [UIFont systemFontOfSize:20];
 [self.view addSubview:label];
 label.text = NSLocalizedString(@"还 OK?", nil);
 */

@end
