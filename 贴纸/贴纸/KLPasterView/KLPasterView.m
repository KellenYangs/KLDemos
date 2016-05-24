//
//  KLPasterView.m
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPasterView.h"
#import "KLPasterBackdropView.h"

#define IOS_DEBUG
#ifdef  IOS_DEBUG
#define KLLog(format,...) NSLog(@"%s(%d): " format, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define KLLog(format,...)
#endif

CGFloat const PASTER_SLIDE      = 100.0;     // 贴纸大小
CGFloat const FLEX_SLIDE        = 15.0;      // 内边距
CGFloat const BT_SLIDE          = 30.0;      // 旋转图片大小
CGFloat const BORDER_LINE_WIDTH = 1.0;
CGFloat const SECURITY_LENGTH   = 75.0;

@interface KLPasterView ()
/** <#注释#> */
@property (nonatomic, assign) CGFloat minWidth;
/** <#注释#> */
@property (nonatomic, assign) CGFloat minHeight;
/**  */
@property (nonatomic, assign) CGFloat deltaAngle;
/** <#注释#> */
@property (nonatomic, assign) CGPoint prevPoint;
/** <#注释#> */
@property (nonatomic, assign) CGPoint touchStart;
/** <#注释#> */
@property (nonatomic, assign) CGRect bgRect;

/** 内容图片 */
@property (nonatomic, strong) UIImageView *contentImageView;
/** 删除 */
@property (nonatomic, strong) UIImageView *deleteImageView;
/** 旋转 */
@property (nonatomic, strong) UIImageView *rotateImageView;

@end

@implementation KLPasterView

- (void)remove {
    [self removeFromSuperview];
    [self.delegate removePaster:self.pasterId];
}

- (instancetype)initWithBgView:(KLPasterBackdropView *)bgView
                      pasterId:(int)pasterId
                         image:(UIImage *)image {
    if (self = [super init]) {
        self.pasterId = pasterId;
        self.pasterImage = image;
        
        self.bgRect = bgView.frame;
        
        [self setUp];
        [self addSubview:self.contentImageView];
        [self addSubview:self.deleteImageView];
        [self addSubview:self.rotateImageView];
        [bgView addSubview:self];

        self.editing = YES;
    }
    return self;
}

- (void)setUp {
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(PASTER_SLIDE, PASTER_SLIDE);
    self.frame = rect;
    self.center = CGPointMake(self.bgRect.size.width * 0.5, self.bgRect.size.height * 0.5);
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGesture];
    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self addGestureRecognizer:rotateGesture];
    
    self.minWidth  = self.bounds.size.width * 0.5;
    self.minHeight = self.bounds.size.height * 0.5;
    self.deltaAngle = atan2(self.frame.origin.y + self.frame.size.height * 0.5, self.frame.origin.x + self.frame.size.width * 0.5);
}

- (void)handleRotation:(UIRotationGestureRecognizer *)rotateGesture {
    KLLog(@"rotate paster start!");
    self.editing = YES;
    [self.delegate makePasterBecomeFirstRespond:self.pasterId];
    
    self.transform = CGAffineTransformRotate(self.transform, rotateGesture.rotation);
    rotateGesture.rotation = 0;
}

- (void)tap:(UITapGestureRecognizer *)tapGesture {
    KLLog(@"tap paster become first respond!");
    self.editing = YES;
    [self.delegate makePasterBecomeFirstRespond:self.pasterId];
}

