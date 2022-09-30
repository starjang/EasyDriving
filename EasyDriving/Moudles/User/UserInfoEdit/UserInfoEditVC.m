//
//  UserInfoEditVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "UserInfoEditVC.h"
#import "BaseHeader.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"
#import "EditCarIdVC.h"
#import "EditNicknameVC.h"

@interface UserInfoEditVC ()

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) Button *editNameBtn;
@property (nonatomic, strong) UILabel *carIdLab;
@property (nonatomic, strong) Button *editCarIdBtn;

@end

@implementation UserInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateNameOrId];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)initData {
    
}

- (void)initViews {
    
    [self setNavTitle:@"个人信息"];
    [self initNavLeftBtn];
    [self initNameView];
    [self initNameEditView];
    [self initCarIdView];
    [self initCarIdEditView];
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
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:fontBig];
    self.nameLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.nameLab.numberOfLines = 0;
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.layer.borderWidth = 0.5;
    self.nameLab.borderColor = [UIColor colorWithHexString:e_lettercolor_desc];
    [self.view addSubview:self.nameLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iUnitPoint10 * 8 + iScreenNavigationHeight);
        make.left.mas_equalTo(iUnitPoint10 * 4);
        make.width.mas_equalTo(iUnitPoint10 * 20);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
}

- (void)initNameEditView {
    
    self.editNameBtn = [[Button alloc] init];
    
    self.editNameBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.editNameBtn.title = @"修改";
    self.editNameBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.editNameBtn.titleLabel.font = [UIFont systemFontOfSize:fontBig];
    self.editNameBtn.layer.cornerRadius = 3;
    [self.view addSubview:self.editNameBtn];
    
    [self.editNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_right).mas_offset(iUnitPoint10 * 2);
        make.centerY.mas_equalTo(self.nameLab);
        make.width.mas_equalTo(iUnitPoint10 * 5);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.editNameBtn addTarget:self action:@selector(editNicknameClick) forControlEvents:UIControlEventTouchUpInside];

}


- (void)initCarIdView {
    
    self.carIdLab = [[UILabel alloc] init];
    self.carIdLab.font = [UIFont boldSystemFontOfSize:fontBig];
    self.carIdLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.carIdLab.numberOfLines = 0;
    self.carIdLab.textAlignment = NSTextAlignmentLeft;
    self.carIdLab.layer.borderWidth = 0.5;
    self.carIdLab.borderColor = [UIColor colorWithHexString:e_lettercolor_desc];
    [self.view addSubview:self.carIdLab];
    
    [self.carIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(iUnitPoint10 * 4);
        make.left.mas_equalTo(iUnitPoint10 * 4);
        make.width.mas_equalTo(iUnitPoint10 * 20);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
}

- (void)initCarIdEditView {
    
    self.editCarIdBtn = [[Button alloc] init];
    
    self.editCarIdBtn.backgroundColor = [UIColor colorWithHexString:e_buttonnormalcolor];
    self.editCarIdBtn.title = @"修改";
    self.editCarIdBtn.titleColor = [UIColor colorWithHexString:e_textreversecolor];
    self.editCarIdBtn.titleLabel.font = [UIFont systemFontOfSize:fontBig];
    self.editCarIdBtn.layer.cornerRadius = 3;
    [self.view addSubview:self.editCarIdBtn];
    
    [self.editCarIdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.carIdLab.mas_right).mas_offset(iUnitPoint10 * 2);
        make.centerY.mas_equalTo(self.carIdLab);
        make.width.mas_equalTo(iUnitPoint10 * 5);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    [self.editCarIdBtn addTarget:self action:@selector(editCarIdClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)updateNameOrId {
    
    EDUserInfo *userInfo = [EDUserStore get];
    self.nameLab.text = [NSString stringWithFormat:@"  用户名：%@", userInfo.nickname];
    self.carIdLab.text = [NSString stringWithFormat:@"  车牌号：%@", userInfo.carId];
}

- (void)editCarIdClick {

    EDUserInfo *userInfo = [EDUserStore get];

    EditCarIdVC *editVC = [[EditCarIdVC alloc] init];
    editVC.carId = userInfo.carId;
    editVC.userId = userInfo.userId;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVC animated:YES];
    
}

- (void)editNicknameClick {
    
    EDUserInfo *userInfo = [EDUserStore get];
    
    EditNicknameVC *editVC = [[EditNicknameVC alloc] init];
    editVC.nickname = userInfo.nickname;
    editVC.userId = userInfo.userId;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVC animated:YES];
    
}


@end
