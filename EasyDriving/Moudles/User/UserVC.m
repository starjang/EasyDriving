//
//  UserVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "UserVC.h"
#import "BaseHeader.h"
#import "UserItem.h"
#import "UserCell.h"
#import "UserItemFactory.h"
#import "EDUserStore.h"
#import "LoginVC.h"
#import "UserHeaderView.h"
#import "EDUserHistoryStore.h"
#import "OrdersVC.h"
#import "PointsVC.h"
#import "HistoriesVC.h"
#import "UserInfoEditVC.h"

#define UserCellId @"userCellId"

@interface UserVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserHeaderView *headerView;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self checkUserLoginStatus];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self showNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.headerView) {
        [self.headerView updateNickname:[EDUserStore get].nickname];
    }
}

- (void)initData {
    self.items = [UserItemFactory getItems];
}

- (void)initViews {
    
    [self setNavTitle:@"我的"];
    
    [self initTableView];
    [self initTableHeaderView];
}

- (void)checkUserLoginStatus {
    
    if (![EDUserStore get]) {
        
        LoginVC *logVC = [[LoginVC alloc] init];
        [self presentViewController:logVC animated:YES completion:nil];
    }
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight - iScreenTabbarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:UserCellId];
    self.tableView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.view addSubview:self.tableView];
    
}

- (void)initTableHeaderView {
    
    self.headerView = [[UserHeaderView alloc] initWithDefaultFrame:CGRectMake(0, 0, iScreenWidth, UserHeaderHeight)];
    
    self.tableView.tableHeaderView = self.headerView;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *rows = self.items[section];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return iUnitPoint10 * 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCell *userCell = [tableView dequeueReusableCellWithIdentifier:UserCellId forIndexPath:indexPath];
    
    NSArray *rows = self.items[indexPath.section];
    UserItem *item = rows[indexPath.row];
    
    [userCell update:item];
    
    return userCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rows = self.items[indexPath.section];
    UserItem *item = rows[indexPath.row];
    [self handelWithItem:item.itemId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, iScreenWidth, iUnitPoint10);
    footerView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    return footerView;
}

- (void)handelWithItem:(UserItemID)itemId {
    
    if (itemId == USER_INFO) {
        
        UserInfoEditVC *editVC = [[UserInfoEditVC alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:editVC animated:YES];
        
    } else if (itemId == HISTORY_ORDER) {
    
        OrdersVC *ordersVC = [[OrdersVC alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ordersVC animated:YES];
        
    } else if (itemId == HISTORY_PLACE) {
        
        HistoriesVC *historyVC = [[HistoriesVC alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:historyVC animated:YES];
        
    } else if (itemId == MY_POINT) {
        
        PointsVC *pointsVC = [[PointsVC alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pointsVC animated:YES];
        
    } else if (itemId == CLEAN_CACHE) {
        
        [self beginCicleProgressWithBg];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [[SDImageCache sharedImageCache] clearMemory];
            [self.tableView reloadData];
            [self performSelector:@selector(endProgress) withObject:nil afterDelay:1];
        }];
        
    } else if (itemId == LOG_OUT) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出易行吗？" message:@"账号退出不会删除您的历史数据" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
            [EDUserStore clean];
            [EDUserHistoryStore clean];
            
            LoginVC *login = [[LoginVC alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat imageHeight = UserHeaderHeight;
    
    CGFloat imageWidth = iScreenWidth;
    
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        
        self.headerView.bgImgView.frame = CGRectMake(-(imageWidth * f                                                                               - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}

@end
