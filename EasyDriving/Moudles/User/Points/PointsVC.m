//
//  PointsVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "PointsVC.h"
#import "BaseHeader.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"
#import "PointsCell.h"
#import "EDUserPoints.h"
#import "EDWebUserConnect.h"
#import "EDWebUserQueryPointsResponse.h"

#define PointsCellId @"pointsCellId"

@interface PointsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PointsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)initData {
    
    self.points = [NSMutableArray array];
}

- (void)initViews {
    
    [self setNavTitle:@"我的积分"];
    [self initNavLeftBtn];
    [self initTableView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initFirstPageData];
}

- (void)initFirstPageData {
    
    EDUserInfo *userInfo = [EDUserStore get];
    
    [self beginCicleProgressWithBg];
    
    EDWebUserQueryPointsRequest *request = [[EDWebUserQueryPointsRequest alloc] init];
    request.userId = userInfo.userId;
    
    [EDWebUserConnect queryPoints:request withFinished:^(id  _Nonnull response) {
        
        EDWebUserQueryPointsResponse *queryRes = (EDWebUserQueryPointsResponse *)response;
        
        [self endProgress];
        
        if (queryRes.isSuccess) {
            
            self.points = queryRes.points;
            [self.tableView reloadData];
        }
    }];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PointsCell class] forCellReuseIdentifier:PointsCellId];
    self.tableView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.points.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return iUnitPoint10 * 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PointsCell *cell = [tableView dequeueReusableCellWithIdentifier:PointsCellId forIndexPath:indexPath];
    
    EDUserPoints *point = self.points[indexPath.row];
    
    [cell updateData: point];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
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


@end
