//
//  KLShopCell.m
//  瀑布流
//
//  Created by bcmac3 on 16/5/24.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLShopCell.h"
#import "KLShopModel.h"
#import "UIImageView+WebCache.h"

@interface KLShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImgv;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@end

@implementation KLShopCell

- (void)setShop:(KLShopModel *)shop {
    _shop = shop;
    
    // 1.图片
    if (shop.img) {
        [self.shopImgv sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    }
    
    // 2.价格
    self.shopPrice.text = shop.price;
}

@end
