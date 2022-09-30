//
//  LoginVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "LoginVC.h"
#import "EDWebUserConnect.h"
#import "EDWebUserSignInRequest.h"
#import "EDWebUserLoginResponse.h"
#import "LoginView.h"
#import "BaseHeader.h"
#import "RegisterVC.h"
#import "EDUserStore.h"

@interface LoginVC ()

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self hideNavigationBar];
    [self showDefaultStatusBarContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self showNavigationBar];
    [self showLigthStatusBarContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];

}

- (void)initData {
    
}

- (void)initViews {
    
    [self initLoginView];
}

- (void)initLoginView {
    
    weakSelf(self);
    
    self.loginView = [[LoginView alloc] initWithDefaultFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight)];
    
    self.loginView.loginBlocked = ^(NSString * _Nonnull name, NSString * _Nonnull pwd) {
        
        EDWebUserSignInRequest *request = [[EDWebUserSignInRequest alloc] init];
        request.userName = name;
        request.password = pwd;
        
        [weakself beginCicleProgressWithBg];
        [EDWebUserConnect signIn:request withFinished:^(id  _Nonnull response) {
        
            [weakself endProgress];
            EDWebUserLoginResponse *loginRes = (EDWebUserLoginResponse *)response;
            
            if (loginRes.isSuccess) {
                
                EDUserInfo *userInfo = loginRes.userInfo;
                [EDUserStore reset:userInfo];
                [weakself dismissViewControllerAnimated:YES completion:nil];
            } else {
                loginRes.msg = loginRes.msg;
            }
            
            [RKDropdownAlert title:loginRes.msg time:2];
        }];
    };
    
    self.loginView.registerBlocked = ^{
        
        RegisterVC *registerVC = [[RegisterVC alloc] init];
        [weakself presentViewController:registerVC animated:YES completion:nil];
    };
    
    [self.view addSubview:self.loginView];
}

@end
