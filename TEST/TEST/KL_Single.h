//
//  KL_Single.h
//  TEST
//
//  Created by bcmac3 on 16/5/13.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KL_Single : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *name;
/** <#注释#> */
@property (nonatomic, copy) NSString *age;

+ (instancetype)sharedSingle;

@end
