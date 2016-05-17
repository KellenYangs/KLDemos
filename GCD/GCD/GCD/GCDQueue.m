//
//  GCDQueue.m
//  GCD
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "GCDQueue.h"
#import "GCDGroup.h"

static GCDQueue *mainQueue;
static GCDQueue *globalQueue;
static GCDQueue *highPriorityGlobalQueue;
static GCDQueue *lowPriorityGlobalQueue;
static GCDQueue *backgroundPriorityGlobalQueue;

@interface GCDQueue ()
@property (strong, readwrite, nonatomic) dispatch_queue_t dispatchQueue;
@end

@implementation GCDQueue

+ (GCDQueue *)mainQueue {
    return mainQueue;
}

+ (GCDQueue *)globalQueue {
    return globalQueue;
}

+ (GCDQueue *)highPriorityGlobalQueue {
    return highPriorityGlobalQueue;
}

+ (GCDQueue *)lowPriorityGlobalQueue {
    return lowPriorityGlobalQueue;
}

+ (GCDQueue *)backgroundPriorityGlobalQueue {
    return backgroundPriorityGlobalQueue;
}

+ (void)initialize {
    if (self == [GCDQueue self])  {
        mainQueue                     = [GCDQueue new];
        globalQueue                   = [GCDQueue new];
        highPriorityGlobalQueue       = [GCDQueue new];
        lowPriorityGlobalQueue        = [GCDQueue new];
        backgroundPriorityGlobalQueue = [GCDQueue new];
        
        mainQueue.dispatchQueue                     = dispatch_get_main_queue();
        globalQueue.dispatchQueue                   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        highPriorityGlobalQueue.dispatchQueue       = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        lowPriorityGlobalQueue.dispatchQueue        = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        backgroundPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

#pragma mark - 初始化
#pragma mark -- 串行
- (instancetype)init {
    return [self initSerial];
}

- (instancetype)initSerial {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initSerialWithLabel:(NSString *)label {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark -- 并行
- (instancetype)initConcurrent {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

- (instancetype)initConcurrentWithLabel:(NSString *)label {
    if (self = [super init]) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark - 执行方法
#pragma mark -- 异步执行
- (void)execute:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(self.dispatchQueue, block);
}

#pragma mark -- 延时执行
- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), self.dispatchQueue, block);
}

- (void)execute:(dispatch_block_t)block afterDelaySecs:(float)delta {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta * NSEC_PER_SEC), self.dispatchQueue, block);
}

#pragma mark -- 同步执行，等待执行
- (void)waitExecute:(dispatch_block_t)block {
    /// 作为一个建议,这个方法尽量在当前线程池中调用.
    NSParameterAssert(block);
    dispatch_sync(self.dispatchQueue, block);
}

#pragma mark -- 在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
- (void)barrierExecute:(dispatch_block_t)block {
    /*
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的async操作
     */
    NSParameterAssert(block);
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)waitBarrierExecute:(dispatch_block_t)block {
    /*
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的sync操作
     
     作为一个建议,这个方法尽量在当前线程池中调用.
     */
    NSParameterAssert(block);
    dispatch_barrier_sync(self.dispatchQueue, block);
}

#pragma mark -- 暂停
- (void)suspend {
    dispatch_suspend(self.dispatchQueue);
}

#pragma mark -- 继续
- (void)resume {
    dispatch_resume(self.dispatchQueue);
}

#pragma mark - Group
#pragma mark -- 添加到Group
- (void)execute:(dispatch_block_t)block inGroup:(GCDGroup *)group {
    NSParameterAssert(block);
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

#pragma mark -- 监测Group里面的线程执行完才执行
- (void)notify:(dispatch_block_t)block inGroup:(GCDGroup *)group {
    NSParameterAssert(block);
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}

#pragma mark - 便利的构造方法
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), backgroundPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInMainQueue:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(mainQueue.dispatchQueue, block);
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(globalQueue.dispatchQueue, block);
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(highPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(lowPriorityGlobalQueue.dispatchQueue, block);
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(backgroundPriorityGlobalQueue.dispatchQueue, block);
}

@end
