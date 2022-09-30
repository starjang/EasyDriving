//
//  LoginView.h
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LoginBlock)(NSString *name, NSString *pwd);
typedef void (^RegisterBlock)(void);

@interface LoginView : UIView

@property (nonatomic, copy) LoginBlock loginBlocked;
@property (nonatomic, copy) RegisterBlock registerBlocked;

- (instancetype)initWithDefaultFrame:(CGRect)destFrame;

@end

NS_ASSUME_NONNULL_END
