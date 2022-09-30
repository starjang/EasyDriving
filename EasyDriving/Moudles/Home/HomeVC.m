//
//  HomeVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "HomeVC.h"
#import "LoginVC.h"
#import "HomeCell.h"
#import "HomeItem.h"
#import "HomeItemFactory.h"
#import "BaseHeader.h"
#import "POIVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "EDWebUserConnect.h"
#import "EDWebUserAddHistoryRequest.h"
#import "EDUserHistory.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "EDUserStore.h"
#import "EDUserHistoryStore.h"
#import <AMapNaviKit/AMapNaviCompositeManager.h>
#import <AMapNaviKit/AMapNaviCompositeUserConfig.h>

#define HomeCellId @"homeCellId"

@interface HomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, AMapLocationManagerDelegate, AMapSearchDelegate, AMapNaviCompositeManagerDelegate>

@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AMapLocationManager *locationManager; //定位管理类
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate; //当前坐标
@property (nonatomic, strong) AMapSearchAPI *searchMap; //地图搜索
@property (nonatomic, strong) AMapLocationReGeocode *locationReGeocode; //逆地理编码
@property (nonatomic, strong) AMapWeatherSearchRequest *weatherRequest;//天气查询
@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;

@end

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showLigthStatusBarContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self closeInteractivePopGesture];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self openInteractivePopGesture];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"首页"];
    [self initData];
    [self initViews];
    
}

- (void)initData {
    
    self.items = [HomeItemFactory getItems];
    
    [self initAMapLocation];
}

- (void)initViews {
    
    [self initLeftNavBtn];
    [self initNavRightBtn];
    [self initCollectionView];
}

- (void)initNavRightBtn {
    
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(0, 0, iUnitPoint10 * 9, iScreenNavigationHeight);
    self.rightNavBtn.titleLabel.font = [UIFont systemFontOfSize:fontSmall];
    self.rightNavBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    UIView *rightNavView = [[UIView alloc] initWithFrame:CGRectMake(0, -iUnitPoint10, iUnitPoint10 * 9, iScreenNavigationHeight)];
    [rightNavView addSubview:self.rightNavBtn];
    
//    [rightNavView showPlaceHolderWithLineColor:[UIColor redColor]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavView];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)initAMapLocation {
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setLocatingWithReGeocode:YES];
    // 开始持续定位
    [self.locationManager startUpdatingLocation];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // 定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout = 10;
    // 逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 10;
    
    // 地图搜索
    self.searchMap = [[AMapSearchAPI alloc] init];
    self.searchMap.delegate = self;
    
    // 天气搜索
    self.weatherRequest = [[AMapWeatherSearchRequest alloc] init];
}

#pragma mark - 获取天气
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response {
    
    AMapLocalWeatherLive *live = response.lives[0];
//    NSLog(@"天气====%@温度===%@", live.weather, live.temperature);
    [self.rightNavBtn setTitle:[NSString stringWithFormat:@"%@ %@℃", live.weather, live.temperature] forState:UIControlStateNormal];
}

#pragma mark - 获取定位坐标，进行业务处理
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    
    
    if (reGeocode) {
        
        NSLog(@"reGeocode:%@", reGeocode);

        self.locationReGeocode = reGeocode;

        // 搜索当前位置的天气
        self.weatherRequest.city = reGeocode.city;
        self.weatherRequest.type = AMapWeatherTypeLive;
        [self.searchMap AMapWeatherSearch:self.weatherRequest];
        
        
        if (reGeocode.POIName) {
            // 重置导航栏
            [self setNavTitle:reGeocode.AOIName];
        }
        
        AMapCoordinateType type = AMapCoordinateTypeGPS;
        self.currentCoordinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), type);
        // 停止定位
//        [manager stopUpdatingLocation];
        
        // 上传位置信息到服务器
        [self addTrailHistroyToServer];
    }
}

- (void)initLeftNavBtn {
    
    UIButton *localBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, iUnitPoint10 * 4, iUnitPoint10 * 4)];
    [localBtn setImage:[UIImage imageNamed:@"home_poi_custom"] forState:UIControlStateNormal];
    [localBtn addTarget:self action:@selector(customRoute) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *localItem = [[UIBarButtonItem alloc]initWithCustomView:localBtn];
    // 配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -20.0f;
    self.navigationItem.leftBarButtonItems = @[spaceItem, localItem];
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


- (void)addTrailHistroyToServer {
    
    // 判断位置是否变化，未变化则不上传
    EDUserHistory *trailStore = [EDUserHistoryStore get];
    
    if (trailStore) {
        
        if ([trailStore.historyName isEqualToString:self.locationReGeocode.AOIName]) {
            
//            [RKDropdownAlert title:@"地理位置未发生变化" time:2];
            return;
        }
    }
    
    
    EDUserHistory *trail = [[EDUserHistory alloc] init];
    trail.latitude = self.currentCoordinate.latitude;
    trail.longitude = self.currentCoordinate.longitude;
    trail.historyName = self.locationReGeocode.AOIName;
    trail.historyAddress = self.locationReGeocode.formattedAddress;
    
    EDWebUserAddHistoryRequest *addTrailReqs = [[EDWebUserAddHistoryRequest alloc] init];
    addTrailReqs.userId = [EDUserStore get].userId;
    addTrailReqs.trail = trail;
    
    [EDWebUserConnect addHistory:addTrailReqs withFinished:^(id  _Nonnull response) {
        
        EDWebBaseResponse *addReps = (EDWebBaseResponse *)response;
        
        if (addReps.isSuccess) {
            [RKDropdownAlert title:addReps.msg time:2];
            [EDUserHistoryStore reset:trail];
        }
    }];
}

- (void)initCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, iScreenWidth, iScreenHeight - iScreenTabbarHeight) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.backgroundColor = [UIColor colorWithHexString:e_bgcolor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:HomeCellId];
    
//    [self.collectionView showPlaceHolderWithLineColor:[UIColor redColor]];
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.items.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeItem *item = self.items[indexPath.row];
    
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCellId forIndexPath:indexPath];
    [cell update:item];
    
    return cell;
    
}


#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return  CGSizeMake(iScreenWidth/2 - 0.5, (iScreenHeight - iScreenTabbarHeight - iScreenNavigationHeight - iScreenStatusBarHeight)/3);
}


#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}

#pragma mark  点击CollectionView触发事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == EMERGENCY_CALL) {
        
        NSMutableString *tele = [[NSMutableString alloc] initWithFormat:@"tel:110"];
        UIWebView *teleView = [[UIWebView alloc] init];
        [teleView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tele]]];
        [self.view addSubview:teleView];
        
    } else {
        
        POIVC *pVC = [[POIVC alloc] init];
        pVC.locationCoordinate = self.currentCoordinate;
        pVC.isSupportOrder = NO;

        switch (indexPath.row) {
            case GAS_STATION:
                pVC.poiTitle = @"加油站";
                pVC.isSupportOrder = YES;
                break;
            case PARKING_LOT:
                pVC.poiTitle = @"停车场";
                break;
            
            case CAR_MAINTENANCE:
                pVC.poiTitle = @"汽车保养";
                pVC.isSupportOrder = YES;

                break;
                
            case CAR_REPAIR:
                pVC.poiTitle = @"汽车维修";
                pVC.isSupportOrder = YES;

                break;
                
            case CAR_STORE:
                pVC.poiTitle = @"汽车商店";
                pVC.isSupportOrder = YES;

                break;
                
            default:
                
                break;
        }
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pVC animated:YES];
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
