//
//  PointsCell.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "PointsCell.h"
#import "BaseHeader.h"
#import "EDUserPoints.h"

@interface PointsCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *nameLineLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UILabel *timeLineLab;
@property (nonatomic, strong) UILabel *pointsLab;
@property (nonatomic, strong) UILabel *bottomLineLab;

@end

@implementation PointsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    
    return self;
}

- (void)initData {
    
}

- (void)initViews {
    
    [self initLeftImgView];
    [self initNameView];
    [self initNameLineView];
    [self initDescView];
    [self initTimeView];
    [self initTimeLineView];
    [self initBottomLineView];
}

- (void)initLeftImgView {
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.top.mas_equalTo(iUnitPoint10 * 2);
        make.size.mas_equalTo(iUnitPoint10 * 2);
    }];
    self.imgView.image = [OnlineImage getIcon:@"ion-ios-time" hexColor:e_primaryimgcolor size:20];
}

- (void)initNameView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:fontBig + 1];
    self.nameLab.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    [self.contentView addSubview:self.nameLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.imgView.mas_right).mas_offset(iUnitPoint10);
        make.centerY.mas_equalTo(self.imgView);
        make.right.mas_equalTo(-iUnitPoint10 * 6);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
}

- (void)initNameLineView {
    
    self.nameLineLab = [[UILabel alloc] init];
    self.nameLineLab.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.contentView addSubview:self.nameLineLab];
    
    [self.nameLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.nameLab.mas_bottom).mas_offset(iUnitPoint10 / 2);
    }];
}

- (void)initDescView {
    
    self.descLab = [[UILabel alloc] init];
    self.descLab.font = [UIFont systemFontOfSize:fontSmall];
    self.descLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.descLab.numberOfLines = 0;
    [self.contentView addSubview:self.descLab];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLineLab.mas_bottom).mas_offset(iUnitPoint10);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 6);
        make.width.mas_equalTo(iUnitPoint10 * 3);
        make.height.mas_equalTo(iUnitPoint10 * 4);
    }];
    //    [self.descLab showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initTimeView {
    
    self.pointsLab = [[UILabel alloc] init];
    self.pointsLab.font = [UIFont systemFontOfSize:fontSmall-1];
    self.pointsLab.textAlignment = NSTextAlignmentLeft;
    self.pointsLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    [self.contentView addSubview:self.pointsLab];
    
    [self.pointsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(iUnitPoint10 * 2);
        make.bottom.mas_equalTo(-iUnitPoint10);
    }];
}


- (void)initTimeLineView {
    
    self.timeLineLab = [[UILabel alloc] init];
    self.timeLineLab.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.contentView addSubview:self.timeLineLab];
    
    [self.timeLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.pointsLab.mas_top).mas_offset(-iUnitPoint10/2);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.height.mas_equalTo(1);
    }];
}


- (void)initBottomLineView {
    
    self.bottomLineLab = [[UILabel alloc] init];
    self.bottomLineLab.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.contentView addSubview:self.bottomLineLab];
    
    [self.bottomLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(3);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)updateData:(EDUserPoints *)point {
    
    self.nameLab.text = point.placeName;
    self.descLab.text = point.placeAddress;
    self.pointsLab.text = [NSString stringWithFormat:@"积分：%ld", point.points];
}

@end
