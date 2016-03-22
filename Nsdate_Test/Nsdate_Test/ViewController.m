//
//  ViewController.m
//  Nsdate_Test
//
//  Created by bcmac3 on 16/3/18.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

#define Date1 @"2016-03-15 03:55:25"
#define Date2 @"2016-03-16 11:33:45"
#define Date3 @"2016-03-15 20:52:41"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
    [self test2];
    
}

- (void)test2 {
    NSLog(@"------------------ %s --------------", __func__);

    NSDate *now = [NSDate date];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 24H->HH
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [format dateFromString:Date1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
    NSLog(@"%zd", year);
    
    
    
    
    NSLog(@"------------------ %s --------------", __func__);
}

- (void)test1 {
    NSLog(@"------------------ %s --------------", __func__);
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 24H->HH
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [format dateFromString:Date2];
    
    // 相差多少s
    NSTimeInterval delta = [create timeIntervalSinceDate:now];
    
    NSLog(@"%@ %@ %f", now, create, delta);
    NSLog(@"------------------ %s --------------", __func__);
}











@end
