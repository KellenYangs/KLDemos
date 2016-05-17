//
//  GCDGroup.m
//  GCD
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "GCDGroup.h"

@interface GCDGroup ()
@property (nonatomic, strong, readwrite) dispatch_group_t dispatchGroup;
@end

@implementation GCDGroup

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

#pragma mark -- 加入调度组
- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}
#pragma mark -- 与enter对应，离开调度组！判断group执行完成
- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

@end
