//
//  THScrollTendencyView.m
//  Mark_test
//
//  Created by 童浩 on 2018/8/15.
//  Copyright © 2018年 slb. All rights reserved.
//

//间距
#define k_jianJu 10
#import "THScrollTendencyView.h"
@interface THScrollTendencyView()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *rootS;
@property(nonatomic,assign) CGFloat slopeAngle; //角度要与显示的View(THTendencyView) slopeAngle 角度一致
@property(nonatomic,assign) CGFloat oneWidth;  //第一张的宽度
@property(nonatomic,assign) CGFloat qitaWidth; //其他的宽度
@property(nonatomic,assign) CGFloat tanValue; //计算后折叠宽度
@property(nonatomic,assign) NSInteger index; //当前记录第几张
@end
@implementation THScrollTendencyView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _slopeAngle = M_PI / 180.0 * 80;
        _tanValue = self.bounds.size.height / tan(_slopeAngle);
        _oneWidth = 510 * k_OnePx;
        _qitaWidth = 265 * k_OnePx;
        _index = 0;
        self.rootS = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,(_qitaWidth - _tanValue + k_jianJu), self.bounds.size.height)];
        self.rootS.pagingEnabled=YES;
        self.rootS.clipsToBounds=NO;
        self.rootS.bounces=YES;
        self.rootS.showsVerticalScrollIndicator = NO;
        self.rootS.showsHorizontalScrollIndicator = NO;
        self.rootS.delegate = self;
        [self addSubview:self.rootS];
        [self.rootS setDecelerationRate:1];
    }
    return self;
}
//布局
- (void)setImageS:(NSArray *)imageS {
    _imageS = imageS;
    for (THTendencyView *view in self.rootS.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < imageS.count; i++) {
        THTendencyView *tendView = nil;
        if (i == 0) {
            tendView = [[THTendencyView alloc]initWithFrame:CGRectMake(0, 0, _oneWidth, self.bounds.size.height)];
            [tendView setOneSlopeAngle:90.0 andSize:CGRectMake(0, 0, _oneWidth, self.bounds.size.height)];
        }else {
            tendView = [[THTendencyView alloc]initWithFrame:CGRectMake((_oneWidth - _tanValue + k_jianJu) + (i - 1) * (_qitaWidth - _tanValue + k_jianJu), 0,_oneWidth, self.bounds.size.height)];
            [tendView setOneSlopeAngle:80.0 andSize:CGRectMake((_oneWidth - _tanValue + k_jianJu) + (i - 1) * (_qitaWidth - _tanValue + k_jianJu), 0,_qitaWidth, self.bounds.size.height)];
        }
        tendView.tag = 643 + i;
        tendView.imageView.image = [UIImage imageNamed:imageS[i]];
        [self.rootS addSubview:tendView];
        //添加点击方法
        tendView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tapGes =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapMethod:)];
        [tendView addGestureRecognizer:tapGes];
    }
    //滚动范围
    self.rootS.contentSize = CGSizeMake(_rootS.bounds.size.width * _imageS.count, self.bounds.size.height);
}
//点击返回
- (void)tapMethod:(UIGestureRecognizer*)sender
{
    if (self.didBlock) {
        self.didBlock(sender.view.tag - 643);
    }
}
#pragma mark---修改hitTest方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self]){
        for (UIView *subview in _rootS.subviews){
            CGPoint offset = CGPointMake(point.x - _rootS.frame.origin.x + _rootS.contentOffset.x - subview.frame.origin.x, point.y - _rootS.frame.origin.y + _rootS.contentOffset.y - subview.frame.origin.y);
            if ((view = [subview hitTest:offset withEvent:event])){
                return view;
            }
        }
        return _rootS;
    }
    return view;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat scroCW = scrollView.contentOffset.x;
    CGFloat itemW = _rootS.bounds.size.width;
    NSInteger index = (NSInteger)((scroCW + itemW / 2) / itemW);
    CGFloat frameX = ((_oneWidth - _tanValue + k_jianJu ) - itemW);
    if (index < _index) {
        index = _index - 1; //确保每次只滑动一张
        THTendencyView *thtenView1 = [self viewWithTag:643 + index];
        //改变显示区域
        [thtenView1 setOneSlopeAngle:90.0 andSize:CGRectMake((thtenView1.frame.origin.x), 0,_oneWidth, self.bounds.size.height)];
        //改变显示区域
        for (int i = 0; i < _imageS.count; i++) {
            THTendencyView *thtenView = [self viewWithTag:643 + i];
            if (i < index) {
                [thtenView setTwoPont:_qitaWidth - self.bounds.size.height/tan(_slopeAngle) SanSlopeAngle:90.0 andSize:CGRectMake(i * (_qitaWidth - _tanValue + k_jianJu), 0,_qitaWidth, self.bounds.size.height)];
            }else if (i > index){
                [thtenView setOneSlopeAngle:80.0 andSize:CGRectMake((thtenView1.frame.origin.x + thtenView1.frame.size.width - _tanValue + k_jianJu) + (i - index - 1) * (_qitaWidth - _tanValue + k_jianJu) , 0,_qitaWidth, self.bounds.size.height)];
            }
        }
        [scrollView setContentOffset:CGPointMake(thtenView1.frame.origin.x, 0) animated:YES];
    }else if (index > _index){
        index = _index + 1; //确保每次只滑动一张
        THTendencyView *thtenView1 = [self viewWithTag:643 + index];
        //改变显示区域
        [thtenView1 setOneSlopeAngle:90.0 andSize:CGRectMake((thtenView1.frame.origin.x - frameX), 0,_oneWidth, self.bounds.size.height)];
        //改变显示区域
        for (int i = 0; i < _imageS.count; i++) {
            THTendencyView *thtenView = [self viewWithTag:643 + i];
            if (i < index) {
                [thtenView setTwoPont:_qitaWidth - self.bounds.size.height/tan(_slopeAngle) SanSlopeAngle:90.0 andSize:CGRectMake(i * (_qitaWidth - _tanValue + k_jianJu), 0,_qitaWidth, self.bounds.size.height)];
            }else if (i > index){
                [thtenView setOneSlopeAngle:80.0 andSize:CGRectMake((thtenView1.frame.origin.x + thtenView1.frame.size.width - _tanValue + k_jianJu) + (i - index - 1) * (_qitaWidth - _tanValue + k_jianJu) , 0,_qitaWidth, self.bounds.size.height)];
            }
        }
        [scrollView setContentOffset:CGPointMake(thtenView1.frame.origin.x, 0) animated:YES];
    }else {
        index = _index;
    }
    _index = index;
}

@end
