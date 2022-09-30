//
//  RegisterView.m
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "RegisterView.h"
#import "BaseHeader.h"
#import "EDUserInfo.h"

@interface RegisterView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UITextField *pwdVerifyField;
@property (nonatomic, strong) UITextField *nicknameField;
@property (nonatomic, strong) UITextField *carIdField;
@property (nonatomic, strong) Button *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation RegisterView


- (instancetype)initWithDefaultFrame:(CGRect)destFrame {
    
    RegisterView *regsView = [[RegisterView alloc]initWithFrame:destFrame];
    [regsView initData];
    [regsView initViews];
    return regsView;
}

- (void)initData {
    
}

- (void)initViews {
    
    [self initObserver];
    [self initNameField];
    [self initPasswordField];
    [self initVerifyPasswordField];
    [self initNicknameField];
    [self initCarIdField];
    [self initRegisterBtn];
    [self initLoginBtn];
    
    [self initGesture];
}

- (void)initObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initNameField {
    self.nameField = [[UITextField alloc] init];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.placeholder = @"请输入账号";
    self.nameField.font = [UIFont systemFontOfSize:fontSmall];
    self.nameField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.keyboardType = UIKeyboardTypeDefault;
    self.nameField.returnKeyType = UIReturnKeyNext;
    self.nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nameField.delegate = self;
    [self addSubview:self.nameField];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iUnitPoint10 * 15);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.nameField.superview layoutIfNeeded];
}

- (void)initPasswordField {
    self.pwdField = [[UITextField alloc] init];
    self.pwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdField.placeholder = @"请输入密码(最少需6位)";
    self.pwdField.font = [UIFont systemFontOfSize:fontSmall];
    self.pwdField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdField.keyboardType = UIKeyboardTypeDefault;
    self.pwdField.returnKeyType = UIReturnKeyNext;
    self.pwdField.clearsOnBeginEditing = YES;
    self.pwdField.secureTextEntry = YES;
    
    [self addSubview:self.pwdField];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameField.mas_bottom).mas_offset(iUnitPoint10);
        make.left.right.height.mas_equalTo(self.nameField);
    }];
    
    [self.pwdField.superview layoutIfNeeded];
}

- (void)initVerifyPasswordField {
    self.pwdVerifyField = [[UITextField alloc] init];
    self.pwdVerifyField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdVerifyField.placeholder = @"请再次输入密码确认";
    self.pwdVerifyField.font = [UIFont systemFontOfSize:fontSmall];
    self.pwdVerifyField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.pwdVerifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdVerifyField.keyboardType = UIKeyboardTypeDefault;
    self.pwdVerifyField.returnKeyType = UIReturnKeyNext;
    self.pwdVerifyField.clearsOnBeginEditing = YES;
    self.pwdVerifyField.secureTextEntry = YES;
    
    [self addSubview:self.pwdVerifyField];
    
    [self.pwdVerifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdField.mas_bottom).mas_offset(iUnitPoint10);
        make.left.right.height.mas_equalTo(self.nameField);
    }];
    
    [self.pwdVerifyField.superview layoutIfNeeded];
}

- (void)initNicknameField {
    self.nicknameField = [[UITextField alloc] init];
    self.nicknameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nicknameField.placeholder = @"请输入昵称";
    self.nicknameField.font = [UIFont systemFontOfSize:fontSmall];
    self.nicknameField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.nicknameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nicknameField.keyboardType = UIKeyboardTypeDefault;
    self.nicknameField.returnKeyType = UIReturnKeyNext;
    self.nicknameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.nicknameField.delegate = self;
    [self addSubview:self.nicknameField];
    
    [self.nicknameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdVerifyField.mas_bottom).mas_offset(iUnitPoint10);
        make.left.right.height.mas_equalTo(self.nameField);
    }];
    
    [self.nicknameField.superview layoutIfNeeded];
}

- (void)initCarIdField {
    self.carIdField = [[UITextField alloc] init];
    self.carIdField.borderStyle = UITextBorderStyleRoundedRect;
    self.carIdField.placeholder = @"请输入车牌号";
    self.carIdField.font = [UIFont systemFontOfSize:fontSmall];
    self.carIdField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.carIdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.carIdField.keyboardType = UIKeyboardTypeDefault;
    self.carIdField.returnKeyType = UIReturnKeyNext;
    self.carIdField.delegate = self;
    [self addSubview:self.carIdField];
    
    [self.carIdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nicknameField.mas_bottom).mas_offset(iUnitPoint10);
        make.left.right.height.mas_equalTo(self.nameField);
    }];
    
    [self.carIdField.superview layoutIfNeeded];
}

