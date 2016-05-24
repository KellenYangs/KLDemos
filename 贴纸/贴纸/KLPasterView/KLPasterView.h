//
//  KLPasterView.h
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLPasterBackdropView;

@protocol KLPasterViewDelegate <NSObject>
/**
 *  根据ID将贴纸放在最上面
 */
- (void)makePasterBecomeFirstRespond:(int)pasterID;
/**
 *  根据ID移除贴纸
 */
- (void)removePaster:(int)pasterID;
@end

@interface KLPasterView : UIView

/** 图片 */
@property (nonatomic, strong) UIImage *pasterImage;
/** ID */
@property (nonatomic, assign) int pasterId;
/** 是否正在编辑 */
@property (nonatomic, assign) BOOL editing;
/** 代理 */
@property (nonatomic, weak) id <KLPasterViewDelegate> delegate;

- (instancetype)initWithBgView:(KLPasterBackdropView *)bgView
                      pasterId:(int)pasterId
                         image:(UIImage *)image;
- (void)remove;

@end
