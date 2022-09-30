//
//  EditCarIdVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EditCarIdVC.h"
#import "BaseHeader.h"
#import "EDWebUserConnect.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"

@interface EditCarIdVC () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UITextField *carIdField;
@property (nonatomic, strong) Button *submitBtn;

@end

@implementation EditCarIdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)initData {
    
}

- (void)initViews {
    
    [self setNavTitle:@"修改车牌号"];
    [self initNavLeftBtn];
    [self initCarIdView];
    [self initSubmitView];
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

- (void)initCarIdView {
    
    self.carIdField = [[UITextField alloc] init];
    self.carIdField.borderStyle = UITextBorderStyleRoundedRect;
    self.carIdField.placeholder = @"请输入昵称";
    self.carIdField.text = self.carId;
    self.carIdField.font = [UIFont systemFontOfSize:fontSmall];
    self.carIdField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.carIdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.carIdField.keyboardType = UIKeyboardTypeDefault;
    self.carIdField.returnKeyType = UIReturnKeyNext;
    self.carIdField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.carIdField.delegate = self;
    [self.view addSubview:self.carIdField];
    
    [self.carIdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iUnitPoint10 * 8 + iScreenNavigationHeight);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
}


- (void)initSubmitView {
    
    self.submitBtn = [[Button alloc] init];
    
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.submitBtn.title = @"修改";
    self.submitBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:fontMiddle];
    self.submitBtn.layer.cornerRadius = 3;
    [self.view addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.carIdField.mas_bottom).mas_offset(iUnitPoint10 * 4);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.width.mas_equalTo(iUnitPoint10 * 5);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.submitBtn addTarget:self action:@selector(editCarIdClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)editCarIdClick {
    
    [self.carIdField resignFirstResponder];
    
    if ([self.carIdField.text isEqualToString:self.carId]) {
        
        [RKDropdownAlert title:@"用户信息未变更" time:2];
        return ;
    }
    
    EDWebUserEditCarIdRequest *req = [[EDWebUserEditCarIdRequest alloc] init];
    req.carId = self.carIdField.text;
    req.userId = self.userId;
    
    [self beginCicleProgressWithBg];
    
    [EDWebUserConnect editCarId:req withFinished:^(id  _Nonnull response) {
        
        [self endProgress];
        
        EDWebBaseResponse *res = (EDWebBaseResponse *)response;
        
        if (res.isSuccess) {
            EDUserInfo *userInfo = [EDUserStore get];
            userInfo.carId = self.carIdField.text;
            [EDUserStore reset:userInfo];
            [RKDropdownAlert title:res.msg time:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [RKDropdownAlert title:res.msg time:2];
        }
    }];
}

@end
