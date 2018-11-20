//
//  SYBaseViewController.h
//  SYEncryptionDemo
//
//  Created by bcmac3 on 09/12/2016.
//  Copyright © 2016 ShenYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codeNumberTF;
@property (weak, nonatomic) IBOutlet UILabel *randomKeyLabel;
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;

- (void)ecrypt;

- (void)decrypt;
@end
