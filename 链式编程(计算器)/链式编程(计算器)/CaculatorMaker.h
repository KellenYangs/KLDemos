//
//  CaculatorMaker.h
//  链式编程(计算器)
//
//  Created by bcmac3 on 16/4/8.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

/** 结果 */
@property (nonatomic, assign) NSInteger result;

- (CaculatorMaker *(^)(NSInteger number))add;


@end
