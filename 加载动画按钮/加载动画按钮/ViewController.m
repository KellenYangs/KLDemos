//
//  ViewController.m
//  加载动画按钮
//
//  Created by bcmac3 on 16/4/19.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) CAReplicatorLayer *replicatorLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个imageView
    [self addImageView];
    // 设置CAReplicatorLayer
    [self addReplicatorLayer];
    //  开始动画
    [self animation];
}

- (void)addImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    
    _imageView = imageView;
}

- (void)addReplicatorLayer
{
    /** CAReplicatorLayer可以复制自己子层的layer,并且复制的出来的layer和原来的子layer拥有相同的动效*/
    // 可以理解成为一个复制的货吧
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    replicatorLayer.bounds = self.view.bounds;
    
    /** 视图相对于父视图的重心位置*/
    replicatorLayer.position = self.view.center;
    
    /** 是否开启三维空间效果*/
    replicatorLayer.preservesDepth = YES;
    
    
    //    replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
    //    replicatorLayer.instanceRedOffset = 0.1;
    //    replicatorLayer.instanceGreenOffset = 0.1;
    //    replicatorLayer.instanceBlueOffset = 0.1;
    //    replicatorLayer.instanceAlphaOffset = 0.1;
    
    [replicatorLayer addSublayer:_imageView.layer];
    [self.view.layer addSublayer:replicatorLayer];
    _replicatorLayer = replicatorLayer;
}

- (void)animation
{
    _imageView.frame = CGRectMake(140, HEIGHT/2, 15, 15);
    _imageView.backgroundColor = [UIColor colorWithRed:0.463 green:0.337 blue:0.439 alpha:1.000];
    /** 圆角*/
    _imageView.layer.cornerRadius = 7.5;
    /** 是指视图上的子视图,如果超出父视图的部分就截取掉*/
    _imageView.layer.masksToBounds = YES;
    /** SX轴缩放，代表一个缩放比例，一般都是 0 --- 1 之间的数字。
     SY轴缩放。
     SZ整体比例变换时，也就是m11（sx）== m22（sy）时，若m33（sz）>1，图形整体缩小，若0<1，图形整体放大，若m33（sz）<0，发生关于原点的对称等比变换。*/
    _imageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    CGFloat count = 10.0;
    /** 复制子层动画延迟时长*/
    _replicatorLayer.instanceDelay = 1.0 / count;
    /** 子层总数(包括原生子层)*/
    _replicatorLayer.instanceCount = count;
    /** 复制子层形变(不包括原生子层)，每个复制子层都是相对上一个*/
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation((M_PI * 2) / count, 0, 0, 1.0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    /** 持续时间*/
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    //    animation.autoreverses = YES;
    //从原大小变小时,动画 回到原状时不要动画
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [_imageView.layer addAnimation:animation forKey:nil];
}

@end
