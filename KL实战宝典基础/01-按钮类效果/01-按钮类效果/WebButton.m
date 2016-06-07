//
//  WebButton.m
//  01-按钮类效果
//
//  Created by bcmac3 on 16/6/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "WebButton.h"

@implementation WebButton

- (void)drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    if ([_lineColor isKindOfClass:[UIColor class]]) {
        CGContextSetStrokeColorWithColor(contextRef, _lineColor.CGColor);
    }
    CGFloat y = textRect.origin.y + textRect.size.height + descender + 5;
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, y);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, y);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    [self.titleLabel setTextColor:[UIColor redColor]];
    self.titleLabel.textColor = [UIColor redColor];
    
}



@end
