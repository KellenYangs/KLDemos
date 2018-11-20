//
//  SYDESViewController.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYDESViewController.h"
#import "SYDES3.h"

@interface SYDESViewController ()

@end

@implementation SYDESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)ecrypt {
    self.plainTextView.text = [SYDES3 encryptUseDES:self.codeNumberTF.text key:self.randomKeyLabel.text];
}

- (void)decrypt {
    self.cipherTextView.text = [SYDES3 decryptUseDES:self.plainTextView.text key:self.randomKeyLabel.text];
}



@end
