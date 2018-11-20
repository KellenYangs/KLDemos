//
//  SYAESViewController.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYAESViewController.h"
#import "SYAES.h"

@interface SYAESViewController ()

@end

@implementation SYAESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)ecrypt {
    self.plainTextView.text = [SYAES encryptUseAES:self.codeNumberTF.text key:self.randomKeyLabel.text];
}

- (void)decrypt {
    self.cipherTextView.text = [SYAES decryptUseAES:self.plainTextView.text key:self.randomKeyLabel.text];
}


@end
