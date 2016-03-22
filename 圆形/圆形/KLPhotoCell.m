//
//  KLPhotoCell.m
//  圆形
//
//  Created by bcmac3 on 16/3/22.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPhotoCell.h"

@interface KLPhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation KLPhotoCell

- (void)setPhotoName:(NSString *)photoName {
    _photoName = [photoName copy];
    self.photoImageView.image = [UIImage imageNamed:photoName];
}

- (void)awakeFromNib {
    self.photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoImageView.layer.borderWidth = 10;
}

@end
