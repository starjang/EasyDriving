//
//  NewsCell.m
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "NewsCell.h"
#import "EDNews.h"
#import "BaseHeader.h"
#import <UIImageView+WebCache.h>

@interface NewsCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *bottomLineLab;

@end

@implementation NewsCell

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
    
    [self initTitleView];
    [self initImgView];
    [self initContentView];
    [self initTimeView];
    [self initBottomLineView];
}

- (void)initTitleView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:fontBig + 1];
    self.titleLab.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.top.mas_equalTo(iUnitPoint10);
        make.height.mas_equalTo(iUnitPoint10 * 3);
    }];
    
}

- (void)initImgView {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.clipsToBounds = YES;
    self.imgView.layer.cornerRadius = 3;
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(iUnitPoint10/2);
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.size.mas_equalTo(iUnitPoint10 * 8);
    }];
}

- (void)initContentView {
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = [UIFont systemFontOfSize:fontSmall];
    self.contentLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(0);
    make.left.mas_equalTo(self.imgView.mas_right).mas_offset(iUnitPoint10);
        make.centerY.mas_equalTo(self.imgView);
        make.right.mas_equalTo(-iUnitPoint10 * 6);
        make.height.mas_equalTo(iUnitPoint10 * 6);
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

- (void)initTimeView {
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:fontSmall-1];
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    [self.contentView addSubview:self.timeLab];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(iUnitPoint10 * 2);
        make.right.mas_equalTo(-iUnitPoint10 * 2);
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(iUnitPoint10);
        make.height.mas_equalTo(iUnitPoint10 * 2);
    }];
}

- (void)update:(EDNews *)news {
    
    self.titleLab.text = news.title;
    self.contentLab.text = news.content;
    self.timeLab.text = news.createTime;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:news.imgUrl] placeholderImage:[UIImage imageNamed:@"home_maintenance"]];
}

@end
