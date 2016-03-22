//
//  KLTopWindow.m
//  KL-Use
//
//  Created by jensen on 16/3/20.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLTopWindow.h"
#import <UIKit/UIKit.h>

@implementation KLTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20);
    window_.windowLevel = UIWindowLevelAlert;
    UIViewController *v = [[UIViewController alloc] init];
    v.view.backgroundColor = [UIColor clearColor];
    window_.rootViewController = v;
    window_.backgroundColor = [UIColor clearColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hide
{
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        // 主窗口
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        // 以主窗口左上角为坐标原点, 计算self的矩形框
        CGRect newFrame = [keyWindow convertRect:subview.frame fromView:subview.superview];
        CGRect winBounds = keyWindow.bounds;
        
        // 主窗口的bounds 和 self的矩形框 是否有重叠
        BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
        
        if ([subview isKindOfClass:[UIScrollView class]] && !subview.isHidden && subview.alpha > 0.01 && subview.window == keyWindow && intersects) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
