//
//  KLCaptchaView.h
//  生成验证码
//
//  Created by bcmac3 on 16/4/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLCaptchaView : UIView

/** 验证码的个数 */
@property (nonatomic, assign) NSInteger count;

/** 验证码 */
@property (nonatomic, copy, readonly) NSString *code;

+ (instancetype)captchaViewWithFrame:(CGRect)frame count:(NSInteger)count;

@end
