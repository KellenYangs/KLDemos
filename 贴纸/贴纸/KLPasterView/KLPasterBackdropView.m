//
//  KLPasterBackdropView.m
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPasterBackdropView.h"
#import "KLPasterView.h"
#import "UIImage+kl_Add.h"

@interface KLPasterBackdropView () <KLPasterViewDelegate>
{
    CGPoint startPoint;
    CGPoint touchPoint;
}
/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *pasters;
@property (nonatomic,strong) UIImageView    *imgView;
@property (nonatomic,strong) KLPasterView   *pasterCurrent;
@property (nonatomic)        int             newPasterID;

@end

@implementation KLPasterBackdropView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        [self addSubview:self.imgView];
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAllEditing)];
        [self addGestureRecognizer:tapGest];
    }
    return self;
}

- (void)addPasterWithImg:(UIImage *)imgP {
    if (!imgP) {
        return;
    }
    [self cancelAllEditing];
    self.pasterCurrent = [[KLPasterView alloc] initWithBgView:self pasterId:self.newPasterID image:imgP];
    self.pasterCurrent.delegate = self;
    [self.pasters addObject:self.pasterCurrent];
}

- (UIImage *)doneEdit {
    [self cancelAllEditing];
    
    CGFloat org_width = self.originImage.size.width;
    CGFloat org_heigh = self.originImage.size.height;
    CGFloat rateOfScreen = org_width / org_heigh ;
    CGFloat inScreenH = self.frame.size.width / rateOfScreen ;
    
    CGRect rect = CGRectZero ;
    rect.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, inScreenH) ;
    rect.origin = CGPointMake(0, (self.frame.size.height - inScreenH) / 2) ;
    
    UIImage *imgTemp = [UIImage getImageFromView:self];
//    UIImage *imgCut = [UIImage squareImageFromImage:imgTemp scaledToSize:rect.size.width];
    return imgTemp ;

}

- (void)cancelAllEditing {
    _pasterCurrent.editing = NO;
    [self.pasters enumerateObjectsUsingBlock:^(KLPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        pasterV.editing = NO ;
    }] ;
}

#pragma mark -- KLPasterViewDelegate
- (void)makePasterBecomeFirstRespond:(int)pasterID {
    [self.pasters enumerateObjectsUsingBlock:^(KLPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        
        pasterV.editing = NO ;
        
        if (pasterV.pasterId == pasterID) {
            self.pasterCurrent = pasterV ;
            pasterV.editing = YES ;
            *stop = YES;
        }
        
    }] ;

}

- (void)removePaster:(int)pasterID {
    [self.pasters enumerateObjectsUsingBlock:^(KLPasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        if (pasterV.pasterId == pasterID)
        {
            [self.pasters removeObjectAtIndex:idx] ;
            *stop = YES ;
        }
    }] ;
}

#pragma mark -- Setter && Getter
- (void)setOriginImage:(UIImage *)originImage {
    if (originImage) {
        _originImage = originImage;
        self.imgView.image = originImage;
    }
}

- (int)newPasterID {
    _newPasterID++;
    return _newPasterID;
}

- (void)setPasterCurrent:(KLPasterView *)pasterCurrent {
    if (pasterCurrent) {
        _pasterCurrent = pasterCurrent;
        [self bringSubviewToFront:_pasterCurrent];
    }
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgView;
}

- (NSMutableArray *)pasters {
    if (!_pasters) {
        _pasters = [NSMutableArray array];
    }
    return _pasters;
}

@end

























