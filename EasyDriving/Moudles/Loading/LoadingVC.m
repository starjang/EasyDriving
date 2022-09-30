//
//  LoadingVC.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "LoadingVC.h"
#import "IndexVC.h"
#import "EDUserStore.h"
#import "LoginVC.h"

@implementation LoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavTitle:@"Home"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideNavigationBar];

    [self showDefaultStatusBarContent];
    
    if (![EDUserStore get]) {
        LoginVC *login = [[LoginVC alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    } else {
        
        IndexVC *index = [[IndexVC alloc] init];
        [self.navigationController pushViewController:index animated:NO];
    }
}

@end
