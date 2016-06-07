//
//  KLPropertyKey.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPropertyKey.h"

@implementation KLPropertyKey

- (id)valueInObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]] && self.type == KLPropertyKeyTypeDictionary) {
        return object[self.name];
    } else if ([object isKindOfClass:[NSArray class]] && self.type == KLPropertyKeyTypeArray) {
        NSArray *array = object;
        NSUInteger index = self.name.intValue;
        if (index < array.count) return array[index];
        return nil;
    }
    return nil;
}

@end