- (void)resizeTranslate:(UIPanGestureRecognizer *)panResizeGesture {
    if (panResizeGesture.state == UIGestureRecognizerStateBegan) {
        self.prevPoint = [panResizeGesture locationInView:self];
        [self setNeedsDisplay];
    } else if (panResizeGesture.state == UIGestureRecognizerStateChanged) {
        if (self.bounds.size.width < self.minWidth || self.bounds.size.height < self.minHeight) {
            self.bounds = CGRectMake(self.bounds.origin.x,
                                     self.bounds.origin.y,
                                     self.minWidth + 1,
                                     self.minHeight + 1);
            self.rotateImageView.frame =CGRectMake(self.bounds.size.width - BT_SLIDE,
                                                   self.bounds.size.height - BT_SLIDE,
                                                   BT_SLIDE,
                                                   BT_SLIDE);
            self.prevPoint = [panResizeGesture locationInView:self];
        } else {
            CGPoint point = [panResizeGesture locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            
            wChange = (point.x - self.prevPoint.x);
            float wRatioChange = (wChange/(float)self.bounds.size.width);
            
            hChange = wRatioChange * self.bounds.size.height;
            
            if (ABS(wChange) > 50.0f || ABS(hChange) > 50.0f)
            {
                self.prevPoint = [panResizeGesture locationOfTouch:0 inView:self];
                return;
            }
            
            CGFloat finalWidth  = self.bounds.size.width + (wChange) ;
            CGFloat finalHeight = self.bounds.size.height + (wChange) ;
            
            if (finalWidth > PASTER_SLIDE*(1+0.5)) {
                finalWidth = PASTER_SLIDE*(1+0.5);
            }
            if (finalWidth < PASTER_SLIDE*(1-0.5)) {
                finalWidth = PASTER_SLIDE*(1-0.5);
            }
            if (finalHeight > PASTER_SLIDE*(1+0.5)) {
                finalHeight = PASTER_SLIDE*(1+0.5);
            }
            if (finalHeight < PASTER_SLIDE*(1-0.5)) {
                finalHeight = PASTER_SLIDE*(1-0.5);
            }
            
            self.bounds = CGRectMake(self.bounds.origin.x,
                                     self.bounds.origin.y,
                                     finalWidth,
                                     finalHeight);
            
            self.rotateImageView.frame = CGRectMake(self.bounds.size.width  - BT_SLIDE  ,
                                                    self.bounds.size.height - BT_SLIDE ,
                                                    BT_SLIDE ,
                                                    BT_SLIDE) ;
            
            self.prevPoint = [panResizeGesture locationOfTouch:0 inView:self] ;
        }
        
        /* Rotation */
        float ang = atan2([panResizeGesture locationInView:self.superview].y - self.center.y, [panResizeGesture locationInView:self.superview].x - self.center.x) ;
        
        float angleDiff = self.deltaAngle - ang ;
        
        self.transform = CGAffineTransformMakeRotation(-angleDiff) ;
        
        [self setNeedsDisplay];
    } else if (panResizeGesture.state == UIGestureRecognizerStateEnded) {
        self.prevPoint = [panResizeGesture locationInView:self];
        [self setNeedsDisplay];
    }
}

- (void)btDeletePressed:(UITapGestureRecognizer *)tapGesture {
    KLLog(@"paster will remove!") ;
    [self remove] ;
}

#pragma mark -- touch 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.editing = YES ;
    [self.delegate makePasterBecomeFirstRespond:self.pasterId] ;
    
    UITouch *touch = [touches anyObject] ;
    self.touchStart = [touch locationInView:self.superview] ;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(self.rotateImageView.frame, touchLocation)) {
        return;
    }
    
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    
    [self translateUsingTouchLocation:touch] ;
    
    self.touchStart = touch;
}

- (void)translateUsingTouchLocation:(CGPoint)touchPoint {
    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - self.touchStart.x,
                                    self.center.y + touchPoint.y - self.touchStart.y) ;
    
    // Ensure the translation won't cause the view to move offscreen. BEGIN
    CGFloat midPointX = CGRectGetMidX(self.bounds) ;
    if (newCenter.x > self.superview.bounds.size.width - midPointX + SECURITY_LENGTH)
    {
        newCenter.x = self.superview.bounds.size.width - midPointX + SECURITY_LENGTH;
    }
    if (newCenter.x < midPointX - SECURITY_LENGTH)
    {
        newCenter.x = midPointX - SECURITY_LENGTH;
    }
    
    CGFloat midPointY = CGRectGetMidY(self.bounds);
    if (newCenter.y > self.superview.bounds.size.height - midPointY + SECURITY_LENGTH)
    {
        newCenter.y = self.superview.bounds.size.height - midPointY + SECURITY_LENGTH;
    }
    if (newCenter.y < midPointY - SECURITY_LENGTH)
    {
        newCenter.y = midPointY - SECURITY_LENGTH;
    }
    
    // Ensure the translation won't cause the view to move offscreen. END
    self.center = newCenter;
}

#pragma mark -- Setter && Getter
- (void)setPasterImage:(UIImage *)pasterImage {
    if (pasterImage) {
        _pasterImage = pasterImage;
        self.contentImageView.image = pasterImage;
    }
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    
    self.deleteImageView.hidden = !editing;
    self.rotateImageView.hidden = !editing;
    self.contentImageView.layer.borderWidth = editing ? BORDER_LINE_WIDTH : 0.0;
    if (editing) {
        KLLog(@"pasterId : %d", self.pasterId);
    }
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(FLEX_SLIDE, FLEX_SLIDE, PASTER_SLIDE - FLEX_SLIDE * 2, PASTER_SLIDE - FLEX_SLIDE * 2)];
        _contentImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _contentImageView.layer.borderWidth = BORDER_LINE_WIDTH;
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self addSusbview:_contentImageView];
    }
    return _contentImageView;
}

- (UIImageView *)rotateImageView {
    if (!_rotateImageView) {
        _rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - BT_SLIDE, self.frame.size.height - BT_SLIDE, BT_SLIDE, BT_SLIDE)];
        _rotateImageView.userInteractionEnabled = YES;
        _rotateImageView.image = [UIImage imageNamed:@"bt_paster_transform"];
        
        UIPanGestureRecognizer *panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(resizeTranslate:)] ;
        [_rotateImageView addGestureRecognizer:panResizeGesture];
//        [self addSubview:_rotateImageView];
    }
    return _rotateImageView;
}

- (UIImageView *)deleteImageView {
    if (!_deleteImageView) {
        _deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BT_SLIDE, BT_SLIDE)];
        _deleteImageView.userInteractionEnabled = YES;
        _deleteImageView.image = [UIImage imageNamed:@"bt_paster_delete"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(btDeletePressed:)] ;
        [_deleteImageView addGestureRecognizer:tap] ;
//        [self addSubview:_deleteImageView];
    }
    return _deleteImageView;
}

@end























