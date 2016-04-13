//
//  KLAudioTool.m
//  音频
//
//  Created by bcmac3 on 16/3/24.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation KLAudioTool
static NSMutableDictionary *_soundIDs;
+ (void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithSoundname:(NSString *)soundname
{
    // 1.定义SystemSoundID
    SystemSoundID soundID = 0;
    
    // 2.从字典中取出对应soundID,如果取出是nil,表示之前没有存放在字典
    soundID = [_soundIDs[soundname] unsignedIntValue];
    if (soundID == 0) {
        CFURLRef url = (__bridge CFURLRef)[[NSBundle mainBundle] URLForResource:soundname withExtension:nil];
        AudioServicesCreateSystemSoundID(url, &soundID);
        
        // 将soundID存入字典
        [_soundIDs setObject:@(soundID) forKey:soundname];
    }
    
    // 3.播放音效
    AudioServicesPlaySystemSound(soundID);
}


@end
