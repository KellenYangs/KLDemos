//
//  KLPropertyType.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPropertyType.h"
#import "KLExtensionConst.h"
#import "KLFoundation.h"

@implementation KLPropertyType

static NSMutableDictionary *types_;
+ (void)load {
    types_ = [NSMutableDictionary dictionary];
}

+ (instancetype)cachedTypeWithCode:(NSString *)code {
    KLExtensionAssertParamNotNil2(code, nil);
    
    KLPropertyType *type = types_[code];
    if (type == nil) {
        type = [[self alloc] init];
        type.code = code;
        types_[code] = type;
    }
    return type;
}

#pragma mark - 公共方法
- (void)setCode:(NSString *)code {
    _code = code;
    
    KLExtensionAssertParamNotNil(code);
    NSLog(@"code = %@", code);
    if ([code isEqualToString:KLPropertyTypeId]) {
        _idType = YES;
    } else if (code.length == 0) {
        _KVCDisabled = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [KLFoundation isClassFromFoundation:_typeClass];
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
    } else if ([code isEqualToString:KLPropertyTypeSEL] ||
               [code isEqualToString:KLPropertyTypeIvar] ||
               [code isEqualToString:KLPropertyTypeMethod]) {
        _KVCDisabled = YES;
    }
    
    // 是否为数字类型
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[KLPropertyTypeInt, KLPropertyTypeShort, KLPropertyTypeBOOL1, KLPropertyTypeBOOL2, KLPropertyTypeFloat, KLPropertyTypeDouble, KLPropertyTypeLong, KLPropertyTypeLongLong, KLPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        if ([lowerCode isEqualToString:KLPropertyTypeBOOL1]
            || [lowerCode isEqualToString:KLPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}

@end
