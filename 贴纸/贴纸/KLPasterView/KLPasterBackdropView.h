//
//  KLPasterBackdropView.h
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLPasterBackdropView : UIView

/** <#注释#> */
@property (nonatomic, strong) UIImage *originImage;

- (void)addPasterWithImg:(UIImage *)imgP;
- (UIImage *)doneEdit;

@end
