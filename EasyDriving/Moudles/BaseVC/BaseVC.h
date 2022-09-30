//
//  BaseVC.h
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController

-(void)setNavTitle:(NSString *)title;

-(void)showTabBar;

-(void)hideTabBar;

-(void)showStatusBar;

-(void)hideStatusBar;

-(void)showNavigationBar;

-(void)hideNavigationBar;

-(void)showDefaultStatusBarContent;

-(void)showLigthStatusBarContent;

-(void)setDefaultNavigationBarStyle;

-(void)openInteractivePopGesture;

-(void)closeInteractivePopGesture;

- (void)beginCircleProgress;

- (void)beginCicleProgressWithBg;

- (void)endProgress;

@end

NS_ASSUME_NONNULL_END
