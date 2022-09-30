//
//  BaseVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "BaseVC.h"
#import "BaseHeader.h"
#import "ColorToImage.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BaseVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) BaseProgressView *progressView;

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:e_bgcolor];
    
    self.navigationController
    .interactivePopGestureRecognizer
    .delegate = self;
    
    self.view.exclusiveTouch = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showLigthStatusBarContent];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setDefaultNavigationBarStyle];
    self.navigationController
    .interactivePopGestureRecognizer
    .delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


-(void)setNavTitle:(NSString *)title {
    
    self.navigationItem.title = title;
  self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName :[UIFont boldSystemFontOfSize:fontBig], NSForegroundColorAttributeName:[UIColor whiteColor], NSKernAttributeName : @(0.5f)};
}

-(void)showStatusBar{
    if ([UIApplication sharedApplication].statusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

-(void)hideStatusBar {
    if (![UIApplication sharedApplication].statusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
    }
}
-(void)showNavigationBar {
    
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    
}

-(void)hideNavigationBar {
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}


-(void)showTabBar{
    
    if (self.tabBarController.tabBar.isHidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
}

- (void)hideTabBar {
    if (!self.tabBarController.tabBar.isHidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)showLigthStatusBarContent {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)showDefaultStatusBarContent {
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    
}

- (void)openInteractivePopGesture {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES ;
    
}

- (void)closeInteractivePopGesture {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO ;
}

- (void)setDefaultNavigationBarStyle {

    [self.navigationController.navigationBar setBackgroundImage:[ColorToImage imageFromColor:[UIColor colorWithHexString:@"31304f"] size:CGSizeMake(iScreenWidth, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[ColorToImage imageFromColor:[UIColor colorWithHexString:@"31304f"] size:CGSizeMake(iScreenWidth, 1)]];
    
    [self showLigthStatusBarContent];
    
}

- (void)beginCircleProgress {
    
    self.progressView = [CircleProgressView beginProgress:self.view];
}

- (void)beginCicleProgressWithBg {
    
    self.progressView = [CircleProgressView beginProgress:self.view.window];
    self.progressView.progressBaseView.backgroundColor = [UIColor colorWithHexString:e_bgcolor];
    self.progressView.backgroundColor = [UIColor colorWithHexString:@"#000000" withAlpha:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:self.progressView];
    
}

- (void)endProgress {
    
    if(self.progressView)
    [self.progressView endProgress];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer )
    {
        if ( self.navigationController.visibleViewController == [self.navigationController.viewControllers objectAtIndex:0] )//让第一个子控制器侧滑时不产生作用
        {
            return NO;
        }
    }
    
    return YES;
}


@end
