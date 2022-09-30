//
//  UserHeaderView.h
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UserHeaderHeight iScreenWidth/2

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderView : UIView

@property (nonatomic, strong) UIImageView *bgImgView;

- (instancetype)initWithDefaultFrame:(CGRect)frame;

- (void)updateNickname:(NSString *)nickname;

@end

NS_ASSUME_NONNULL_END
