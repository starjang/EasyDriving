//
//  RegisterVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterView.h"
#import "BaseHeader.h"
#import "EDWebUserConnect.h"
#import "EDWebUserSignInResponse.h"

@interface RegisterVC ()

@property (nonatomic, strong) RegisterView *regsView;

@end

@implementation RegisterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self hideNavigationBar];
    [self showDefaultStatusBarContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self showNavigationBar];
//    [self showLigthStatusBarContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
    
}

- (void)initData {
    
}

- (void)initViews {
    
    [self initRegsView];
}

- (void)initRegsView {
    
    self.regsView = [[RegisterView alloc] initWithDefaultFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight)];
    
    weakSelf(self);
    self.regsView.loginBlocked = ^{
        [weakself dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.regsView.registerBlocked = ^(EDUserInfo *userInfo) {
        
        EDWebUserSignUpRequest *registerReqs = [[EDWebUserSignUpRequest alloc] init];
        registerReqs.userInfo = userInfo;
        
        [weakself beginCicleProgressWithBg];
        [EDWebUserConnect signUp:registerReqs withFinished:^(id  _Nonnull response) {
            
            EDWebUserSignInResponse *registerReps = (EDWebUserSignInResponse *)response;
            
            [weakself endProgress];
            
            [RKDropdownAlert title:registerReps.msg time:2];

            if (registerReps.isSuccess) {
                
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    };
    
    [self.view addSubview:self.regsView];
}

@end
