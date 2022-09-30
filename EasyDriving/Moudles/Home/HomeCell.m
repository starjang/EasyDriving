//
//  HomeCell.m
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "HomeCell.h"
#import "BaseHeader.h"
#import "HomeItem.h"

@interface HomeCell ()

@property (nonatomic, strong) UIView *outsideView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation HomeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self initOutsideView];
    [self initBgImgView];
    [self initTitleView];
}

- (void)initOutsideView {
    
    self.outsideView = [[UIView alloc] init];
    self.outsideView.clipsToBounds = YES;
    self.outsideView.layer.cornerRadius = iUnitPoint10 * 8.5 / 2;
    [self addSubview:self.outsideView];
    
    [self.outsideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(-iUnitPoint10 * 2.5);
        make.size.mas_equalTo(iUnitPoint10 * 8.5);
    }];
    
    self.outsideView.layer.shouldRasterize = YES;
    self.outsideView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)initBgImgView {
    
    self.bgImgView = [[UIImageView alloc] init];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.outsideView addSubview:self.bgImgView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.outsideView);
        make.size.mas_equalTo(iUnitPoint10 * 4);
    }];
}

- (void)initTitleView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:fontMiddle];
    self.titleLab.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.outsideView.mas_bottom).mas_equalTo(iUnitPoint10);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
}

- (void)update:(HomeItem *)item {
    
    self.outsideView.backgroundColor = [UIColor colorWithHexString:item.bgColor];
    self.bgImgView.image = [UIImage imageNamed:item.img];
    self.titleLab.text = item.title;
}

@end
