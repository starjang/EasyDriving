//
//  EditNicknameVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EditNicknameVC.h"
#import "BaseHeader.h"
#import "EDWebUserConnect.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"

@interface EditNicknameVC () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) Button *submitBtn;


@end

@implementation EditNicknameVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)initData {
    
}

- (void)initViews {
    
    [self setNavTitle:@"修改昵称"];
    [self initNavLeftBtn];
    [self initNameView];
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

- (void)initNameView {
    
    self.nameField = [[UITextField alloc] init];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"请输入昵称";
    self.nameField.text = self.nickname;
    self.nameField.font = [UIFont systemFontOfSize:fontSmall];
    self.nameField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.keyboardType = UIKeyboardTypeDefault;
    self.nameField.returnKeyType = UIReturnKeyNext;
    self.nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameField.delegate = self;
    [self.view addSubview:self.nameField];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        make.top.mas_equalTo(self.nameField.mas_bottom).mas_offset(iUnitPoint10 * 4);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.width.mas_equalTo(iUnitPoint10 * 5);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.submitBtn addTarget:self action:@selector(editNameClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)editNameClick {
    
    [self.nameField resignFirstResponder];
    
    if ([self.nameField.text isEqualToString:self.nickname]) {
        
        [RKDropdownAlert title:@"用户信息未变更" time:2];
        return ;
    }
    
    EDWebUserEditNicknameRequest *req = [[EDWebUserEditNicknameRequest alloc] init];
    req.nickname = self.nameField.text;
    req.userId = self.userId;
    
    [self beginCicleProgressWithBg];

    [EDWebUserConnect editNickname:req withFinished:^(id  _Nonnull response) {

        EDWebBaseResponse *res = (EDWebBaseResponse *)response;

        [self endProgress];
        
        if (res.isSuccess) {
            EDUserInfo *userInfo = [EDUserStore get];
            userInfo.nickname = self.nameField.text;
            [EDUserStore reset:userInfo];
            [RKDropdownAlert title:res.msg time:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [RKDropdownAlert title:res.msg time:2];
        }
    }];
}

@end
