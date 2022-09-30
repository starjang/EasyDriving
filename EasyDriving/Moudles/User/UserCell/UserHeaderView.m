//
//  UserHeaderView.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "UserHeaderView.h"
#import "BaseHeader.h"
#import "EDUserStore.h"
#import "EDUserInfo.h"

static CGFloat const kUserHeaderImgSize = 70;

@interface UserHeaderView()

@property (nonatomic, assign) CGRect destFrame;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIImageView *userImgView;
@property (nonatomic, strong) UILabel *welcomeLab;

@end

@implementation UserHeaderView

- (instancetype)initWithDefaultFrame:(CGRect)frame {
    
    UserHeaderView *headerView = [[UserHeaderView alloc]initWithFrame:frame];
    headerView.destFrame = frame;
    [headerView initViews];
    return headerView;
}

- (void)initViews {
    
    [self initBgImgView];
    [self initUserImgView];
    [self initWelcomeView];
}

- (void)initBgImgView {
    
    self.bgImgView = [[UIImageView alloc] init];
    self.bgImgView.frame = CGRectMake(0, 0, self.destFrame.size.width, self.destFrame.size.height);
    self.bgImgView.clipsToBounds = YES;
    self.bgImgView.image = [UIImage imageNamed:@"user_header_bg"];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;

    [self addSubview:self.bgImgView];
}

- (void)initUserImgView {
    
    CGFloat shadowBorder = 4;
    
    self.shadowView = [[UIView alloc] init];
    self.shadowView.frame = CGRectMake(self.center.x - (kUserHeaderImgSize + shadowBorder * 2)/2, self.center.y - (kUserHeaderImgSize + shadowBorder * 2)/1.5, kUserHeaderImgSize + shadowBorder * 2, kUserHeaderImgSize + shadowBorder * 2);
    self.shadowView.clipsToBounds = YES;
    self.shadowView.layer.cornerRadius = kUserHeaderImgSize/2 + shadowBorder;
    self.shadowView.backgroundColor = [UIColor colorWithHexString:e_textreversecolor withAlpha:0.5];
    [self addSubview:self.shadowView];
    
    //    [self.shadowView showPlaceHolderWithLineColor:[UIColor redColor]];
    
    self.userImgView = [[UIImageView alloc] init];
    self.userImgView.frame = CGRectMake(shadowBorder, shadowBorder, kUserHeaderImgSize, kUserHeaderImgSize);
    self.userImgView.clipsToBounds = YES;
    self.userImgView.contentMode = UIViewContentModeScaleToFill;
    self.userImgView.layer.cornerRadius = kUserHeaderImgSize/2;
    self.userImgView.image = [UIImage imageNamed:@"user_header"];
    [self.shadowView addSubview:self.userImgView];

}

- (void)initWelcomeView {
    
    self.welcomeLab = [[UILabel alloc] init];
    self.welcomeLab.frame = CGRectMake(0, self.shadowView.frame.origin.y + self.shadowView.frame.size.height + iUnitPoint10 * 1.5, iScreenWidth, iUnitPoint10 * 3);
    self.welcomeLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.welcomeLab.textAlignment = NSTextAlignmentCenter;
    self.welcomeLab.font = [UIFont boldSystemFontOfSize:fontBig + 1];
    self.welcomeLab.text = [NSString stringWithFormat:@"Hello, %@", [EDUserStore get].nickname];
    [self addSubview:self.welcomeLab];
    
}

- (void)updateNickname:(NSString *)nickname {
    
    self.welcomeLab.text = [NSString stringWithFormat:@"Hello, %@", nickname];

}

@end
