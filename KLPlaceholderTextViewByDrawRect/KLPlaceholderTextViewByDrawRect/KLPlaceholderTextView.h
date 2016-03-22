//
//  KLTextView.h
//  KLPlaceholderTextViewByDrawRect
//
//  Created by bcmac3 on 16/3/21.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
