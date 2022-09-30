//
//  POIVC.m
//  EasyDriving
//
//  Created by Mason on 2018/12/4.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "POIVC.h"
#import "BaseHeader.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "POICell.h"
#import "POINavigationVC.h"
#import <AMapNaviKit/AMapNaviCompositeManager.h>
#import <AMapNaviKit/AMapNaviCompositeUserConfig.h>
#import "POIAddOrderVC.h"

#define POICellId @"POICellId"

@interface POIVC () <AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, POIDataDelegate, AMapNaviCompositeManagerDelegate>

@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) AMapSearchAPI *searchMap;
@property (nonatomic, strong) AMapPOISearchResponse *POISearchRes;
@property (nonatomic, strong) MAMapView *amapView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;

@end

@implementation POIVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initViews];
}

- (void)initData {

}

- (void)initViews {
    
    [self setTitle:self.poiTitle];
    [self beginCircleProgress];
    [self initNavLeftBtn];
//    [self initNavRightBtn];
    [self initMAMapView];
    [self initTableView];
    [self initPOIAroundSearch];
}

- (void)initMAMapView {
    
    self.searchMap = [[AMapSearchAPI alloc] init];
    self.searchMap.delegate = self;
    
    // 初始化地图
    self.amapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, iScreenNavigationHeight + iScreenStatusBarHeight, iScreenWidth, iScreenHeight/3)];
    self.amapView.showsScale = YES;
    self.amapView.showsCompass = YES;
    // 缩放级别（默认3-19，有室内地图时为3-20）
    self.amapView.zoomLevel = 16;
    // 最小缩放级别
    self.amapView.minZoomLevel = 15;
    // 最大缩放级别（有室内地图时最大为20，否则为19）
    self.amapView.maxZoomLevel = 16;
    
    [self.view addSubview:self.amapView];
    
    // 定位中显示小蓝点
    self.amapView.showsUserLocation = YES;
    self.amapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iScreenNavigationHeight + iScreenStatusBarHeight, iScreenWidth, iScreenHeight - iScreenNavigationHeight - iScreenStatusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[POICell class] forCellReuseIdentifier:POICellId];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.amapView;
//    [self.tableView showPlaceHolderWithLineColor:[UIColor redColor]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.POISearchRes.pois.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return yPOICellHeight;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    POICell *cell = [self.tableView dequeueReusableCellWithIdentifier:POICellId];
    
    cell.delegate = self;
    cell.placeName.text = self.POISearchRes.pois[indexPath.row].name;
    CGFloat distanceFromPlace = self.POISearchRes.pois[indexPath.row].distance;
    cell.placeLocation.text = self.POISearchRes.pois[indexPath.row].address;
    
    if (distanceFromPlace/1000 >= 1) {
        cell.placeDistance.text = [NSString stringWithFormat:@"%.1f 公里", distanceFromPlace/1000];
    } else {
        cell.placeDistance.text = [NSString stringWithFormat:@"%d 米",(int)distanceFromPlace];
    }
    
    NSString *phoneNumber = self.POISearchRes.pois[indexPath.row].tel;
    
    if (indexPath.row == 0) {
        phoneNumber = @"13053999999";
    }
    
    if ([phoneNumber isEqualToString:emptyString] || ![self checkMobileNumber:phoneNumber]) {
        
        cell.orderBtn.hidden = YES;
        cell.telView.hidden = YES;
        
    } else {
        
        cell.orderBtn.hidden = NO;
        cell.telView.hidden = NO;
        cell.phoneNumber = phoneNumber;
    }
    
    cell.row = indexPath.row;
    return cell;
}

- (void)initPOIAroundSearch {
    
    AMapPOIAroundSearchRequest *POIAroundReq = [[AMapPOIAroundSearchRequest alloc] init];
    POIAroundReq.location = [AMapGeoPoint locationWithLatitude:self.locationCoordinate.latitude longitude:self.locationCoordinate.longitude];
    // 查询关键字，多个关键字用“|”分割
    POIAroundReq.keywords = self.poiTitle;
    // 按照距离排序
    POIAroundReq.sortrule = 0;
    // 是否返回扩展信息
    POIAroundReq.requireExtension = YES;
    [self.searchMap AMapPOIAroundSearch:POIAroundReq];
}

#pragma mark - POI搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    
    // 解析response获取POI信息
    NSLog(@"POI===%@",response);

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self endProgress];
        self.POISearchRes = response;
        [self.tableView reloadData];
    });
}

#pragma mark - 表格代理方法
- (void)poiCallMerchant:(NSString *)phoneNumber {
    
    UIWebView *phoneWebView = [[UIWebView alloc] init];
    [phoneWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSMutableString alloc] initWithFormat:@"tel:%@", phoneNumber]]]];
    [self.view addSubview:phoneWebView];
}

- (void)poiToNavigationInRow:(NSInteger)row {
    
    POINavigationVC *navVC = [[POINavigationVC alloc] init];
    navVC.startPoint = [AMapNaviPoint locationWithLatitude:self.locationCoordinate.latitude longitude:self.locationCoordinate.longitude];
    navVC.endPoint = [AMapNaviPoint locationWithLatitude:self.POISearchRes.pois[row].location.latitude longitude:self.POISearchRes.pois[row].location.longitude];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:navVC animated:YES];
}

- (void)poiOrderInRow:(NSInteger)row {
    
    NSString *phoneNumber = self.POISearchRes.pois[row].tel;

    if (row == 0) {
        phoneNumber = @"13024777561";
    }
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setValue:self.title forKey:@"title"];
    [info setValue:self.POISearchRes.pois[row].name
            forKey:@"placeName"];
    [info setObject:self.POISearchRes.pois[row].address forKey:@"placeAddress"];
    [info setValue:phoneNumber forKey:@"tel"];
    [info setObject:self.POISearchRes.pois[row].uid forKey:@"uid"];
    
    POIAddOrderVC *orderVC = [[POIAddOrderVC alloc] init];
    orderVC.orderInfo = info;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
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

- (void)initNavRightBtn {
    
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(0, iUnitPoint10/2, iUnitPoint10 * 3, iUnitPoint10 * 3);
    [self.rightNavBtn setImage:[UIImage imageNamed:@"home_poi_custom"] forState:UIControlStateNormal];
    [self.rightNavBtn addTarget:self action:@selector(customRoute) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iScreenNavigationHeight, iScreenNavigationHeight)];
    [rightNavView addSubview:self.rightNavBtn];
    //    [rightNavView showPlaceHolderWithLineColor:[UIColor redColor]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavView];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)customRoute {
    
    [self initCompositeManager];
}

- (void)initCompositeManager {
    
    // 初始化
    self.compositeManager = [[AMapNaviCompositeManager alloc] init];
    // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    self.compositeManager.delegate = self;
    // 通过present的方式显示路线规划页面, 在不传入起终点启动导航组件的模式下，options需传入nil
    [self.compositeManager presentRoutePlanViewControllerWithOptions:nil];
}

- (void)navPopViewClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma 正则匹配手机号
- (BOOL)checkMobileNumber:(NSString *)telNumber {
    
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

@end
