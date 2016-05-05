//
//  ViewController.m
//  JS与OC的使用
//
//  Created by bcmac3 on 16/5/5.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"]]];
}

#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    // 获取将要加载的URL
    NSString *url = request.URL.absoluteString;
    NSString *scheme = @"kl://";
    
    // 两个参数
    // kl://js3_two_?one=kellen&two=Yangs
    if ([url hasPrefix:scheme]) {
        // 获得协议后面的路径  path == js3_two_?one=kellen&two=Yangs
        NSString *path = [url substringFromIndex:scheme.length];
        // 利用?切割路径
        NSArray *subpaths = [path componentsSeparatedByString:@"?"];
        // 方法名 methodName == js3_two_
        NSString *methodName = [[subpaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        // 参数  one=kellen&two=Yangs
        NSString *param = [subpaths lastObject];
        NSArray *subparams = nil;
        if (subpaths.count == 2 || [param containsString:@"&"]) {
            subparams = [param componentsSeparatedByString:@"&"];
        }
        // 取出前面的2个参数
        NSString *firstParam = [subparams firstObject];
        NSString *secondParam = subparams.count <= 1 ? nil : [subparams lastObject];
        
        [self performSelector:NSSelectorFromString(methodName) withObject:firstParam withObject:secondParam];
        
        return NO;
    }
// 一个参数
//    if ([url hasPrefix:scheme]) {
//        // 获得协议后面的路径  path == js2?one=kellen
//        NSString *path = [url substringFromIndex:scheme.length];
//        // 利用?切割路径
//        NSArray *subpaths = [path componentsSeparatedByString:@"?"];
//        // 方法名 methodName == js2
//        NSString *methodName = [[subpaths firstObject] stringByAppendingString:@":"];
//        // 参数  kellen
//        NSString *param = [subpaths lastObject];
//        [self performSelector:NSSelectorFromString(methodName) withObject:param];
//        
//        return NO;
//    }
    
    // 无参数
//    if ([url hasPrefix:scheme]) {
//        [self js1];
//        return NO;
//    }
    
    NSLog(@"加载其他请求，不是调用OC的方法");
    return YES;
}

- (void)js1 {
    NSLog(@"调用成功");
}

- (void)js2:(NSString *)oneParam {
    NSLog(@"调用成功: %@", oneParam);
}

- (void)js3:(NSString *)oneParam two:(NSString *)twoParam {
    NSLog(@"调用成功: %@-%@", oneParam, twoParam);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 利用JS获得当前网页的标题
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
//    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.location.href;"]);
//    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"klevent();"]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}

@end
