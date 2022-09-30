//
//  POICell.m
//  EasyDriving
//
//  Created by Mason on 2018/12/18.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "POICell.h"
#import "BaseHeader.h"

@interface POICell ()

@property (nonatomic, strong) UILabel *topLineLab;
@property (nonatomic, strong) UILabel *bottomLineLab;
@property (nonatomic, strong) UIView *navView;


@end

@implementation POICell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    
    [self initPalceNameView];
    [self initPlaceDistanceView];
    [self initPlaceLocationView];
    [self initOrderBtnView];
    [self initNavigationView];
    [self initTelView];
    [self initBottomLineView];
}

- (void)initPalceNameView {
    
    self.placeName = [[UILabel alloc] init];
    self.placeName.textAlignment = NSTextAlignmentLeft;
    self.placeName.font = [UIFont boldSystemFontOfSize:fontMiddle];
    self.placeName.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    [self.contentView addSubview:self.placeName];
    
    [self.placeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iUnitPoint10);
        make.left.mas_equalTo(iUnitPoint10);
        make.width.mas_equalTo(iUnitPoint10 * 22);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
}

- (void)initBottomLineView {
    
    self.bottomLineLab = [[UILabel alloc] init];
    self.bottomLineLab.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.contentView addSubview:self.bottomLineLab];
    
    [self.bottomLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)initPlaceDistanceView {
 
    self.placeDistance = [[UILabel alloc] init];
    self.placeDistance.textAlignment = NSTextAlignmentLeft;
    self.placeDistance.font = [UIFont systemFontOfSize:fontSmall - 1];
    self.placeDistance.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    [self.contentView addSubview:self.placeDistance];
    
    [self.placeDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeName.mas_bottom).mas_equalTo(iUnitPoint10/2);
        make.left.mas_equalTo(iUnitPoint10);
        make.width.mas_equalTo(iUnitPoint10 * 6);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
    
//    [self.placeDistance showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initPlaceLocationView {
    
    self.placeLocation = [[UILabel alloc] init];
    self.placeLocation.textAlignment = NSTextAlignmentLeft;
    self.placeLocation.font = [UIFont systemFontOfSize:fontSmall - 1];
    self.placeLocation.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.placeLocation.numberOfLines = 0;
    [self.contentView addSubview:self.placeLocation];
    
    [self.placeLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeName.mas_bottom);        make.left.mas_equalTo(self.placeDistance.mas_right).mas_equalTo(iUnitPoint10/2);
        make.width.mas_equalTo(iUnitPoint10 * 15);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
//    [self.placeLocation showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initOrderBtnView {
    
    UIImage *orderImg = [[UIImage imageNamed:@"home_poi_order"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderBtn setBackgroundImage:orderImg forState:UIControlStateNormal];
//    self.orderBtn.tintColor = [UIColor colorWithHexString:@"#289efc"];
    [self.contentView addSubview:self.orderBtn];

    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.placeLocation.mas_right).mas_offset(iUnitPoint10 * 1.5);
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(iUnitPoint10 * 3);
    }];
    
    [self.orderBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.orderBtn showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initNavigationView {
    
    self.navView = [[UIView alloc] init];
    [self.contentView addSubview:self.navView];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.orderBtn.mas_right).mas_offset(iUnitPoint10);
        make.centerY.mas_equalTo(self.contentView).mas_offset(2);
        make.width.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationClick)];
    [self.navView addGestureRecognizer:tapGr];
    
    
    UIImage *navImg = [[UIImage imageNamed:@"home_poi_nav"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *navImgView = [[UIImageView alloc] initWithImage:navImg];
    navImgView.contentMode = UIViewContentModeScaleAspectFit;
    navImgView.clipsToBounds = YES;
    [self.navView addSubview:navImgView];
    
    [navImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(iUnitPoint10 * 2.3);
    }];
    
    
    UILabel *navLab = [[UILabel alloc] init];
    navLab.textColor = [UIColor colorWithRed:0.157 green:0.620 blue:0.988 alpha:1.00];
    navLab.text = @"去这里";
    navLab.textAlignment = NSTextAlignmentCenter;
    navLab.font = [UIFont systemFontOfSize:fontSmall - 1];
    [self.navView addSubview:navLab];
    
    [navLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.navView);
        make.height.mas_equalTo(iUnitPoint10 * 1.5);
    }];
}

- (void)initTelView {

    self.telView = [[UIView alloc] init];
    [self.contentView addSubview:self.telView];
    
    [self.telView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.navView.mas_right).mas_offset(iUnitPoint10/2);
        make.centerY.mas_equalTo(self.navView).mas_offset(-1);
        make.width.height.mas_equalTo(iUnitPoint10 * 4.1);
    }];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telClick)];
    [self.telView addGestureRecognizer:tapGr];
    
    
    UIImage *telImg = [[UIImage imageNamed:@"home_poi_tel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *telImgView = [[UIImageView alloc] initWithImage:telImg];
    telImgView.contentMode = UIViewContentModeScaleAspectFill;
    telImgView.clipsToBounds = YES;
    [self.telView addSubview:telImgView];
    
    [telImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(iUnitPoint10 * 2.5);
    }];
    
    
    UILabel *telLab = [[UILabel alloc] init];
    telLab.textColor = [UIColor colorWithRed:0.157 green:0.620 blue:0.988 alpha:1.00];
    telLab.text = @"电话";
    telLab.textAlignment = NSTextAlignmentCenter;
    telLab.font = [UIFont systemFontOfSize:fontSmall - 1];
    [self.telView addSubview:telLab];
    
    [telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.telView);
        make.height.mas_equalTo(iUnitPoint10 * 1.5);
    }];
}

- (void)orderClick {

    if ([self.delegate respondsToSelector:@selector(poiOrderInRow:)]) {
        [self.delegate poiOrderInRow:self.row];
    }
}

- (void)telClick {
    
    if ([self.delegate respondsToSelector:@selector(poiCallMerchant:)]) {
        [self.delegate poiCallMerchant:self.phoneNumber];
    }
}

- (void)navigationClick {
    
    if ([self.delegate respondsToSelector:@selector(poiToNavigationInRow:)]) {
        [self.delegate poiToNavigationInRow:self.row];
    }
}

@end
