//
//  PasterViewController.m
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "PasterViewController.h"
#import "PasterCell.h"
#import "UIImage+kl_Add.h"
#import "KLPasterBackdropView.h"

static NSString *const PasterCellReuseabIdentity = @"pasterCell";

@interface PasterViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *pasterCollectionView;
@property (nonatomic, strong) NSMutableArray *pasters;
@property (nonatomic, strong) KLPasterBackdropView *backdropView;
@end

@implementation PasterViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{@"NSForegroundColorAttributeName" : [UIColor whiteColor], @"NSFontAttributeName" : [UIFont systemFontOfSize:17]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backdropView];
}

- (KLPasterBackdropView *)backdropView {
    if (!_backdropView) {
        _backdropView = [[KLPasterBackdropView alloc] initWithFrame:CGRectMake(10, 74, self.view.frame.size.width - 20, self.view.frame.size.height - 74 - 80)];
        _backdropView.originImage = self.backdropImage;
        _backdropView.backgroundColor = [UIColor grayColor];
        _backdropView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backdropView;
}

- (IBAction)save:(UIBarButtonItem *)sender {
    UIImage *imageResult = [self.backdropView doneEdit];
    [self.delegate pasterAddFinished:imageResult];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



#pragma mark -- Getter
- (NSMutableArray *)pasters {
    if (!_pasters) {
        _pasters = [NSMutableArray array];
        for (NSInteger index = 38; index <= 60; index++) {
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *str = [NSString stringWithFormat:@"mtsc2033%zd", index];
                [_pasters addObject:str];
            });
        }
    }
    return _pasters;
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pasters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PasterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PasterCellReuseabIdentity forIndexPath:indexPath];
    cell.imageName = self.pasters[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [UIImage imageNamed:self.pasters[indexPath.row]];
    [self.backdropView addPasterWithImg:image];
}

@end
