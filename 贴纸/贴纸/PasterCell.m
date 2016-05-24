//
//  PasterCell.m
//  贴纸
//
//  Created by bcmac3 on 16/5/23.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "PasterCell.h"

@interface PasterCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pasterImageView;
@end

@implementation PasterCell

- (void)setImageName:(NSString *)imageName {
    if (!imageName) {
        return;
    }
    self.pasterImageView.image = [UIImage imageNamed:imageName];
}

@end
