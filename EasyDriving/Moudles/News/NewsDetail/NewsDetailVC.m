//
//  NewsDetailVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "NewsDetailVC.h"
#import <WebKit/WebKit.h>
#import "BaseHeader.h"

@interface NewsDetailVC ()<WKNavigationDelegate>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) WKWebView *browserWebView;

@property(nonatomic,strong) NSMutableURLRequest *urlRequest;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:self.title];
    [self showLigthStatusBarContent];
    [self initData];
    [self initViews];
    
}

- (void)initData {
    
}

- (void)initViews {
    
    [self initNavLeftBtn];
    [self initBrowserViews];
}

- (void)initNavLeftBtn {
    
    self.leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNavBtn.frame = CGRectMake(0, 0, iUnitPoint10 * 4, iUnitPoint10 * 4);
    [self.leftNavBtn setImage:[OnlineImage getIcon:@"ion-android-arrow-back" hexColor:e_textreversecolor size:30] forState:UIControlStateNormal];
    
    UIView *leftNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iScreenNavigationHeight, iScreenNavigationHeight)];
    [leftNavView addSubview:self.leftNavBtn];
    
    [self.leftNavBtn addTarget:self action:@selector(navPopViewClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNavView];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

- (void)navPopViewClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initBrowserViews {

    self.browserWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight)];
    self.browserWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.browserWebView];
    self.browserWebView.navigationDelegate = self;
    [self.browserWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    self.browserWebView.alpha = 0;
    [self beginCircleProgress];
}

#pragma mark 网络加载的协议
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

  
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
   
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    NSString *jsStr = @"var obj = document.getElementById(\"Jcrumb\");obj.style.display= \"none\";";
    [webView evaluateJavaScript:jsStr completionHandler:^(NSString *none, NSError * _Nullable error) {
        
        if (!error) {
            
            [UIView animateWithDuration:1.5 animations:^{
                [self endProgress];
                self.browserWebView.alpha = 1;
            }];
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

    [self endProgress];
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
}

@end
