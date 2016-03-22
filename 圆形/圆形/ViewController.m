//
//  ViewController.m
//  圆形
//
//  Created by bcmac3 on 16/3/22.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "KLLineLayout.h"
#import "KLPhotoCell.h"
#import "KLCircleLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;
@end

@implementation ViewController

static NSString * const KLPhotoId = @"photo";

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i<10; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%02zd.jpg", i + 1]];
        }
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    KLCircleLayout *layout = [[KLCircleLayout alloc] init];
    
    // 创建CollectionView
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KLPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:KLPhotoId];
    
    // 继承UICollectionViewLayout
    // 继承UICollectionViewFlowLayout
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[KLLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[KLCircleLayout alloc] init] animated:YES];
    } else {
        KLLineLayout *layout = [[KLLineLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLPhotoId forIndexPath:indexPath];
    
    cell.photoName = self.imageNames[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
