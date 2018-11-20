//
//  ViewController.m
//  GCD理解1
//
//  Created by bcmac3 on 16/7/28.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.concurrentQueue = dispatch_queue_create("kl.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    self.serialQueue = dispatch_queue_create("kl.serialQueue", DISPATCH_QUEUE_SERIAL);
    
    
//    [self globalQueue];
    
//    [self customSerialQueueAsyncTest];
//    [self customSerialQueueSyncTest];
//    [self customConcurrentQueueAsyncTest];
//    [self customConcurrentQueueSyncTest];
    
//    [self barruerSyncTest];
    
//    [self semaphoneTest];
    
//    [self groupTest];
    [self groupTest2];
    
}

- (void)groupTest2 {
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 3; i++) {
        dispatch_group_enter(group);
        dispatch_async(self.concurrentQueue, ^{
            NSLog(@"进入第%zd个异步 sleep 3秒", i);
            sleep(3);
            NSLog(@"离开第%zd个异步 sleep 完成", i);
            dispatch_group_leave(group);
        });
    }
    // 1 -----
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"网络下载任务全部完成，请刷新UI");
    });
//    // 2 ------
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"组内任务全部完成，请检验...");
//    });
    
}

- (void)groupTest {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, self.concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"1 %@ %zd", [NSThread currentThread], i);
        }
    });
    NSLog(@"haha 1111");
    dispatch_group_async(group, self.serialQueue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"2 %@ %zd", [NSThread currentThread], i);
        }
    });
    NSLog(@"haha 2222");
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 任务全部完成处理
        NSLog(@"组内任务全部完成，请检验...");
    });
    
}


/**
 *  信号量Test
 */
- (void)semaphoneTest {
    dispatch_semaphore_t semaphone = dispatch_semaphore_create(0);
    
//    for (int i = 0; i < 10; i++) {
//        if(dispatch_semaphore_wait(semaphone, dispatch_time(DISPATCH_TIME_NOW, 2 *NSEC_PER_SEC)) == 0) {
//            dispatch_async(self.concurrentQueue, ^{
//                NSLog(@"i will sleep 3 second %zd", i);
//                sleep(3);
//                NSLog(@"i am wake up %zd", i);
//                
//                NSLog(@"%zd signal %ld",i,  dispatch_semaphore_signal(semaphone));
//                
//            });
//
//        }else{
//            NSLog(@"等不下去了，走人");
//        }
//    }
    
    
    NSLog(@"Boss: Kellen, wake up! working");
    dispatch_async(self.concurrentQueue, ^{
        NSLog(@"Kellen: sleep... Zzz!");
        sleep(5);
        NSLog(@"Kellen: wake up!");
        dispatch_semaphore_signal(semaphone);
    });
    
    dispatch_semaphore_wait(semaphone, DISPATCH_TIME_FOREVER);
    NSLog(@"Kellen: I am working...");

    
    
//    dispatch_semaphore_signal(semaphone);
//    dispatch_semaphore_wait(semaphone, dispatch_time(DISPATCH_TIME_NOW, 5));
}

- (void)barruerSyncTest {
    for (int i = 0; i < 3; i++) {
        dispatch_async(self.concurrentQueue, ^{
            NSLog(@"current Thread %@ --  dispatch_async_1 %zd",[NSThread currentThread], i);
        });
    }
    NSLog(@"dispatch_async_1_main");
    for (int i = 0; i < 100; i++) {
        dispatch_barrier_async(self.concurrentQueue, ^{
            NSLog(@"current Thread %@ --  dispatch_barrier_sync %zd",[NSThread currentThread], i);
            if (i == 99) {
                NSLog(@"dispatch_barrier_sync finished");
            }
        });
    }
    NSLog(@"dispatch_barrier_sync_main");
    for (int i = 0; i < 3; i++) {
        dispatch_async(self.concurrentQueue, ^{
            NSLog(@"current Thread %@ --  dispatch_async_2 %zd",[NSThread currentThread], i);
        });
    }
    NSLog(@"dispatch_async_2_main");
}


/**
 *  并行队列同步运行
 */
- (void)customConcurrentQueueSyncTest {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("kl.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    for (int j = 0; j < 3; j++) {
        dispatch_sync(concurrentQueue, ^{
            for (int i = 0 ; i < 3; i++) {
                NSLog(@"current Thread %@ --  concurrentQueue %zd --  dispatch_async %zd",[NSThread currentThread] ,j, i);
            }
        });
        
        NSLog(@"run in mainQueue current Thread %@", [NSThread currentThread]);
    }
}

/**
 *  并行队列异步运行
 */
- (void)customConcurrentQueueAsyncTest {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("kl.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    for (int j = 0; j < 3; j++) {
        dispatch_async(concurrentQueue, ^{
            for (int i = 0 ; i < 3; i++) {
                NSLog(@"current Thread %@ --  concurrentQueue %zd --  dispatch_async %zd",[NSThread currentThread] ,j, i);
            }
        });
        
        NSLog(@"run in mainQueue current Thread %@", [NSThread currentThread]);
    }
}

/**
 *  串行队列同步运行
 */
- (void)customSerialQueueSyncTest {
    dispatch_queue_t serialQueue = dispatch_queue_create("kl.serialQueue", DISPATCH_QUEUE_SERIAL);
    for (int j = 0; j < 3; j++) {
        dispatch_sync(serialQueue, ^{
            for (int i = 0 ; i < 3; i++) {
                NSLog(@"current Thread %@ --  concurrentQueue %zd --  dispatch_async %zd",[NSThread currentThread] ,j, i);
            }
        });
        
        NSLog(@"run in mainQueue current Thread %@", [NSThread currentThread]);
        
    }
}

/**
 *  串行队列异步运行
 */
- (void)customSerialQueueAsyncTest {
    dispatch_queue_t serialQueue = dispatch_queue_create("kl.serialQueue", DISPATCH_QUEUE_SERIAL);
    for (int j = 0; j < 3; j++) {
        dispatch_async(serialQueue, ^{
            for (int i = 0 ; i < 3; i++) {
                NSLog(@"current Thread %@ --  concurrentQueue %zd --  dispatch_async %zd",[NSThread currentThread] ,j, i);
            }
        });
        NSLog(@"run in mainQueue current Thread %@", [NSThread currentThread]);
    }
}


- (void)globalQueue {
    NSLog(@"哈哈111");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 100000; i++) {
            NSLog(@"%zd", i);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"刷新UI");
        });
    });
    NSLog(@"哈哈222");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
