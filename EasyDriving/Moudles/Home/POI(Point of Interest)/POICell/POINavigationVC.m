//
//  POINavigationVC.m
//  行车导航
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "POINavigationVC.h"
#import "POIPreferenceView.h"
#import "POISpeechSynthesizer.h"
#import "BaseHeader.h"

@interface POINavigationVC ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate, PreferenceViewDelegate>

@property (nonatomic, strong) AMapNaviDriveView *driveView;
@property (nonatomic, strong) POIPreferenceView *preferenceView;

@end

@implementation POINavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDriveView];
    [self initDriveManager];
    [self initPreferenceView];
    [self calculateRoute];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self showNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.driveView.showStandardNightType ?  UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}


- (void)initDriveView {

    if (self.driveView == nil) {
        
        self.driveView = [[AMapNaviDriveView alloc] init];
        self.driveView.frame = CGRectMake(0, 0, iScreenWidth, iScreenHeight);
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        [self.driveView setAutoZoomMapLevel:YES];
        [self.driveView setShowGreyAfterPass:YES];
        [self.driveView setTrackingMode:AMapNaviViewTrackingModeCarNorth];
        [self.driveView setAutoSwitchDayNightType:YES];
        [self.view addSubview:self.driveView];
    }
}

- (void)initDriveManager {
    
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    [[AMapNaviDriveManager sharedInstance]  setAllowsBackgroundLocationUpdates:YES];
    [[AMapNaviDriveManager sharedInstance] setPausesLocationUpdatesAutomatically:NO];
    [[AMapNaviDriveManager sharedInstance]  addDataRepresentative:self.driveView];
}

- (void)initPreferenceView {
    
    if (self.preferenceView == nil) {
        
        self.preferenceView = [[POIPreferenceView alloc] init];
        self.preferenceView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self.preferenceView setDelegate:self];
    }
}

#pragma mark - 进行路径规划

- (void)calculateRoute {
    // 使用默认速度优先的方式进行路径的规划
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                                drivingStrategy:0];
}

#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}


- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    
    NSLog(@"onCalculateRouteSuccess");
    
    // 计算路径成功后开始使用GPS导航
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error {
    
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode {
    
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager {
    
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager {
    
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex {
    
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType {
    
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[POISpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager {
    
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager {
    
    NSLog(@"onArrivedDestination");
}

#pragma mark - AMapNaviWalkViewDelegate

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"请问是否要退出导航模式?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        // 导航界面关闭按钮点击时的回调函数
        [[AMapNaviDriveManager sharedInstance] stopNavi];
        [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
        // 停止语音
        [[POISpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
        
        [alertView dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView {
    
    // 配置偏好设置状态
    [self.preferenceView setTrackingMode:self.driveView.trackingMode];
    [self.preferenceView setShowNightType:self.driveView.showStandardNightType];

    [self.preferenceView setFrame:self.view.bounds];
    [self.view addSubview:self.preferenceView];
}

- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView {
    
    NSLog(@"TrunIndicatorViewTapped");
    
    if (self.driveView.showMode == AMapNaviDriveViewShowModeCarPositionLocked) {
        
        [self.driveView setShowMode:AMapNaviDriveViewShowModeNormal];
        
    } else if (self.driveView.showMode == AMapNaviDriveViewShowModeNormal) {
        
        [self.driveView setShowMode:AMapNaviDriveViewShowModeOverview];
    
    } else if (self.driveView.showMode == AMapNaviDriveViewShowModeOverview){
        [self.driveView setShowMode:AMapNaviDriveViewShowModeCarPositionLocked];
    }
}

- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode {
    
    NSLog(@"didChangeShowMode:%ld", (long)showMode);
}

- (void)driveView:(AMapNaviDriveView *)driveView didChangeDayNightType:(BOOL)showStandardNightType {
    
    NSLog(@"didChangeDayNightType:%ld", (long)showStandardNightType);
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Preference View Delegate
- (void)preferenceViewFinishButtonClicked {
    
    [self.preferenceView removeFromSuperview];
}

- (void)PreferenceViewNightTypeChangeTo:(BOOL)isShowNightType {
    
    [self.driveView setShowStandardNightType:isShowNightType];
}

- (void)PreferenceViewTrackingModeChangeTo:(AMapNaviViewTrackingMode)trackingMode {
    
    [self.driveView setTrackingMode:trackingMode];
}

- (void)dealloc {
    
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"是否销毁===%d", success);
}

@end
