//
//  KLPlaySoundViewController.m
//  音频
//
//  Created by bcmac3 on 16/3/24.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "KLPlaySoundViewController.h"
#import "KLAudioTool.h"

@interface KLPlaySoundViewController ()

@end

@implementation KLPlaySoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [KLAudioTool playSoundWithSoundname:@"buyao.wav"];
    
}

@end
