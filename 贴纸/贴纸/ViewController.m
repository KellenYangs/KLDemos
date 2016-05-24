//
//  ViewController.m
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "PasterViewController.h"

@interface ViewController () <PasterViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/**
 *  状态栏状态
 */
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

/**
 *  是否隐藏状态栏
 */
//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"paster"]) {
        NSLog(@"Go");
        PasterViewController *vc = segue.destinationViewController;
        vc.backdropImage = self.imageView.image;
        vc.delegate = self;
    }
}

- (void)pasterAddFinished:(UIImage *)finishedImage {
    self.imageView.image = finishedImage;
}






















@end
