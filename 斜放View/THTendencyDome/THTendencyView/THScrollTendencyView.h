//
//  THScrollTendencyView.h
//  Mark_test
//
//  Created by 童浩 on 2018/8/15.
//  Copyright © 2018年 slb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THTendencyView.h"
@interface THScrollTendencyView : UIView
@property(nonatomic,strong) NSArray *imageS;
@property (nonatomic,copy) void(^didBlock) (NSInteger index);
@end
