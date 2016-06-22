//
//  ViewController.m
//  撕衣服
//
//  Created by bcmac3 on 16/6/12.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property(nonatomic,assign) BOOL isTouch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 获取手指
    UITouch *touch = [touches anyObject];
    
    // 判断手指是否在触摸
    if (touch.view == self.imgv ) {
        self.isTouch = YES;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTouch) {
        // 开启上下文
        UIGraphicsBeginImageContext(self.imgv.frame.size);
        // 将图片绘制到图形上下文中
        [self.imgv.image drawInRect:self.imgv.bounds];
        // 清空手指触摸的位置
        // 拿到手指,根据手指的位置,让对应的位置成为透明
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:touch.view];
        CGRect rect = CGRectMake(point.x - 10, point.y - 10, 20, 20);
        // 清空rect
        CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
        
        // 取出会之后的图片赋值给imageB
        self.imgv.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.isTouch = NO;
}


@end
