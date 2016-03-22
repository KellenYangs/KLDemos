//
//  KLTextView.m
//  KLPlaceholderTextViewByDrawRect
//
//  Created by bcmac3 on 16/3/21.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPlaceholderTextView.h"

@implementation KLPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    [self setNeedsDisplay];
}

/**
 * 绘制占位文字(每次drawRect:之前, 会自动清除掉之前绘制的内容)
 */
- (void)drawRect:(CGRect)rect {
    // 如果有文字, 直接返回, 不绘制占位文字
    //    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    // 处理rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}


@end
