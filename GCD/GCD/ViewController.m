//
//  ViewController.m
//  GCD
//
//  Created by bcmac3 on 16/5/16.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "GCD.h"

@interface ViewController ()
/** <#注释#> */
@property (nonatomic, strong) GCDTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [GCDQueue executeInGlobalQueue:^{
        
        // download task, etc
        
        [GCDQueue executeInMainQueue:^{
            
            // update UI
        }];
    }];
    
    
    
    
    // init group
    GCDGroup *group = [GCDGroup new];
    
    // add to group
    [[GCDQueue globalQueue] execute:^{
        
        // task one
        
    } inGroup:group];
    
    // add to group
    [[GCDQueue globalQueue] execute:^{
        
        // task two
        
    } inGroup:group];
    
    // notify in mainQueue
    [[GCDQueue mainQueue] notify:^{
        
        // task three
        
    } inGroup:group];
    
    
    
    
    // init timer
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    
    // timer event
    [self.timer event:^{
        
        // task
        
    } timeInterval:NSEC_PER_SEC * 3 delay:NSEC_PER_SEC * 3];
    
    // start timer
    [self.timer start];
    
    
    
    
    // init semaphore
    GCDSemaphore *semaphore = [GCDSemaphore new];
    
    // wait
    [GCDQueue executeInGlobalQueue:^{
        
        [semaphore wait];
        
        // todo sth else
    }];
    
    // signal
    [GCDQueue executeInGlobalQueue:^{
        
        // do sth
        [semaphore signal];
    }];
}

- (void)sample {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       dispatch_async(dispatch_get_main_queue(), ^{
           
       });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
