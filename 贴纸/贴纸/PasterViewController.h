//
//  PasterViewController.h
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasterViewControllerDelegate <NSObject>

- (void)pasterAddFinished:(UIImage *)finishedImage;

@end

@interface PasterViewController : UIViewController

/** 操作的图片 */
@property (nonatomic, strong) UIImage *backdropImage;
/** 代理 */
@property (nonatomic, weak) id <PasterViewControllerDelegate> delegate;

@end
