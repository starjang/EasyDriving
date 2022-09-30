//
//  UserCell.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "UserCell.h"
#import "BaseHeader.h"
#import "UserItem.h"

@interface UserCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UILabel *bottomLineLab;

@end

@implementation UserCell

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
    [self initArrowImgView];
    [self initContentView];
    [self initDescView];
    [self initBottomLineView];
}

- (void)initLeftImgView {
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iUnitPoint10);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(iUnitPoint10 * 3);
    }];
    
//    [self.imgView showPlaceHolderWithLineColor:[UIColor redColor]];
    
}

- (void)initArrowImgView {
    
    self.arrowImgView = [[UIImageView alloc] init];
    self.arrowImgView.image = [OnlineImage getIcon:@"ion-ios-arrow-right" hexColor:e_normalgraycolor size:20];
    self.arrowImgView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.arrowImgView];
    
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-iUnitPoint10);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(iUnitPoint10 * 5);
    }];
}

- (void)initContentView {
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = [UIFont systemFontOfSize:fontMiddle];
    self.contentLab.textColor = [UIColor colorWithHexString:e_primaryblackcolor];
    [self.contentView addSubview:self.contentLab];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.imgView.mas_right).mas_offset(iUnitPoint10);
        make.centerY.height.mas_equalTo(self.contentView);
        make.width.mas_equalTo(iUnitPoint10 * 12);
    }];
    
//    [self.contentLab showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initDescView {
    
    self.descLab = [[UILabel alloc] init];
    self.descLab.font = [UIFont systemFontOfSize:fontSmall];
    self.descLab.textColor = [UIColor colorWithHexString:e_lettercolor_desc];
    self.descLab.textAlignment = NSTextAlignmentRight;
    self.descLab.hidden = YES;
    [self.contentView addSubview:self.descLab];
    
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(self.arrowImgView.mas_left);
        make.centerY.height.mas_equalTo(self.contentView);
        make.width.mas_equalTo(iUnitPoint10 * 10);
    }];
    
//    [self.descLab showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)initBottomLineView {
    self.bottomLineLab = [[UILabel alloc] init];
    self.bottomLineLab.backgroundColor = [UIColor colorWithHexString:e_sectioncolor];
    [self.contentView addSubview:self.bottomLineLab];
    
    [self.bottomLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iUnitPoint10);
        make.right.mas_equalTo(-iUnitPoint10);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)update:(UserItem *)item {
    
    self.imgView.image = [OnlineImage getIcon:item.imgStr hexColor:e_primaryimgcolor size:20];
    self.contentLab.text = item.contentStr;
    self.imgView.contentMode = UIViewContentModeCenter;
    
    if (item.itemId == CLEAN_CACHE) {
        
        self.descLab.hidden = NO;
        
        NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
        if (cacheSize/1000.0 >= 1.0){
            self.descLab.text = [NSString stringWithFormat:@"%.2fM", cacheSize/1000.0/1000.0];
        }
        else{
            self.descLab.text = [NSString stringWithFormat:@"%.2fK", cacheSize/1000.0];
        }
        
    } else {
        self.descLab.hidden = YES;
    }
}

@end
