//
//  KLCaptchaView.m
//  生成验证码
//
//  Created by bcmac3 on 16/4/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLCaptchaView.h"

// 随机色
#define kRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
//线条的条数
#define kLineCount 10
//星星的个数
#define kStarCount 150

@interface KLCaptchaView()
/** 验证码拆开的各个字符 */
@property (nonatomic, strong) NSMutableArray *codeArr;
@end

@implementation KLCaptchaView

+ (instancetype)captchaViewWithFrame:(CGRect)frame count:(NSInteger)count {
    KLCaptchaView *captcha = [[KLCaptchaView alloc] initWithFrame:frame];
    captcha.count = count;
    return captcha;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.layer.borderColor = [UIColor clearColor].CGColor;
//        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    [self randomCode:self.count];
}

/**
 *  生成随机码
 */
- (void)randomCode:(NSInteger)count {
    if (self.codeArr.count) {
        [self.codeArr removeAllObjects];
    }
    for(NSInteger index = 0; index < count; index++) {
        NSInteger num = arc4random()%16;
        [self.codeArr addObject:[NSString stringWithFormat:@"%1lx", (long)num]];
    }
    _code = [self.codeArr componentsJoinedByString:@""];
    [self setNeedsDisplay];
}

- (NSMutableArray *)codeArr {
    if (!_codeArr) {
        _codeArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _codeArr;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    // 生成随机码
    [self randomCode:count];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    //随即画 kLineCount 条直线
    for (int i = 0; i < kLineCount; i++) {
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(arc4random()%(int)(w+1), arc4random()%(int)(h+1))];
        [bezierPath addLineToPoint:CGPointMake(arc4random()%(int)(w+1), arc4random()%(int)(h+1))];
        [kRandomColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
    
    //随即生成 kStarCount 个星星
    CGSize size = [@"*" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    for (int i = 0; i < kStarCount; i++) {
        CGRect textRect = CGRectMake(arc4random()%(int)(w+1-size.width), arc4random()%(int)(h+1), size.width, size.height);
        [kRandomColor setFill];
        [@"*" drawInRect:textRect withAttributes:@{NSFontAttributeName : [UIFont fontWithName: @"Helvetica" size: 12]}];
    }
    
    //验证码
    for (int i = 0; i < self.count; i++) {
        NSInteger random = arc4random() % 6;
        UIFont *font = [UIFont boldSystemFontOfSize:20 + random];//设置字体
        UIColor *color = [UIColor colorWithRed:arc4random()%100/255.0 green:arc4random()%150/255.0 blue:arc4random()%200/255.0 alpha:1];//字体颜色
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];//段落样式
        NSTextAlignment align = NSTextAlignmentCenter;//对齐方式
        style.alignment=align;
        CGSize codeSize = [self.codeArr[i] sizeWithAttributes:@{NSFontAttributeName:font}];
        CGRect textRect = CGRectMake(i*w/self.count + arc4random()%(int)(w/self.count+1-codeSize.width), arc4random()%(int)(h+1-codeSize.height), codeSize.width, codeSize.height);
        [self.codeArr[i] drawInRect:textRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:style}];
    }
}




@end
