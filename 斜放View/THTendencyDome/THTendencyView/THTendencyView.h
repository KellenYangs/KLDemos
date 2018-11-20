//
//  THTendencyView.h
//  Mark_test
//
//  Created by 童浩 on 2018/8/15.
//  Copyright © 2018年 slb. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_mainSize [UIScreen mainScreen].bounds.size
#define k_OnePx (k_mainSize.width / 750.0)
@interface THTendencyView : UIView
@property(nonatomic,strong) UIImageView * imageView;
//改变点 改变显示
- (void)setOneSlopeAngle:(CGFloat)slopeAngle andSize:(CGRect)rect;
- (void)setTwoPont:(CGFloat)twop SanSlopeAngle:(CGFloat)slopeAngle andSize:(CGRect)rect;

@end
