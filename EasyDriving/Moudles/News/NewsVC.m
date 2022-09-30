//
//  NewsVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "NewsVC.h"
#import "BaseHeader.h"
#import "EDWebNewsConnect.h"
#import "EDWebNewsQueryResponse.h"
#import "EDNews.h"
#import "NewsCell.h"
#import <MJRefresh/MJRefresh.h>
#import "NewsDetailVC.h"

#define NewsCellId @"newsCellId"

@interface NewsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTitle:@"新闻"];
    [self showLigthStatusBarContent];
    [self initData];
    [self initViews];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)initData {
    
    self.news = [NSMutableArray array];
    self.startIndex = 0;
    self.pageCount = 5;
    [self initFirstPage:YES];
}

- (void)initViews {
    
    [self initTableView];
    
}

- (void)initFirstPage:(BOOL)refreshBg {
    
    self.startIndex = 0;
    [self.news removeAllObjects];
    
    EDWebNewsQueryRequest *newReq = [[EDWebNewsQueryRequest alloc] init];
    newReq.startIndex = self.startIndex;
    newReq.pageCount = self.pageCount;
    
    if (refreshBg) {
        [self beginCicleProgressWithBg];
    }
    
    [EDWebNewsConnect queryNews:newReq withFinished:^(id  _Nonnull response) {
       
        [self endProgress];
       
        [self.tableView.mj_header endRefreshing];
        
        EDWebNewsQueryResponse *newRes = (EDWebNewsQueryResponse *)response;
        
        if (newRes.isSuccess) {
            
            [self.tableView.mj_footer setState:MJRefreshStateIdle];

            if (!self.tableView.mj_header) {
                self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    
                    [self initFirstPage:NO];
                }];
            }
            
            if (!self.tableView.mj_footer) {
                self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    
                    [self initNextPage];
                }];
            }
            
            self.startIndex = 0;
            self.news = newRes.news;
            [self.tableView reloadData];
        }
    }];
}

- (void)initNextPage {
    
    self.startIndex += self.pageCount;
    
    EDWebNewsQueryRequest *newReq = [[EDWebNewsQueryRequest alloc] init];
    newReq.startIndex = self.startIndex;
    newReq.pageCount = self.pageCount;
    
    [EDWebNewsConnect queryNews:newReq withFinished:^(id  _Nonnull response) {
        
        [self.tableView.mj_footer endRefreshing];
        
        EDWebNewsQueryResponse *newRes = (EDWebNewsQueryResponse *)response;
        
        if (newRes.isSuccess) {
            
            if (newRes.news.count < self.pageCount) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                });
                
            }
            
            [self.news addObjectsFromArray:newRes.news];
            [self.tableView reloadData];
        }
    }];
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight - iScreenTabbarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:NewsCellId];
    self.tableView.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.news.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return iUnitPoint10 * 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellId forIndexPath:indexPath];
    
    EDNews *news = self.news[indexPath.row];
    
    [cell update: news];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    EDNews *news = self.news[indexPath.row];
    
    NewsDetailVC *detailVC = [[NewsDetailVC alloc] init];
    detailVC.title = news.title;
    detailVC.webUrl = news.contentUrl;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
