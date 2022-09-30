//
//  OrdersVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "OrdersVC.h"
#import "BaseHeader.h"
#import "OrdersCell.h"
#import "EDUserOrder.h"
#import "EDWebUserConnect.h"
#import "EDWebUserQueryOrdersRequest.h"
#import "EDWebUserQueryOrdersResponse.h"
#import "EDWebUserDeleteOrderRequest.h"
#import "EDUserInfo.h"
#import "EDUserStore.h"

#define OrdersCellId @"ordersCellId"

@interface OrdersVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) NSMutableArray *orders;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrdersVC


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
    
    self.orders = [NSMutableArray array];
}


- (void)initViews {
    
    [self setNavTitle:@"历史预定"];
    [self initNavLeftBtn];
    [self initTableView];
}

- (void)initFirstPageData {
    
    EDUserInfo *userInfo = [EDUserStore get];
    
    [self beginCicleProgressWithBg];
    
    EDWebUserQueryOrdersRequest *request = [[EDWebUserQueryOrdersRequest alloc] init];
    request.userId = userInfo.userId;
    
    [EDWebUserConnect queryOrders:request withFinished:^(id  _Nonnull response) {
        
        EDWebUserQueryOrdersResponse *queryRes = (EDWebUserQueryOrdersResponse *)response;
        
        [self endProgress];
        
        if (queryRes.isSuccess) {
            
            self.orders = queryRes.orders;
            [self.tableView reloadData];
        }
    }];
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

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrdersCell class] forCellReuseIdentifier:OrdersCellId];
    self.tableView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.view addSubview:self.tableView];
}

//- (void)initTableHeaderView {
//
//    self.headerView = [[UserHeaderView alloc] initWithDefaultFrame:CGRectMake(0, 0, iScreenWidth, UserHeaderHeight)];
//
//    self.tableView.tableHeaderView = self.headerView;
//
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orders.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return iUnitPoint10 * 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:OrdersCellId forIndexPath:indexPath];
    
    EDUserOrder *order = self.orders[indexPath.row];
    
    [cell updateData: order];
    
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
    
    // 删除订单
    EDWebUserDeleteOrderRequest *delReq = [[EDWebUserDeleteOrderRequest alloc] init];
    
    EDUserOrder *order = self.orders[indexPath.row];
    EDUserInfo *user = [EDUserStore get];
    
    delReq.orderId = order.orderId;
    delReq.userId = user.userId;
    
    [self beginCicleProgressWithBg];
    [EDWebUserConnect deleteOrders:delReq withFinished:^(id  _Nonnull response) {
        
        [self endProgress];
        
        EDWebBaseResponse *delRes = (EDWebBaseResponse *)response;
        
        if (delRes.isSuccess) {
            
            [self.orders removeObjectAtIndex:indexPath.row];
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

@end