- (void)initRegisterBtn {
    
    self.registerBtn = [[Button alloc] init];
    self.registerBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.registerBtn.title = @"注册";
    self.registerBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:fontMiddle];
    self.registerBtn.layer.cornerRadius = 3;
    [self addSubview:self.registerBtn];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.carIdField.mas_bottom).mas_offset(iUnitPoint10 * 3);
        make.left.right.mas_equalTo(self.nameField);
        make.height.mas_equalTo(iUnitPoint10 * 5);
    }];
    
    [self.registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initLoginBtn {
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:e_lettercolor_desc] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSmall];
    [self addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registerBtn.mas_bottom).mas_offset(iUnitPoint10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(iUnitPoint10 * 20);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)registerClick {
    
    if ([self.nameField.text length] < 1) {
        [RKDropdownAlert title:@"用户名不能为空" time:2];
        return;
    }
    
    if ([self.pwdField.text length] < 1) {
        [RKDropdownAlert title:@"密码不能为空" time:2];
        return;
    }
    
    if (![self.pwdField.text isEqualToString:self.pwdVerifyField.text]) {
        [RKDropdownAlert title:@"两次输入的密码不一致，请重新输入" time:2];
        return ;
    }
    
    if ([self.nicknameField.text length] < 1) {
        [RKDropdownAlert title:@"昵称不能为空" time:2];
        return;
    }
    
    if ([self.carIdField.text length] < 1) {
        [RKDropdownAlert title:@"车牌号码不能为空" time:2];
        return;
    }
    
    EDUserInfo *userInfo = [[EDUserInfo alloc] init];
    userInfo.username = self.nameField.text;
    userInfo.password = self.pwdField.text;
    userInfo.nickname = self.nicknameField.text;
    userInfo.carId = self.carIdField.text;
    
    self.registerBlocked(userInfo);
}

- (void)loginClick {
    self.loginBlocked();
}

- (void)initGesture {
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGr.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGr];
}

- (void)hideKeyboard {
    
    if (self.nameField.isFirstResponder) {
        [self.nameField resignFirstResponder];
    } else if (self.pwdField.isFirstResponder) {
        [self.pwdField resignFirstResponder];
    } else if (self.pwdVerifyField.isFirstResponder) {
        [self.pwdVerifyField resignFirstResponder];
    } else if (self.nicknameField.isFirstResponder) {
        [self.nicknameField resignFirstResponder];
    } else if (self.carIdField.isFirstResponder) {
        [self.carIdField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    BOOL retValue = NO;
    if (textField == self.nameField)
    {
        if ([textField.text length]  > 1) {
            [self.pwdField becomeFirstResponder];
            retValue = NO;
        }
    } else if (textField == self.pwdField){
        
        if ([textField.text length] >= 6) {
            [self.pwdVerifyField becomeFirstResponder];
            retValue = NO;
        }
    } else if (textField == self.pwdVerifyField){
        
        if ([textField.text length] >= 6) {
            [self.nicknameField becomeFirstResponder];
            retValue = NO;
        }
    } else if (textField == self.nicknameField){
        
        if ([textField.text length] >= 1) {
            [self.carIdField becomeFirstResponder];
            retValue = NO;
        }
    } else {
        
        [self.carIdField resignFirstResponder];

    }
    
    return retValue;
}

//键盘弹出后将视图向上移动
- (void)keyboardWillShow:(NSNotification *)note {
    
    NSDictionary *info = [note userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //目标视图UITextField
    CGRect frame;
    if (self.nameField.isFirstResponder) {
        frame = self.nameField.frame;
    } else if (self.pwdField.isFirstResponder) {
        frame = self.pwdField.frame;
    } else if (self.pwdVerifyField.isFirstResponder) {
        frame = self.pwdVerifyField.frame;
    } else if (self.nicknameField.isFirstResponder) {
        frame = self.nicknameField.frame;
    } else if (self.carIdField.isFirstResponder) {
        frame = self.carIdField.frame;
    }
    
    int y = frame.origin.y + frame.size.height - (self.frame.size.height - keyboardSize.height);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if(y > 0) {
        self.frame = CGRectMake(0, -y, self.frame.size.width, self.frame.size.height);
    }
    [UIView commitAnimations];
}


//键盘隐藏后将视图恢复到原始状态
- (void)keyboardWillHide:(NSNotification *)note {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}


@end
