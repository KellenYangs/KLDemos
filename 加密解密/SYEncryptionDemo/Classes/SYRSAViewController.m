//
//  SYRSAViewController.m
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import "SYRSAViewController.h"
#import "SYRSA.h"

@interface SYRSAViewController ()

@end

@implementation SYRSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ecrypt {
    self.plainTextView.text = [SYRSA encryptString:self.codeNumberTF.text publicKey:self.randomKeyLabel.text];
}

- (void)decrypt {
    self.cipherTextView.text = [SYRSA decryptString:self.codeNumberTF.text publicKey:self.randomKeyLabel.text];
}

@end
