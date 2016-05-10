//
//  ViewController.m
//  SecurityTest
//
//  Created by bcmac3 on 16/5/10.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "SecurityUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *testString = @"kellen";
    NSString *baseStr = [SecurityUtil encodeBase64String:testString];
    NSLog(@"BASE64:%@", baseStr);
    NSLog(@"BASE64解密：%@", [SecurityUtil decodeBase64String:baseStr]);
    NSLog(@"MD5:%@", [SecurityUtil encryptMD5String:testString]);
    
    NSData *aesData = [SecurityUtil encryptAESData:testString];
    NSLog(@"AES加密:%@", aesData);
    NSLog(@"AES解密:%@", [SecurityUtil decryptAESData:aesData]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
