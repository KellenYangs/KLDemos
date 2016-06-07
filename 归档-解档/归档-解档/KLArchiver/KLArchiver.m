//
//  KLArchiver.m
//  归档-解档
//
//  Created by bcmac3 on 16/5/25.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLArchiver.h"

@implementation KLArchiver

+ (void)clearAll {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager changeCurrentDirectoryPath:docPath];
    NSError * error = nil;
    [fileManager removeItemAtPath:@"WZXArchiver" error:&error];
    NSAssert(error == nil, @"删除出错");
}

+ (void)clear:(NSString *)className {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager changeCurrentDirectoryPath:[[self class] getRootPath]];
    
    NSError * error = nil;
    NSArray * fileLists = [fileManager contentsOfDirectoryAtPath:fileManager.currentDirectoryPath error:&error];
    NSAssert(error == nil, @"查询出错");
    
    for (NSString * fileName in fileLists) {
        if ([fileName hasPrefix:[NSString stringWithFormat:@"WZX_%@",className]]) {
            NSError * removeError = nil;
            [fileManager removeItemAtPath:fileName error:&removeError];
            NSAssert(removeError == nil, @"删除出错");
        }
    }
}

+ (void)clear:(NSString *)className andName:(NSString *)name {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager changeCurrentDirectoryPath:[[self class]getRootPath]];
    NSError * error = nil;
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"WZX_%@_%@.archiver",className,name] error:&error];
    NSAssert(error == nil, @"删除出错");
    
}



+ (NSString *)getRootPath {
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"WZXArchiver"];
    return path;
}

@end
