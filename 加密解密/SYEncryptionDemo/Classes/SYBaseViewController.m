//
//  SYBaseViewController.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYBaseViewController.h"

@interface SYBaseViewController ()


@end

@implementation SYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.randomKeyLabel.text = [self shuffledAlphabet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)plainTextButtonClick:(UIButton *)sender {
    [self ecrypt];
}
- (IBAction)cipherTextButtonClick:(UIButton *)sender {
    [self decrypt];
}

- (void)ecrypt {

}

- (void)decrypt {

}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    self.randomKeyLabel.text = [self shuffledAlphabet];
}

//生成八位随机字符串
- (NSString *)shuffledAlphabet {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@+-";

    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];

    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }

    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:8];
    free(characters);
    return result;
}

@end
