//
//  GCDGroup.h
//  GCD
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

/** 队列组 */
@property (nonatomic, strong, readonly) dispatch_group_t dispatchGroup;

#pragma mark -- 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
