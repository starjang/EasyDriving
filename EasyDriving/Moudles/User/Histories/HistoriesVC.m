//
//  HistoriesVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "HistoriesVC.h"
#import "BaseHeader.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"
#import "EDUserHistory.h"
#import "HistoriesCell.h"
#import "EDWebUserConnect.h"
#import "EDWebUserQueryHistoriesResponse.h"

#define HistoriesCellId @"historiesCellId"

@interface HistoriesVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) NSMutableArray *histories;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation HistoriesVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initFirstPageData];
}


- (void)initData {
    
    self.histories = [NSMutableArray array];
}

- (void)initViews {
    
    [self setNavTitle:@"历史足迹"];
    [self initNavLeftBtn];
    [self initTableView];
}

- (void)initFirstPageData {
    
    EDUserInfo *userInfo = [EDUserStore get];
    
    [self beginCicleProgressWithBg];
    
    EDWebUserQueryHistoriesRequest *request = [[EDWebUserQueryHistoriesRequest alloc] init];
    request.userId = userInfo.userId;
    
    [EDWebUserConnect queryHistories:request withFinished:^(id  _Nonnull response) {
        
        EDWebUserQueryHistoriesResponse *queryRes = (EDWebUserQueryHistoriesResponse *)response;
        
        [self endProgress];
        
        if (queryRes.isSuccess) {
            
            self.histories = queryRes.histories;
            [self.tableView reloadData];
        } else {
            [RKDropdownAlert title:queryRes.msg time:2];
        }
    }];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HistoriesCell class] forCellReuseIdentifier:HistoriesCellId];
    self.tableView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.histories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return iUnitPoint10 * 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoriesCellId forIndexPath:indexPath];
    
    EDUserHistory *history = self.histories[indexPath.row];
    
    [cell updateData: history];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 删除足迹
    EDWebUserDeleteHistoryRequest *delReq = [[EDWebUserDeleteHistoryRequest alloc] init];

    EDUserHistory *history = self.histories[indexPath.row];
    EDUserInfo *user = [EDUserStore get];

    delReq.historyId = history.historyId;
    delReq.userId = user.userId;

    [self beginCicleProgressWithBg];
    [EDWebUserConnect deleteHistory:delReq withFinished:^(id  _Nonnull response) {

        [self endProgress];

        EDWebBaseResponse *delRes = (EDWebBaseResponse *)response;

        if (delRes.isSuccess) {

            [self.histories removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        }
    }];
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
