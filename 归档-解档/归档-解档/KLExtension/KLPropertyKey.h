//
//  KLPropertyKey.h
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KLPropertyKeyType) {
    KLPropertyKeyTypeDictionary = 0,    // 字典的key
    KLPropertyKeyTypeArray              // 数组的key(下标)
};

/**
 *  属性的key
 */
@interface KLPropertyKey : NSObject
/** key的名字 */
@property (copy,   nonatomic) NSString *name;
/** key的种类，可能是@"10"，可能是@"age" */
@property (assign, nonatomic) KLPropertyKeyType type;

/**
 *  根据当前的key，也就是name，从object（字典或者数组）中取值
 */
- (id)valueInObject:(id)object;
@end
