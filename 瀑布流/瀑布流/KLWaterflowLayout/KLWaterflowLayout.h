//
//  KLWaterflowLayout.h
//  瀑布流
//
//  Created by bcmac3 on 16/5/24.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLWaterflowLayout;

@protocol KLWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(KLWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(KLWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(KLWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(KLWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(KLWaterflowLayout *)waterflowLayout;

@end

@interface KLWaterflowLayout : UICollectionViewLayout
@property (nonatomic, weak) id<KLWaterflowLayoutDelegate> delegate;
@end
