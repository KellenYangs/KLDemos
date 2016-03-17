//
//  KLNavigationDelegate.m
//  KL_转场
//
//  Created by bcmac3 on 16/3/17.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLNavigationDelegate.h"
#import <UIKit/UIKit.h>
#import "KLTransitionAnimation.h"

@interface KLNavigationDelegate ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation KLNavigationDelegate


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [[KLTransitionAnimation alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:panGesture];
}

- (void)panned:(UIPanGestureRecognizer *)panGesture {
    switch (panGesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [self.navigationController.topViewController performSegueWithIdentifier:@"PushSegue" sender:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            CGPoint transition = [panGesture translationInView:self.navigationController.view];
            CGFloat completionProgress = transition.x / CGRectGetWidth(self.navigationController.view.bounds);
            [self.interactionController updateInteractiveTransition:completionProgress];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            if ([panGesture velocityInView:self.navigationController.view].x > 0) {
                NSLog(@"----=====%f",[panGesture velocityInView:self.navigationController.view].x);
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            
            break;
        }
        default:
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
            break;
    }
}


@end
