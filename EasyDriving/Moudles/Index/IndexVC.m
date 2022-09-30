//
//  IndexVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "IndexVC.h"
#import "HomeVC.h"
#import "NewsVC.h"
#import "UserVC.h"
#import "BaseHeader.h"

@interface IndexVC () <UITabBarControllerDelegate>

@property (nonatomic, strong) UINavigationController *homeVC;
@property (nonatomic, strong) UINavigationController *newsVC;
@property (nonatomic, strong) UINavigationController *userVC;

@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}

-(void)initViews{
    
    [self initViewControllers];
    
}


- (void)initViewControllers {
        
    self.tabBar.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    
    self.tabBar.translucent = NO;
    
    [self initHomeVC];
    [self initNewsVC];
    [self initUserVC];
    
    [self initTabBarColorAndFont];
    [self initTabbarLineColor];
    
    self.viewControllers = @[self.homeVC,
                             self.newsVC,
                             self.userVC];
    self.selectedIndex = 0;
    
    self.delegate = self ;
    
}

- (void)initHomeVC {
    
    self.homeVC  = [[UINavigationController alloc]initWithRootViewController:[[HomeVC alloc]init]];
    [self initVCWithTitle:@"首页" imgName:@"ion-ios-home" vc:self.homeVC];
    
}

- (void)initNewsVC {
    
    self.newsVC  = [[UINavigationController alloc]initWithRootViewController:[[NewsVC alloc]init]];
    [self initVCWithTitle:@"新闻" imgName:@"ion-ios-paper" vc:self.newsVC];
}


- (void)initUserVC {
    
    self.userVC = [[UINavigationController alloc]initWithRootViewController:[[UserVC alloc]init]];
    [self initVCWithTitle:@"我的" imgName:@"ion-ios-person" vc:self.userVC ];
}

-(void)initVCWithTitle:(NSString *)title imgName:(NSString *)imgName vc:(UINavigationController*)vc {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[OnlineImage getIcon:imgName hexColor:e_lettercolor_desc size:28] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[OnlineImage getIcon:imgName hexColor:e_primaryblackcolor size:28] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)initTabBarColorAndFont {
    
    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    [normal setValue:[UIColor colorWithHexString:e_lettercolor_desc] forKey:NSForegroundColorAttributeName];
    [normal setValue:[UIFont systemFontOfSize:9] forKey:NSFontAttributeName];
    [normal setValue:@(0.5) forKey:NSKernAttributeName];

    NSMutableDictionary *select = [NSMutableDictionary dictionary];
    [select setValue:[UIColor colorWithHexString:e_primaryblackcolor] forKey:NSForegroundColorAttributeName];
    [select setValue:[UIFont systemFontOfSize:9] forKey:NSFontAttributeName];
    [select setValue:@(0.5) forKey:NSKernAttributeName];
    
    
    [self.homeVC.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    [self.homeVC.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];

    [self.newsVC.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    [self.newsVC.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
    
    [self.userVC.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    [self.userVC.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
    
}

- (void)initTabbarLineColor {
    
//    [self.tabBar setShadowImage:[UIImage imageWith:[UIColor colorWithHexString:@"#e0e0e0"] size:CGSizeMake(iScreenWidth, 0.5)]];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
