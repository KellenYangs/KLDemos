//
//  GCDSemaphore.m
//  GCD
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "GCDSemaphore.h"

@interface GCDSemaphore ()
@property (strong, readwrite, nonatomic) dispatch_semaphore_t dispatchSemaphore;
@end

@implementation GCDSemaphore

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchSemaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (instancetype)initWithValue:(long)value {
    if (self = [super init]) {
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    return self;
}

- (BOOL)signal {
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait {
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta {
    return dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

@end
