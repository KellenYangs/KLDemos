//
//  ViewController.m
//  OpenSetting
//
//  Created by bcmac3 on 16/4/13.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (IBAction)openSetting:(UIButton *)sender {
    
    NSString *set1 = @"open iPhone setting";
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"Sad Face Emoji!" message:@"The calendar permission was not authorized. Please enable it in Settings to continue." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Open Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        [[UIApplication sharedApplication] openURL:url];
    }];
    
    [alertVc addAction:action];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:cancel];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
