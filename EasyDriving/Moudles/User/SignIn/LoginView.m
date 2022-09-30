//
//  LoginView.m
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "LoginView.h"
#import "BaseHeader.h"

@interface LoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) Button *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation LoginView

- (instancetype)initWithDefaultFrame:(CGRect)destFrame {
    
    LoginView *login = [[LoginView alloc]initWithFrame:destFrame];
    [login initData];
    [login initViews];
    return login;
}

- (void)initData {


}

- (void)initViews {
    
    [self initObserver];
    [self initLogoView];
    [self initNameFieldView];
    [self initPasswordFieldView];
    [self initLoginBtn];
    [self initRegisterBtn];
    
    [self initGesture];
}

- (void)initObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initGesture {
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGr.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGr];
}

- (void)initLogoView {
    
    self.logoView = [[UIImageView alloc] init];
    self.logoView.image = [UIImage imageNamed:@"logo"];
    self.logoView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoView.clipsToBounds = YES;
    self.logoView.layer.cornerRadius = 5;
    [self addSubview:self.logoView];
     
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(iScreenHeight/5);
        make.size.mas_equalTo(iUnitPoint10 * 8);
    }];
     
//    [self.logoView showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initNameFieldView {

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
        make.top.mas_equalTo(self.logoView.mas_bottom).mas_offset(iUnitPoint10 * 5);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.nameField.superview layoutIfNeeded];
}

- (void)initPasswordFieldView {
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.placeholder = @"请输入密码(最少需6位)";
    self.passwordField.font = [UIFont systemFontOfSize:fontSmall];
    self.passwordField.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.keyboardType = UIKeyboardTypeDefault;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.clearsOnBeginEditing = YES;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    [self addSubview:self.passwordField];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.nameField.mas_bottom).mas_offset(iUnitPoint10);
        make.left.right.height.mas_equalTo(self.nameField);
    }];
    
    [self.passwordField.superview layoutIfNeeded];
}


- (void)initLoginBtn {
    
    self.loginBtn = [[Button alloc] init];
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.loginBtn.title = @"登录";
    self.loginBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:fontMiddle];
    self.loginBtn.layer.cornerRadius = 3;
    [self addSubview:self.loginBtn];
     
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordField.mas_bottom).mas_offset(iUnitPoint10 * 3);
        make.left.right.mas_equalTo(self.nameField);
        make.height.mas_equalTo(iUnitPoint10 * 5);
    }];
    
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initRegisterBtn {
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setTitle:@"没有账号？点击此处注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithHexString:e_lettercolor_desc] forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSmall];
    [self addSubview:self.registerBtn];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(iUnitPoint10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(iUnitPoint10 * 20);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.registerBtn showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)loginClick {
    
    if (self.nameField.text.length < 1 || self.passwordField.text.length < 1) {
        [RKDropdownAlert title:@"用户名或密码不能为空" time:2];
        return;
    }
    
    if (self.passwordField.text.length < 6) {
        [RKDropdownAlert title:@"请输入6位及以上的密码" time:2];
        return;
    }
    
    self.loginBlocked(self.nameField.text, self.passwordField.text);
}

- (void)registerClick {
    self.registerBlocked();
}

//键盘弹出后将视图向上移动
- (void)keyboardWillShow:(NSNotification *)note {
    
    NSDictionary *info = [note userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //目标视图UITextField
    CGRect frame;
    if (self.nameField.isFirstResponder) {
        frame = self.nameField.frame;
    } else if (self.passwordField.isFirstResponder) {
        frame = self.passwordField.frame;
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

- (void)hideKeyboard {
    
    if (self.nameField.isFirstResponder) {
        [self.nameField resignFirstResponder];
    } else if (self.passwordField.isFirstResponder) {
        [self.passwordField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    BOOL retValue = NO;
    if (textField == self.nameField)
    {
        if ([textField.text length]  > 1) {
            [self.passwordField becomeFirstResponder];
            retValue = NO;
        }
    } else {
        [self.passwordField resignFirstResponder];
    }
    
    return retValue;
}

@end
