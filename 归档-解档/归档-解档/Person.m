//
//  Person.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"str : %@, mStr : %@, arr : %@, mArr : %@, dic : %@, mDic : %@, set : %@, mSet : %@, data : %@, mData : %@, p_integer : %zd, p_uinteger : %zd, p_cgfloat : %lf, p_bool : %@, p_int : %zd, p_doule : %f, p_float : %f, man : %@", self.str, self.mStr, self.arr, self.mArr, self.dic, self.mDic, self.set, self.mSet, self.data, self.mData, self.p_integer, self.p_uinteger, self.p_cgfloat, self.p_bool ? @"YES" : @"NO", self.p_int, self.p_doule, self.p_float, self.man];
}

@end
