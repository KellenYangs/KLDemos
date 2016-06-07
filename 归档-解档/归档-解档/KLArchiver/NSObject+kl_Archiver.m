//
//  NSObject+kl_Archiver.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "NSObject+kl_Archiver.h"
#import "NSObject+kl_Properties.h"
#import <objc/runtime.h>

@interface NSObject ()
@property(nonatomic, copy)NSString * kl_Archiver_Name;
@end

static NSString * KL_Archiver_Name_Key = @"KL_Archiver_Name_Key";

@implementation NSObject (kl_Archiver)

- (void)setKl_Archiver_Name:(NSString *)kl_Archiver_Name {
    objc_setAssociatedObject(self, &KL_Archiver_Name_Key, kl_Archiver_Name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)kl_Archiver_Name {
    return objc_getAssociatedObject(self, &KL_Archiver_Name_Key);;
}

- (BOOL)kl_archiveToName:(NSString *)name {
    return [self archiveToName:name andIsSon:NO];
}

+ (id)kl_unArchiveToName:(NSString *)name {
    return [self unArchiveToName:name isSon:NO];
}

+ (id)kl_unArchiveSonEntityToName:(NSString *)name {
    return [self unArchiveToName:name isSon:YES];
}

#pragma mark -- private
+ (id)unArchiveToName:(NSString *)name isSon:(BOOL)isSon {
    self.kl_Archiver_Name = name;
    if (isSon == NO) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getPath:name]];
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] getSonPath:name]];
    }
}

- (BOOL)archiveToName:(NSString *)name andIsSon:(BOOL)isSon {
    if (isSon == NO) {
        //不是对象中的子对象
        self.kl_Archiver_Name = name;
        NSString * path = [[self class] getPath:name];
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"KLArchiver"] withIntermediateDirectories:YES attributes:nil error:nil];
        } else {
            //已有文件夹
        }
        return [NSKeyedArchiver archiveRootObject:self toFile:path];
        
    } else {
        return [NSKeyedArchiver archiveRootObject:self toFile:[[self class]getSonPath:name]];
    }

}

+ (NSString *)getSonPath:(NSString *)name {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"KLArchiver/KL_%@.archiver",name]];
    NSLog(@"super - %@",path);
    return path;
}

+ (NSString *)getPath:(NSString *)name{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"KLArchiver/KL_%@_%@.archiver",NSStringFromClass(self.class),name]];
    NSLog(@"son -  %@",path);
    return path;
}

#pragma mark -- NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"%s", __func__);
    NSArray * propertyArr = [self kl_allProperty];
    for (NSDictionary * propertyDic in propertyArr) {
        [self encodeWithType:propertyDic[@"type"] Name:propertyDic[@"name"] Coder:aCoder];
    }
}

- (id)decodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aDecoder {
    NSLog(@"%s", __func__);
    if ([self isObject:type]) {
        return [aDecoder decodeObjectOfClass:NSClassFromString(type) forKey:name];
    } else if([type isEqualToString:@"int"] || [type isEqualToString:@"short"]) {
        return @([aDecoder decodeIntegerForKey:name]);
    } else if([type isEqualToString:@"BOOL"]) {
        return @([aDecoder decodeBoolForKey:name]);
    } else if([type isEqualToString:@"float"]) {
        return @([aDecoder decodeFloatForKey:name]);
    } else if([type isEqualToString:@"double"]) {
        return @([aDecoder decodeDoubleForKey:name]);
    } else if([type isEqualToString:@"NSInteger"] || [type isEqualToString:@"NSUInteger"]) {
        return @([aDecoder decodeIntegerForKey:name]);
    }
    
    if ([type hasPrefix:@"__Model__:"]) {
        //        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        //        ;
        //        NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //        NSString * path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"WZXArchiver/WZX_%@_%@_%@.archiver",NSStringFromClass(self.class),self.WZX_Archiver_Name,className]];
        //
        //        [self setValue:[NSClassFromString(className) wzx_unArchiveToName:path isSon:YES]forKey:name];
    }
    return nil;
}

- (void)encodeWithType:(NSString *)type Name:(NSString *)name Coder:(NSCoder *)aCoder {
    NSLog(@"%s", __func__);
    if ([self isObject:type]) {
        [aCoder encodeObject:[self valueForKey:name] forKey:name];
    } else if([type isEqualToString:@"BOOL"]) {
        [aCoder encodeBool:[[self valueForKey:name] boolValue] forKey:name];
    } else if([type isEqualToString:@"float"]) {
        [aCoder encodeFloat:[[self valueForKey:name] floatValue] forKey:name];
    } else if([type isEqualToString:@"double"]) {
        [aCoder encodeFloat:[[self valueForKey:name] doubleValue] forKey:name];
    } else if([type isEqualToString:@"int"] || [type isEqualToString:@"short"]) {
        [aCoder encodeInt:[[self valueForKey:name] intValue] forKey:name];
    } else if([type isEqualToString:@"NSInteger"] || [type isEqualToString:@"NSUInteger"]) {
        [aCoder encodeInteger:[[self valueForKey:name] integerValue] forKey:name];
    }
    
    if ([type hasPrefix:@"__Model__:"]) {
        NSString * className = [type componentsSeparatedByString:@"__Model__:"][1];
        NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",NSStringFromClass(self.class),self.kl_Archiver_Name,className,name];
        
        [[self valueForKey:name] archiveToName:path andIsSon:YES];
    }
}

- (BOOL)isObject:(NSString *)type {
    NSArray * objectTypeArr = @[@"NSString",
                                @"NSMutableString",
                                @"NSArray",
                                @"NSMutableArray",
                                @"NSDictionary",
                                @"NSMutableDictionary",
                                @"NSData",
                                @"NSMutableData",
                                @"NSSet",
                                @"NSMutableSet"];
    return [objectTypeArr containsObject:type];
}

@end























