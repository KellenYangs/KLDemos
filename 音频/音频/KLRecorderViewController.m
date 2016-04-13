//
//  KLRecorderViewController.m
//  音频
//
//  Created by bcmac3 on 16/3/24.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLRecorderViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface KLRecorderViewController ()
/** 录音的对象 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 录音文件存储的文件路径 */
@property (nonatomic, strong) NSString *filePath;
/** 音效文件, 系统声音之类的小文件 */
@property (nonatomic, assign) SystemSoundID soundID;

@end

@implementation KLRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startRecord:(id)sender {
    // 开始录音
    [self.recorder record];
}

- (IBAction)stopRecord:(id)sender {
    // 停止录音
    [self.recorder stop];
    // 暂停
//    [self.recorder pause];
}

- (IBAction)playRecord:(id)sender {
    AudioServicesPlaySystemSound(self.soundID);
    // 带振动
//    AudioServicesPlayAlertSound(self.soundID);
}

- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        // 1. 创建存放录音文件的地址
        NSURL *url = [NSURL URLWithString:self.filePath];
        
        // 2. 创建录音对象
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:nil];
        
        // 3. 准备录音
        [self.recorder prepareToRecord];
    }
    return _recorder;
}

- (NSString *)filePath {
    if (!_filePath) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
        _filePath = [path stringByAppendingPathComponent:@"kellen.caf"];
    }
    return _filePath;
}

- (SystemSoundID)soundID {
    if (!_soundID) {
        // 根据音效文件,来生成SystemSoundID
        NSURL *url = [NSURL URLWithString:self.filePath];
        CFURLRef urlRef = (__bridge CFURLRef)url;
        AudioServicesCreateSystemSoundID(urlRef, &_soundID);
    }
    return _soundID;
}

@end
