//
//  KLPluginTest.h
//  KLPluginTest
//
//  Created by bcmac3 on 16/6/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface KLPluginTest : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end