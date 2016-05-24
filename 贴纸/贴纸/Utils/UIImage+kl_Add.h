//
//  UIImage+kl_Add.h
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (kl_Add)

+ (UIImage *)squareImageFromImage:(UIImage *)image
                     scaledToSize:(CGFloat)newSize;

+ (UIImage *)getImageFromView:(UIView *)theView;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
