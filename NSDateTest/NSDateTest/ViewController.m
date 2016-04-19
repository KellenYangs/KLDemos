//
//  ViewController.m
//  NSDateTest
//
//  Created by bcmac3 on 16/4/13.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#注释#> */
@property (nonatomic, copy) NSString *date1;
/** <#注释#> */
@property (nonatomic, copy) NSString *date2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.date1 = @"2016-04-20 08:33:55";
    self.date2 = @"2016-01-12 18:22:33";
    
    [self compare];
    
//    [self timeInterval];
//    
//    [self addingTimeInterval];
//    
//    [self stringByDate];
    
}

- (void)compare {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"%@ - %@", self.date1, self.date2);
    
    NSDate *dateO = [fmt dateFromString:self.date1];
    NSDate *dateT = [fmt dateFromString:self.date2];
    NSLog(@"%@ - %@", dateO, dateT);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateT toDate:dateO options:0];
    NSLog(@"%@", cmps);

    
}

- (void)test {
    /*
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
*/
}



- (NSString *)stringByDate
{
    NSDateFormatter*formatter = [[NSDateFormatter alloc] init];
    // 大写的H日期格式将默认为24小时制，小写的h日期格式将默认为12小时
    [formatter setDateFormat:@"yyyy-MM-dd EEEE HH:mm:ss a"];
    // 2016-04-13 Wednesday 15:35:27 PM
    NSString *locationString=[formatter stringFromDate: [NSDate date]];
    return locationString;
}

/**
 *  增加时间间隔
 */
- (void)addingTimeInterval
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *now = [NSDate date];
    NSDate *tomorrow = [now dateByAddingTimeInterval:secondsPerDay];
    NSDate *yesterday = [now dateByAddingTimeInterval:-secondsPerDay];
    NSLog(@"%@ - %@ - %@", now, tomorrow, yesterday);
}


/**
 *  一定时间间隔
 */
- (void)timeInterval
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-secondsPerDay];
    NSLog(@"%@ %@", tomorrow, yesterday);
}

@end
