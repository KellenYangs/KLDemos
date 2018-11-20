//
//  THTendencyView.m
//  Mark_test
//
//  Created by 童浩 on 2018/8/15.
//  Copyright © 2018年 slb. All rights reserved.
//

#import "THTendencyView.h"
@interface THTendencyView()<UIScrollViewDelegate>
@property(nonatomic,assign) CGFloat w;
@property(nonatomic,assign) CGFloat h;
@property (nonatomic, strong) CAShapeLayer *showLayer;
@property(nonatomic,assign) CGFloat slopeAngle;
@end
@implementation THTendencyView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.w = self.bounds.size.width;
        self.h = self.bounds.size.height;
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.backgroundColor = [UIColor redColor];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        //显示点
        _slopeAngle = M_PI / 180.0 * 80;
        CGPoint point1 = CGPointMake(_h/tan(_slopeAngle), 0);
        CGPoint point2 = CGPointMake(_w, 0);
        CGPoint point3 = CGPointMake(_w - _h/tan(_slopeAngle), _h);
        CGPoint point4 = CGPointMake(0, _h);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        [path addLineToPoint:point4];
        [path closePath];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        self.layer.mask = layer;
    }
    return self;
}
- (void)setOneSlopeAngle:(CGFloat)slopeAngle andSize:(CGRect)rect {
    self.w = rect.size.width;
    self.h = rect.size.height;
    self.frame = rect;
    CGPoint point1 = CGPointMake(_h/tan(M_PI / 180.0 *slopeAngle), 0);
    CGPoint point2 = CGPointMake(_w, 0);
    CGPoint point3 = CGPointMake(_w - _h/tan(_slopeAngle), _h);
    CGPoint point4 = CGPointMake(0, _h);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}
- (void)setTwoPont:(CGFloat)twop SanSlopeAngle:(CGFloat)slopeAngle andSize:(CGRect)rect {
    self.w = rect.size.width;
    self.h = rect.size.height;
    self.frame = rect;
    CGPoint point1 = CGPointMake(_h / tan(M_PI / 180.0 * slopeAngle), 0);
    CGPoint point2 = CGPointMake(twop, 0);
    CGPoint point3 = CGPointMake(_w - _h/tan(_slopeAngle), _h);
    CGPoint point4 = CGPointMake(0, _h);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}
//确认点击区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPathRef path = ((CAShapeLayer *)self.layer.mask).path;
    if (CGPathIsEmpty(path)) {
        return YES;
    }
    //判断触发点是否在规定的 Shape 内
    if (CGPathContainsPoint(path, nil, point, nil)) {
        return YES;
    }
    return NO;
}
@end
