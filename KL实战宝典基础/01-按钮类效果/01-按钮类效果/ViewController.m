//
//  ViewController.m
//  01-按钮类效果
//
//  Created by bcmac3 on 16/6/1.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"
#import "WebButton.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *highlightButton;
@property (weak, nonatomic) IBOutlet WebButton *webButton;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  按钮发光
     */
    _highlightButton.showsTouchWhenHighlighted = YES;
    
    _webButton.lineColor = [UIColor redColor];
    
}

- (IBAction)openWeb:(WebButton *)sender {
    NSString *url = [NSString stringWithFormat:@"http://%@", _webButton.titleLabel.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}


- (IBAction)highlight:(UIButton *)sender {
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
