//
//  ViewController2.m
//  KLLocationStringTest
//
//  Created by bcmac3 on 16/8/31.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];


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


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
