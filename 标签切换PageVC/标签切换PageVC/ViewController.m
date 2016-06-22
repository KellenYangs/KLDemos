//
//  ViewController.m
//  标签切换PageVC
//
//  Created by bcmac3 on 16/6/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "TagViewController.h"

@interface ViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSMutableArray *vcArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Page VC";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self.view addSubview:_pageVC.view];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    _vcArray = [NSMutableArray array];
    NSArray *titles = @[@"标签1",@"标签2",@"标签3",@"标签4"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *b = [UIButton buttonWithType:(UIButtonTypeCustom)];
        b.backgroundColor = [UIColor whiteColor];
        b.frame = CGRectMake(5+80*i, 2, 70, 26);
        [b setTitle:titles[i] forState:(UIControlStateNormal)];
        [view addSubview:b];
        b.tag = 100 + i;
        [b addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        TagViewController *tvc = [[TagViewController alloc]init];
        tvc.page = i;
        tvc.view.frame = CGRectMake(0, 64+30, self.view.bounds.size.width, self.view.bounds.size.height-64-30);
        [_vcArray addObject:tvc];
    }
    
    [_pageVC setViewControllers:@[_vcArray[0]] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
}

- (void)click:(UIButton *)btn {
    NSInteger currentPage = [_pageVC.viewControllers[0] page];
    NSInteger tagIndex = btn.tag - 100;
    if (tagIndex < currentPage) {
        [_pageVC setViewControllers:@[_vcArray[tagIndex]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:nil];
    }else {
        [_pageVC setViewControllers:@[_vcArray[tagIndex]] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:nil];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    TagViewController *vc = (TagViewController *)viewController;
    NSInteger index = vc.page;
    index++;
    if (index >= _vcArray.count) {
        return nil;
    }
    return _vcArray[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    TagViewController *vc = (TagViewController *)viewController;
    NSInteger index = vc.page;
    index--;
    if (index < 0) {
        return nil;
    }
    return _vcArray[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
