//
//  RegisterView.h
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDUserInfo;

NS_ASSUME_NONNULL_BEGIN

typedef void (^RegisterBlock)(EDUserInfo *userInfo);
typedef void (^LoginBlock)(void);

@interface RegisterView : UIView

@property (nonatomic, copy) LoginBlock loginBlocked;
@property (nonatomic, copy) RegisterBlock registerBlocked;

- (instancetype)initWithDefaultFrame:(CGRect)destFrame;

@end

NS_ASSUME_NONNULL_END
